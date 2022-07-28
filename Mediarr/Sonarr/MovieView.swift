//
//  ShowGridView.swift
//  Mediarr v2
//
//  Created by David Sudar on 11/6/2022.
//

import SwiftUI
import Foundation

struct MovieView: View {
    @State var movie: Movie
    
    var body: some View {
        ZStack {
            AsyncImage(
                url: URL(string: movie.images.first(where: {$0.coverType == "banner"})?.url ?? movie.images.first(where: {$0.coverType == "fanart"})?.url ?? "https://artworks.thetvdb.com/banners/graphical/78650-g2.jpg"),
                content: { image in
                    image.renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .opacity(0.2)
                        .overlay(MovieInformationView(movie: movie), alignment: .leading)
                    
                },
                placeholder: {
                    ProgressView()
                }
            )
        }
    }
}

struct MovieInformationView: View {
    @State var movie: Movie
    
    var body: some View {
        HStack(spacing: 10) {
            Image("Question Mark Poster")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 45, height: 70)
                .clipped()
                .cornerRadius(8)
                .overlay(
                    AsyncImage(
                        url: URL(string: movie.images.first(where: {$0.coverType == "poster"})?.url ?? ""),
                        content: { image in
                            image.renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 45, height: 70)
                                .clipped()
                                .cornerRadius(8)
                            
                        },
                        placeholder: {
                            //                    ProgressView()
                        }
                    ))
            VStack(alignment: .leading, spacing: 2) {
                Text(movie.title)
                    .font(.system(size: 16, weight: .medium, design: .default))
                
                HStack {
                    Text(String(movie.year))
                    Text("|")
                    Text(String(movie.runtime) + "min" )
                    Text("|")
                    Text(movie.studio)
                }.font(.system(size: 12, weight: .light, design: .default))
                
//                HStack {
//                    Text(show.network)
//                    Text("|")
//                    Text(GetNextAiring(date: show.nextAiring) ?? "Unknown")
//                }.font(.system(size: 12, weight: .light, design: .default))
            }
        }
        .padding(5)
    }
}
