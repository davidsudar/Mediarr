//
//  SonarrView.swift
//  Mediarr v2
//
//  Created by David Sudar on 7/6/2022.
//

import SwiftUI
import Foundation



struct SonarrView: View {
    @StateObject var vm: SonarrViewModel
    @EnvironmentObject var settings: SettingsStore
    @State var searchText: String = ""
    @State var sortMode: sortModeViewModel = .alphabetical
    @State var gridView: GridLayoutViewModel = .blockView
    @State var columns: [GridItem] = [GridItem()]
    @State var showingDetail = false
    @State var selectedShow: Series? = previewSeries
    
    var body: some View {
        VStack(alignment: .leading)
        {
            ItemNavigationView(searchText: $searchText, sortMode: $sortMode, gridView: $gridView)
                .onChange(of: sortMode) { newValue in
                    withAnimation(.easeInOut(duration: 0.8))
                    {
                        if sortMode == .alphabetical
                        {
                            vm.shows = vm.shows.sorted { $0.title < $1.title }
                        }
                        else if sortMode == .network
                        {
                            vm.shows = vm.shows.sorted { $0.network < $1.network }
                        }
                        else if sortMode == .nextAiring
                        {
                            vm.shows = vm.shows.sorted { $0.nextAiring ?? #"2999-06-16T00:00:00Z"# < $1.nextAiring ?? #"2999-06-16T00:00:00Z"# }
                        }
                        else if sortMode == .episodes
                        {
                            // TODO toggle ascending and descending
                            vm.shows = vm.shows.sorted { GetEpisodePercentage(onDisk: $0.statistics.episodeFileCount, episodeCount: $0.statistics.episodeCount) > GetEpisodePercentage(onDisk: $1.statistics.episodeFileCount, episodeCount: $1.statistics.episodeCount) }
                        }
                    }
                }
                .onChange(of: gridView) { newValue in
                    withAnimation(.easeInOut(duration: 0.5))
                    {
                        if gridView == .blockView
                        {
                            columns = [
                                GridItem(),
                            ]
                        }
                        else {
                            columns = [
                                GridItem(),
                                GridItem(),
                                GridItem(),
                            ]
                        }
                    }
                }
                .background(Color("Secondary"))
            RefreshableScroll(tintColor: Color.accentColor, content:{
                if vm.shows.count == 0 {
                    HStack {
                        Spacer()
                        LoadingAnimation()
                        Spacer()
                        
                    }
                }
                else {
                    LazyVGrid(columns: self.columns, alignment: .leading, spacing: 4, content: {                        
                        ForEach(vm.shows.filter({
                            "\($0.title)".contains(searchText) || searchText.isEmpty
                        }), id:\.id) { show in
                            if gridView == .blockView
                            {
                                ShowView(show: show)
                            }
                            else
                            {
                                ShowGridView(show: show)
                            }
                        }

                    })
                    
                    .padding(.horizontal, 12)
                    .modifier(BackgroundColorStyle())
                }
            })
            {
                vm.getShows(with: settings)
                do {
                    try await Task.sleep(nanoseconds: 2_000_000_000)
                }
                
                catch{
                    print("error")
                }
            }
        }
        .modifier(BackgroundColorStyle())
        
        
        
    }
    func updateNavigationBarColor() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = .clear
        navigationBarAppearance.backgroundColor = UIColor(named: "Secondary")
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}

struct SonarrView_Previews: PreviewProvider {
    static var previews: some View {
        SonarrView(vm: SonarrViewModel())
    }
}


