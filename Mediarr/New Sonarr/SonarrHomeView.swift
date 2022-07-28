//
//  TestSonarrHomeView.swift
//  Mediarr
//
//  Created by David Sudar on 12/7/2022.
//

import SwiftUI

struct SonarrHomeView: View {
    @EnvironmentObject var settings: SettingsStore
    @StateObject var vm = SonarrViewModel()
    
    init() {
        configureScrollEdgeAppearance()
    }
    
    var body: some View {
        ZStack {
            Color("Primary").ignoresSafeArea()
            VStack {
                TabView() {
                    SonarrView(vm: vm)
                        .environmentObject(settings)
                        .tabItem {
                            Label("Series", systemImage: "tv")
                        }
                    NextAiringView(vm: vm)
                        .environmentObject(settings)
                        .tabItem {
                            Label("Up Next", systemImage: "calendar")
                        }
                    MissingSeriesView(vm: vm)
                        .environmentObject(settings)
                        .tabItem {
                            Label("Missing", systemImage: "magnifyingglass")
                        }
                    Text("More")
                        .tabItem {
                            Label("More", systemImage: "ellipsis")
                        }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .onAppear(perform: {
                    vm.getRootFolders(with: settings)
                    vm.getQualityProfiles(with: settings)
                    vm.GetLanguageProfiles(with: settings)
                    vm.getShows(with: settings)                    
                    vm.getUpcoming(with: settings, endDate: nil)
                    vm.getMissingShows(with: settings)
                    
                })
                .toolbar(content: {
                    AddButton(destination: AddNewShow(vm: vm).environmentObject(settings))
                })
                
            }
            .navigationTitle("Sonarr")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
    
    
        
    
}

struct AddButton<Destination : View>: View {
    
    var destination:  Destination
    
    var body: some View {
        NavigationLink(destination: self.destination) { Image(systemName: "plus").foregroundColor(Color.accentColor) }
    }
}

struct SonarrHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SonarrHomeView()
    }
}
