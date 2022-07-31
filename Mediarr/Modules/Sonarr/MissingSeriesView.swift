//
//  MissingSeriesView.swift
//  Mediarr
//
//  Created by David Sudar on 15/7/2022.
//

import SwiftUI

struct MissingSeriesView: View {
    @StateObject var vm: SonarrViewModel
    @EnvironmentObject var settings: SettingsStore
    @State private var showToast = false
    @State private var searchShow: MissingRecord? = nil
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.missing?.records ?? [], id: \.self) { missing in
                    MissingShowView(show: missing)
                        .overlay(
                            HStack{
                                Spacer()
                                Button(action: {
                                    searchShow = missing
                                    showToast = true
                                    vm.searchMissing(with: settings, ids: [missing.id])
                                }, label: {
                                    Image(systemName: "magnifyingglass")
                                })
                            }.padding()
                        )
                }
            }
            .onAppear(perform: {
                vm.getMissingShows(with: settings)
            })
            .toast(message: "Searching for show \(searchShow?.series.title ?? "..."), Season \(searchShow?.seasonNumber ?? 0), Episode\(searchShow?.episodeNumber ?? 0)",
                   isShowing: $showToast,
                   duration: Toast.short)
        }
        .padding()
}
}

struct MissingSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = SonarrViewModel()
        MissingSeriesView(vm: vm)
    }
}
