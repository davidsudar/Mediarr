//
//  TransmissionViewModel.swift
//  Mediarr
//
//  Created by David Sudar on 29/7/2022.
//

import SwiftUI
import Foundation
import Combine
import Transmission
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class TransmissionViewModel: ObservableObject {
    @Published var shows = [Torrent]()
    @Published var sessionStats: TransmissionSessionStatsArguments? = nil
    @State var sortMode: transmissionSortModeViewModel = .percentDone
    @Published var isSearchingInitial = false
    @State var isEditing = false
    
    
    @MainActor
    func getShows(with settings: SettingsStore) {
        let info = makeConfig(server: settings.transmissionHost, port: settings.transmissionPort, username: settings.transmissionUsername, password: settings.transmissionPassword)

        getTorrents(config: info.config, auth: info.auth, onReceived: { torrents, err in
            if (err != nil) {
                print("Showing error...")
            } else if (torrents == nil) {
                print("torrents == nil")
            } else {
                DispatchQueue.main.async{
                        let sortedTorrents = torrents!.sorted { $0.queuePosition < $1.queuePosition }
                        for show in sortedTorrents {
                            if let row = self.shows.firstIndex(where: {$0.id == show.id}) {
                                if !self.isEditing {
                                    self.shows[row].percentDone = show.percentDone
                                    self.shows[row].downloadSpeed = show.downloadSpeed
                                    self.shows[row].downloadedEver = show.downloadedEver
                                    self.shows[row].leftUntilDone = show.leftUntilDone
                                }
                            } else {
                                self.shows.append(show)
                            }
                        }
                    self.isSearchingInitial = false
                }
                self.getShows(with: settings)
            }
        })
    }
    
    @MainActor
    func getSession(with settings: SettingsStore) {
        let info = makeConfig(server: settings.transmissionHost, port: settings.transmissionPort, username: settings.transmissionUsername, password: settings.transmissionPassword)
        
        getSessionStats(config: info.config, auth: info.auth, onResponse: { stats in
            DispatchQueue.main.async{
                self.sessionStats = stats
            }
            self.getSession(with: settings)
        })
    }
    
    func pauseAll(with settings: SettingsStore) {
        let info = makeConfig(server: settings.transmissionHost, port: settings.transmissionPort, username: settings.transmissionUsername, password: settings.transmissionPassword)
        
        playPauseAll(start: false, info: info, onResponse: {_ in
            print("response to be updated")
        })
        
    }
    
    func playPauseSelected(with settings: SettingsStore, selected: Torrent) {
        let info = makeConfig(server: settings.transmissionHost, port: settings.transmissionPort, username: settings.transmissionUsername, password: settings.transmissionPassword)
        
        playPause(torrent: selected, config: info.config, auth: info.auth, onResponse: {_ in
            print("response to be updated")
        })
        
    }
    func deleteSelected(with settings: SettingsStore, selected: Torrent) {
        let info = makeConfig(server: settings.transmissionHost, port: settings.transmissionPort, username: settings.transmissionUsername, password: settings.transmissionPassword)
        
        deleteTorrent(torrent: selected, erase: true, config: info.config, auth: info.auth, onDel: {_ in
            print("response to be updated")
        })
        
    }
    
    func setPrioritySelected(with settings: SettingsStore, selected: Torrent, priority: TorrentPriority) {
        let info = makeConfig(server: settings.transmissionHost, port: settings.transmissionPort, username: settings.transmissionUsername, password: settings.transmissionPassword)
        
        setPriority(torrent: selected, priority: priority, info: info, onComplete: {_ in
            print("response to be updated")
        })
        
    }
    func increaseQueuePosition(with settings: SettingsStore, selected: Torrent) {
        let info = makeConfig(server: settings.transmissionHost, port: settings.transmissionPort, username: settings.transmissionUsername, password: settings.transmissionPassword)
        
        Mediarr.increaseQueuePosition(torrent: selected, info: info, onComplete: {_ in
            print("response to be updated")
        })
        
    }
    
    
}
