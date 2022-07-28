//
//  DetailedShowHomeView.swift
//  Mediarr v2
//
//  Created by David Sudar on 21/6/2022.
//

import SwiftUI

struct DetailedShowHomeView: View {
    @State var show: Series
    var body: some View {
            VStack {
                TabView() {
                    DetailedShowView(show: show)
                        .tabItem {
                            Label("Details", systemImage: "tv")
                        }
                        .modifier(BackgroundColorStyle())
                    Text("Missing")
                        .tabItem {
                            Label("Missing", systemImage: "magnifyingglass")
                        }
                }
                
            }
            .modifier(BackgroundColorStyle())
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailedShowHomeView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedShowHomeView(show: previewSeries)
    }
}
