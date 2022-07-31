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
    @State var isShowingMoreSheet = false
    @State private var showUpdateAllToast = false
    
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
                    Button(action: {
                        self.isShowingMoreSheet = true
                    }, label: {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.accentColor)
                    })
                })
                .sheet(isPresented: $isShowingMoreSheet) {
                    VStack(spacing: 20){
                        Button(action: {
                            
                        }, label: {
                            HStack{
                                Image(systemName: "magnifyingglass")
                                Text("Search Monitored")
                            }.foregroundColor(.blue)
                        })
                        Button(action: {
                            vm.updateAll(with: settings)
                        }, label: {
                            HStack{
                                Image(systemName: "arrow.triangle.2.circlepath")
                                Text("Update All")
                            }.foregroundColor(.blue)
                        })
                        .toast(message: "Updating All Shows", isShowing: $showUpdateAllToast,
                                     duration: Toast.short)
                        Button(action: {
                            
                        }, label: {
                            HStack{
                                Image(systemName: "network")
                                Text("View Web GUI")
                            }.foregroundColor(.orange)
                        })
                    }
                    .presentationDetents([.medium, .large])
                }
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
