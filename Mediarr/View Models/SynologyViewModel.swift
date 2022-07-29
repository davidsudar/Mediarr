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
        
        let hostAndPort = "http://" + settings.nasHost + ":" + String(settings.nasPort)
        var strURL = """
        /webapi/auth.cgi?api=SYNO.API.Auth&version=3&method=login&account=
        """
        strURL = hostAndPort + strURL + settings.nasUsername + "&passwd=" + settings.nasPassword + "&session=FileStation&format=sid"
        let encoded = strURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        
        let url = URL(string: encoded ?? "")
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
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
        let hostAndPort = "http://" + settings.nasHost + ":" + String(settings.nasPort)
        var strURL = """
        /webapi/entry.cgi?api=SYNO.FileStation.List&version=2&method=list_share&additional=["volume_status"]&_sid=
        """
        strURL = hostAndPort + strURL + (auth?.data.sid ?? "")
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
        let hostAndPort = "http://" + settings.nasHost + ":" + String(settings.nasPort)
        var strURL = """
        /webapi/entry.cgi?api=SYNO.Core.System.Utilization&version=1&method=get&_sid=
        """
        strURL = hostAndPort + strURL + (auth?.data.sid ?? "")
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
                    
                    if self.rxHistory.count > 20 {
                        self.rxHistory.remove(at: 0)
                    }
                    
                    if self.txHistory.count > 20 {
                        self.txHistory.remove(at: 0)
                    }
                    
                    let upload = SynologyNetworkChartObject(type: "Upload", data: self.txHistory)
                    let download = SynologyNetworkChartObject(type: "Download", data: self.rxHistory)
                    
                    self.networkHistory = [upload, download]
                    
                }
            } catch {
                print("Failed to decode: \(error)")
            }
        }.resume()
    }
}

