//
//  AddNewShowDetailed.swift
//  Mediarr v2
//
//  Created by David Sudar on 21/6/2022.
//

import SwiftUI

struct AddNewShowDetailed: View {
    @StateObject var vm: SonarrViewModel
    @EnvironmentObject var settings: SettingsStore
    @Environment(\.dismiss) var dismiss
    @State private var showToast = false
    @State var newShow: SearchSeries
    @State var addShowObject: AddShowObject? = nil
    @State var seasonFolders: Bool = true
    @State var searchMissing: Bool = false
    @State var searchCutoff: Bool = false
    @State var selectedRootFolder: RootFolder? = nil
    @State var selectedMonitor: MonitorEnum = .all
    @State var selectedQualityProfile: QualityProfile? = nil
    @State var selectedLanguageProfile: LanguageProfile? = nil
    @State var selectedSeriesType: SeriesTypeEnum = .standard
    @State var selectedTags: [Tag] = [Tag]()
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("Primary").ignoresSafeArea()
            VStack{
                SearchShowView(show: newShow)
                    .padding()
                
                LazyVGrid(columns: [GridItem()], alignment: .leading, spacing: 10, content: {
                    
                    Menu {
                        ForEach(vm.rootFolders, id: \.self) { option in
                            Button {
                                selectedRootFolder = option
                            } label: {
                                Text(option.path)
                            }
                        }
                    } label: {
                        ZStack(alignment: .leading) {
                            Color("Secondary").ignoresSafeArea()
                            VStack(alignment: .leading){
                                Text("Root Folder")
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                
                                Text(selectedRootFolder?.path ?? "")
                                    .font(.system(size: 12, weight: .light, design: .default))
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                        }
                    }
                    .cornerRadius(8)
                    .tint(.white)
                    
                    
                    Menu {
                        ForEach(MonitorEnum.allCases, id: \.self) { option in
                            Button {
                                selectedMonitor = option
                            } label: {
                                Text(option.title)
                            }
                        }
                    } label: {
                        ZStack(alignment: .leading) {
                            Color("Secondary").ignoresSafeArea()
                            VStack(alignment: .leading){
                                Text("Monitor")
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                
                                Text(selectedMonitor.title)
                                    .font(.system(size: 12, weight: .light, design: .default))
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                        }
                    }
                    .cornerRadius(8)
                    .tint(.white)
                    
                    Menu {
                        ForEach(vm.qualityProfiles, id: \.self) { option in
                            Button {
                                selectedQualityProfile = option
                            } label: {
                                Text(option.name)
                            }
                        }
                    } label: {
                        ZStack(alignment: .leading) {
                            Color("Secondary").ignoresSafeArea()
                            VStack(alignment: .leading){
                                Text("Quality Profile")
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                
                                Text(selectedQualityProfile?.name ?? "")
                                    .font(.system(size: 12, weight: .light, design: .default))
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                        }
                    }
                    .cornerRadius(8)
                    .tint(.white)
                    
                    Menu {
                        ForEach(vm.languageProfiles, id: \.self) { option in
                            Button {
                                selectedLanguageProfile = option
                            } label: {
                                Text(option.name)
                            }
                        }
                    } label: {
                        ZStack(alignment: .leading) {
                            Color("Secondary").ignoresSafeArea()
                            VStack(alignment: .leading){
                                Text("Language Profile")
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                
                                Text(selectedLanguageProfile?.name ?? "")
                                    .font(.system(size: 12, weight: .light, design: .default))
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                        }
                    }
                    .cornerRadius(8)
                    .tint(.white)
                    
                    Menu {
                        ForEach(vm.qualityProfiles, id: \.self) { option in
                            Button {
                                selectedQualityProfile = option
                            } label: {
                                Text(option.name)
                            }
                        }
                    } label: {
                        ZStack(alignment: .leading) {
                            Color("Secondary").ignoresSafeArea()
                            VStack(alignment: .leading){
                                Text("Quality Profile")
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                
                                Text(selectedQualityProfile?.name ?? "")
                                    .font(.system(size: 12, weight: .light, design: .default))
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                        }
                    }
                    .cornerRadius(8)
                    .tint(.white)
                    
                    Menu {
                        ForEach(SeriesTypeEnum.allCases, id: \.self) { option in
                            Button {
                                selectedSeriesType = option
                            } label: {
                                Text(option.title)
                            }
                        }
                    } label: {
                        ZStack(alignment: .leading) {
                            Color("Secondary").ignoresSafeArea()
                            VStack(alignment: .leading){
                                Text("Series Type")
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                
                                Text(selectedSeriesType.title)
                                    .font(.system(size: 12, weight: .light, design: .default))
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                        }
                    }
                    .cornerRadius(8)
                    .tint(.white)
                    
                    ZStack(alignment: .leading) {
                        Color("Secondary").ignoresSafeArea()
                        Toggle("Season Folders", isOn: $seasonFolders)
                            .font(.system(size: 16, weight: .medium, design: .default))
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                    }
                    .cornerRadius(8)
                    
                    ZStack(alignment: .leading) {
                        Color("Secondary").ignoresSafeArea()
                        Toggle("Search Missing", isOn: $searchMissing)
                            .font(.system(size: 16, weight: .medium, design: .default))
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                    }
                    .cornerRadius(8)
                    
                    ZStack(alignment: .leading) {
                        Color("Secondary").ignoresSafeArea()
                        Toggle("Search Cutoff", isOn: $searchCutoff)
                            .font(.system(size: 16, weight: .medium, design: .default))
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                    }
                    .cornerRadius(8)

                    
                    
                    
                    
                })
                .padding()
                Spacer()
                
                Button(action: {
                    addShowObject = AddShowObject(title: newShow.title, titleSlug: newShow.titleSlug, rootFolderPath: selectedRootFolder?.path ?? "Data/TV Shows", seasons: newShow.seasons, profileId: newShow.profileId, tvdbId: newShow.id, qualityProfileId: selectedQualityProfile?.id ?? 0, languageProfileId: selectedLanguageProfile?.id ?? 0, addOptions: AddOptions(monitor: selectedMonitor.rawValue, searchForCutoffUnmetEpisodes: searchCutoff, searchForMissingEpisodes: searchMissing), seasonFolder: seasonFolders, monitored: true, images: newShow.images)
                    
                    vm.AddShows(with: settings, show: addShowObject!)
                    dismiss()
                    showToast.toggle()
                }, label: {
                    HStack{
                        Image(systemName: "plus")
                        Text("Add")
                    }
                })
            }
            .toast(message: newShow.title + " added to Sonarr",
                         isShowing: $showToast,
                         duration: Toast.short)
            .onAppear(){
                self.selectedRootFolder = vm.rootFolders[0]
                self.selectedQualityProfile = vm.qualityProfiles[0]
                self.selectedLanguageProfile = vm.languageProfiles[0]
            }
        }
    }
}

struct AddNewShowDetailed_Previews: PreviewProvider {
    static var previews: some View {
        AddNewShowDetailed(vm: SonarrViewModel(), newShow: SearchSeries(title: "Test Show", titleSlug: "", overview: "This will be the description of the test show", seasonCount: 2, year: 2017, id: 1, profileId: 0, images: [SonarrSearchImage(coverType: "banner", url: "https://artworks.thetvdb.com/banners/graphical/267440-g.jpg")], seasons: [SonarrSearchSeason(seasonNumber: 1, monitored: true)])).environmentObject(SettingsStore())
    }
}
