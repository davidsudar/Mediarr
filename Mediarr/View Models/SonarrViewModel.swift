//
//  SonarrViewModel.swift
//  Mediarr
//
//  Created by David Sudar on 18/7/2022.
//

import Foundation

class SonarrViewModel: ObservableObject {
    @Published var shows = [Series]()
    @Published var upcoming = [Upcoming]()
    @Published var upcomingDict = [String: [Upcoming]]()
    @Published var searchResults = [SearchSeries]()
    @Published var missing = [Missing]()
    @Published var isSearching = false
    @Published var rootFolders = [RootFolder]()
    @Published var qualityProfiles = [QualityProfile]()
    @Published var languageProfiles = [LanguageProfile]()
    @Published var tags = [Tag]()
    
    @MainActor
    func getRootFolders(with settings: SettingsStore) {
        guard let url = URL(string: "http://"+settings.sonarrHost+":"+String(settings.sonarrPort)+"/api/v3/rootfolder?apikey="+settings.sonarrApiKey) else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let rss = try JSONDecoder().decode([RootFolder].self, from: data)
                DispatchQueue.main.async{
                    self.rootFolders = rss
                }
            } catch {
                print("Failed to decode: \(error)")
            }
        }.resume()
    }
    
    @MainActor
    func getQualityProfiles(with settings: SettingsStore) {
        guard let url = URL(string: "http://"+settings.sonarrHost+":"+String(settings.sonarrPort)+"/api/profile?apikey="+settings.sonarrApiKey) else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let rss = try JSONDecoder().decode([QualityProfile].self, from: data)
                DispatchQueue.main.async{
                    self.qualityProfiles = rss
                }
            } catch {
                print("Failed to decode: \(error)")
            }
        }.resume()
    }
    
    @MainActor
    func GetLanguageProfiles(with settings: SettingsStore) {
        guard let url = URL(string: "http://"+settings.sonarrHost+":"+String(settings.sonarrPort)+"/api/v3/languageprofile?apikey="+settings.sonarrApiKey) else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let rss = try JSONDecoder().decode([LanguageProfile].self, from: data)
                DispatchQueue.main.async{
                    self.languageProfiles = rss
                }
            } catch {
                print("Failed to decode: \(error)")
            }
        }.resume()
    }
    
    func getTags(with settings: SettingsStore) {
        guard let url = URL(string: "http://"+settings.sonarrHost+":"+String(settings.sonarrPort)+"/api/v3/tag?apikey="+settings.sonarrApiKey) else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let rss = try JSONDecoder().decode([Tag].self, from: data)
                DispatchQueue.main.async{
                    self.tags = rss
                }
            } catch {
                print("Failed to decode: \(error)")
            }
        }.resume()
    }
    
    @MainActor
    func getShows(with settings: SettingsStore) {
        print(settings.sonarrApiKey)
        print("ApiKey above")
        guard let url = URL(string: "http://"+settings.sonarrHost+":"+String(settings.sonarrPort)+"/api/v3/series?apikey="+settings.sonarrApiKey) else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let rss = try JSONDecoder().decode([Series].self, from: data)
                DispatchQueue.main.async{
                    self.shows = rss
                    self.shows = self.shows.sorted { $0.title < $1.title }
                }
            } catch {
                print("Failed to decode: \(error)")
            }
        }.resume()
    }
    @MainActor
    func AddShows(with settings: SettingsStore, show: AddShowObject) {
        guard let url = URL(string: "http://"+settings.sonarrHost+":"+String(settings.sonarrPort)+"/api/v3/series?apikey="+settings.sonarrApiKey) else { return }
        print(url)
        do {
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try! encoder.encode(show)
            print(String(data: jsonData, encoding: .utf8)!)
            

            // create post request
            var request = URLRequest(url: url)
                    request.httpMethod = "POST"
            request.setValue("\(String(describing: jsonData.count))", forHTTPHeaderField: "Content-Length")
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.httpBody = jsonData
                    
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        print("-----> data: \(data!)")
                        print("-----> error: \(error!)")
                        
                        guard let data = data, error == nil else {
                            print(error?.localizedDescription ?? "No data")
                            return
                        }

                        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                        print("-----1> responseJSON: \(responseJSON ?? "")")
                        if let responseJSON = responseJSON as? [String: Any] {
                            print("-----2> responseJSON: \(responseJSON)")
                        }
                    }
                    
                    task.resume()
        }
    }
    
    @MainActor
    func getUpcoming(with settings: SettingsStore, endDate: Date?) {
        let toDate = endDate == nil ? Date().endOfMonth() : endDate
        
        let form = DateFormatter()
        form.dateFormat = "yyyy-MM-dd"
        let today = form.string(from:Date())
        let toDateString = form.string(from:Calendar.current.date(byAdding: .day, value: 1, to: toDate!)!)
        guard let url = URL(string: "http://"+settings.sonarrHost+":"+String(settings.sonarrPort)+"/api/calendar?apikey="+settings.sonarrApiKey+"&start=" + today + "&end=" + toDateString) else { return }

        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let rss = try JSONDecoder().decode([Upcoming].self, from: data)
                DispatchQueue.main.async{
                    self.upcoming = rss
                    self.upcoming = self.upcoming.sorted { $0.title < $1.title }
                    self.upcomingDict = SortUpcomingIntoDictionary(upcoming: self.upcoming)
                }
            } catch {
                print("Failed to decode: \(error)")
            }
        }.resume()
    }
        
    @MainActor
    func getMissingShows(with settings: SettingsStore) {
        
        guard let url = URL(string: "http://"+settings.sonarrHost+":"+String(settings.sonarrPort)+"/api/wanted/missing?apikey="+settings.sonarrApiKey) else { return }

        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let rss = try JSONDecoder().decode([Missing].self, from: data)
                DispatchQueue.main.async{
                    self.missing = rss
                }
            } catch {
                print("Failed to decode: \(error)")
            }
        }.resume()
    }
    
    @MainActor
    func searchShows(with settings: SettingsStore, searchTerm: String) {
        self.isSearching = true
        //modify search term to fit api call
        var search = ""
        if !searchTerm.contains("tvdb") {
            search = searchTerm.replacingOccurrences(of: " ", with: "%20")
        }
        else {
            search = searchTerm
        }
        
        
        
        guard let url = URL(string: "http://"+settings.sonarrHost+":"+String(settings.sonarrPort)+"/api/series/lookup?term=" + search + "&apikey=" + settings.sonarrApiKey) else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let rss = try JSONDecoder().decode([SearchSeries].self, from: data)
                DispatchQueue.main.async{
                    self.searchResults = rss
                    self.isSearching = false
                }
            } catch {
                print("Failed to decode: \(error)")
            }
        }.resume()
    }
    
}

