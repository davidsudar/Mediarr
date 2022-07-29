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
    var body: some View {
        VStack {
            Text("Missing")
            Button(action: {
                showToast.toggle()
            }, label: {
                Text("Show Toast")
            })
        }
        .toast(message: "Current time:\n\(Date().formatted(date: .complete, time: .complete))",
                     isShowing: $showToast,
                     duration: Toast.short)
    }
}

struct MissingSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        MissingSeriesView(vm: SonarrViewModel())
    }
}
