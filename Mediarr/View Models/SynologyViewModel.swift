//
//  SynologyViewModel.swift
//  Mediarr
//
//  Created by David Sudar on 19/7/2022.
//

import Foundation
import SwiftUI

class SynologyViewModel: ObservableObject {
    
    @Published var auth: SynologyAuth? = nil
    @Published var storage: SynologyStorage? = nil
    @Published var utilisation: SynologyUtilisation? = nil
    @Published var networkHistory = [SynologyNetworkChartObject]()
    @Published var rxHistory = [SynologyNetworkChartObjectData]()
    @Published var txHistory = [SynologyNetworkChartObjectData]()
    
    
    @MainActor
    func getSid(with settings: SettingsStore) {
        guard let url = URL(string: "http://192.168.1.2:5000/webapi/auth.cgi?api=SYNO.API.Auth&version=3&method=login&account=sudar&passwd=Avids2233%23&session=FileStation&format=sid") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let rss = try JSONDecoder().decode(SynologyAuth.self, from: data)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.auth = rss
                    print(rss.data.sid)
                }
            } catch {
                print("Failed to decode: \(error)")
            }
        }.resume()
    }
    
    @MainActor
    func getStorage(with settings: SettingsStore) {
        var strURL = """
        http://192.168.1.2:5000/webapi/entry.cgi?api=SYNO.FileStation.List&version=2&method=list_share&additional=["volume_status"]&_sid=
        """
        strURL = strURL + (auth?.data.sid ?? "")
        let encoded = strURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        
        let url = URL(string: encoded ?? "")
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let rss = try JSONDecoder().decode(SynologyStorage.self, from: data)
                DispatchQueue.main.async{
                    self.storage = rss
                }
            } catch {
                print("Failed to decode: \(error)")
            }
        }.resume()
    }
    
    @MainActor
    func getUtilisation(with settings: SettingsStore) {
        var strURL = """
        http://192.168.1.2:5000/webapi/entry.cgi?api=SYNO.Core.System.Utilization&version=1&method=get&_sid=
        """
        strURL = strURL + (auth?.data.sid ?? "")
        let encoded = strURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        
        let url = URL(string: encoded ?? "")
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let rss = try JSONDecoder().decode(SynologyUtilisation.self, from: data)
                DispatchQueue.main.async{
                    self.utilisation = rss
                    let network = rss.data.network.first(where: {$0.device == "total"})
                    
                    let now = Date()
                    let rxData = SynologyNetworkChartObjectData(date: now, speed: network?.rx ?? 0)
                    let txData = SynologyNetworkChartObjectData(date: now, speed: network?.tx ?? 0)
                    
                    self.rxHistory.append(rxData)
                    self.txHistory.append(txData)
                    var rxIndexesToRemove = [Int]()
                    var txIndexesToRemove = [Int]()
                    
                    for index in self.rxHistory.indices {

                        let diffs = Calendar.current.dateComponents([.minute], from: self.rxHistory[index].date, to: Date())

                        if diffs.minute ?? 0 >= 1 {
                            rxIndexesToRemove.append(index)
                        }
                    }

                    for index in self.txHistory.indices {

                        let diffs = Calendar.current.dateComponents([.minute], from: self.txHistory[index].date, to: Date())
                        if diffs.minute ?? 0 >= 1 {
                            txIndexesToRemove.append(index)
                        }
                    }
                    
                    for index in rxIndexesToRemove {
                        self.rxHistory.remove(at: index) //Not working. index out of range
                    }
                    
                    for index in txIndexesToRemove {
                        self.txHistory.remove(at: index)
                    }
                    
                    let x = SynologyNetworkChartObject(type: "Upload", data: self.txHistory)
                    let y = SynologyNetworkChartObject(type: "Download", data: self.rxHistory)
                    
                    self.networkHistory = [x, y]
                    
                }
            } catch {
                print("Failed to decode: \(error)")
            }
        }.resume()
    }
}

