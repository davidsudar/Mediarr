//
//  RefreshableScroll.swift
//  Mediarr v2
//
//  Created by David Sudar on 16/6/2022.
//

import SwiftUI

struct RefreshableScroll<Content: View>: View {
    var content: Content
    var onRefresh: () async ->()
    init(tintColor: Color, @ViewBuilder content: @escaping ()->Content, onRefresh: @escaping () async ->()){
        self.content = content()
        self.onRefresh = onRefresh
        UIRefreshControl.appearance().tintColor = UIColor(tintColor)
        UICollectionView.appearance().backgroundColor = .clear
    }
    var body: some View {
        List {
            content
                .listRowSeparatorTint(.clear)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .clipped() 
        .listStyle(.plain)
        .refreshable {
            await onRefresh()
        }
        
    }
}

struct RefreshableScroll_Previews: PreviewProvider {
    static var previews: some View {
        SonarrHomeView()
        
    }
}
