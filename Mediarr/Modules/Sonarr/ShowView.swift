//
//  ShowView.swift
//  Mediarr v2
//
//  Created by David Sudar on 10/6/2022.
//

import SwiftUI
import Foundation

struct ShowView: View {
    @State var show: Series
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: show.images.first(where: {$0.coverType == "banner"})?.remoteUrl ?? show.images.first(where: {$0.coverType == "fanart"})?.remoteUrl ?? "")) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .frame(maxWidth: .infinity, idealHeight: 80, maxHeight: .infinity)
                        .foregroundColor(.gray)
                        .cornerRadius(8)
                        .opacity(0.2)
                        .overlay(ShowInformationView(show: show), alignment: .leading)
                case .success(let image):
                    image
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .opacity(0.2)
                        .overlay(ShowInformationView(show: show), alignment: .leading)
                case .failure:
                    Rectangle()
                        .frame(maxWidth: .infinity, idealHeight: 80, maxHeight: .infinity)
                        .foregroundColor(.gray)
                        .cornerRadius(8)
                        .opacity(0.2)
                        .overlay(ShowInformationView(show: show), alignment: .leading)
                @unknown default:
                    Text("Unknown error. Please try again.")
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct ShowInformationView: View {
    @State var show: Series
    
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
                        url: URL(string: show.images.first(where: {$0.coverType == "poster"})?.remoteUrl ?? ""),
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
                Text(show.title)
                    .font(.system(size: 16, weight: .medium, design: .default))
                
                HStack {
                    Text(GetEpisodeCount(onDisk: show.statistics.episodeFileCount, episodeCount: show.statistics.episodeCount))
                    Text("|")
                    Text(String(show.statistics.seasonCount) + " Season" + (show.statistics.seasonCount > 1 ? "s" : ""))
                    Text("|")
                    Text(GetShowFileSize(bytes: show.statistics.sizeOnDisk))
                }.font(.system(size: 12, weight: .light, design: .default))
                
                HStack {
                    Text(show.network)
                    Text("|")
                    Text(GetNextAiring(date: show.nextAiring) ?? "Unknown")
                }.font(.system(size: 12, weight: .light, design: .default))
            }
        }
        .padding(5)
    }
}

struct ShowGridView: View {
    @State var show: Series
    var body: some View {
        VStack{
            AsyncImage(
                url: URL(string: show.images.first(where: {$0.coverType == "poster"})?.remoteUrl ?? ""),
                content: { image in
                    image.renderingMode(.original)
                        .resizable()
                        .frame(height: 170)
                        .clipped()
                        .cornerRadius(8)
                },
                placeholder: {
                    ProgressView()
                }
            )
            ScrollView(.horizontal, showsIndicators: false) {
            Text(show.title)
                .lineLimit(1)
                .font(.system(size: 16, weight: .medium, design: .default))
            }
            Text(GetEpisodeCount(onDisk: show.statistics.episodeFileCount, episodeCount: show.statistics.episodeCount))
                .lineLimit(1)
                .font(.system(size: 12, weight: .light, design: .default))
            
        }
    }
}

struct ShowInformationGridView: View {
    @State var show: Series
    
    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(
                url: URL(string: show.images.first(where: {$0.coverType == "poster"})?.remoteUrl ?? ""),
                content: { image in
                    image.renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 45, height: 70)
                        .clipped()
                        .cornerRadius(8)
                    
                },
                placeholder: {
                    ProgressView()
                }
            )
            VStack(alignment: .leading, spacing: 2) {
                Text(show.title)
                    .font(.system(size: 16, weight: .medium, design: .default))
                
                HStack {
                    Text(GetEpisodeCount(onDisk: show.statistics.episodeFileCount, episodeCount: show.statistics.episodeCount))
                    Text("|")
                    Text(String(show.statistics.seasonCount) + " Season" + (show.statistics.seasonCount > 1 ? "s" : ""))
                    Text("|")
                    Text(GetShowFileSize(bytes: show.statistics.sizeOnDisk))
                }.font(.system(size: 12, weight: .light, design: .default))
                
                HStack {
                    Text(show.network)
                    Text("|")
                    Text(GetNextAiring(date: show.nextAiring) ?? "Unknown")
                }.font(.system(size: 12, weight: .light, design: .default))
            }
        }
        .padding(5)
    }
}

struct NextAiringShowView: View {
    @State var show: Upcoming
    
    var body: some View {
        ZStack {
            AsyncImage(
                url: URL(string: show.series.images.first(where: {$0.coverType == "banner"})?.url ?? show.series.images.first(where: {$0.coverType == "fanart"})?.url ?? "https://artworks.thetvdb.com/banners/graphical/78650-g2.jpg"),
                content: { image in
                    image.renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(8)
                        .frame(width: 400, height: 90)
                        .opacity(0.2)
                        .overlay(NextAiringShowInformationView(show: show), alignment: .leading)
                    
                },
                placeholder: {
                    ProgressView()
                }
            )
        }
    }
}

struct NextAiringShowInformationView: View {
    @State var show: Upcoming
    
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
                        url: URL(string: show.series.images.first(where: {$0.coverType == "poster"})?.url ?? ""),
                        content: { image in
                            image.renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(8)
                                .frame(width: 45, height: 70)
//                                .clipped()
                                
                        },
                        placeholder: {
                            //                    ProgressView()
                        }
                    ))
            VStack(alignment: .leading, spacing: 2) {
                Text(show.series.title)
                    .font(.system(size: 18, weight: .medium, design: .default))
                
                HStack {
                    Text("Season " + String(show.seasonNumber))
                    Text("|")
                    Text("Episode " + String(show.episodeNumber))
                }.font(.system(size: 14, weight: .light, design: .default))
                Text(show.title).font(.system(size: 14, weight: .light, design: .default))
                    .italic()
            }
            Spacer()
            Text(GetTimeFromDate(fromDate: show.airDateUtc))
                .font(.system(size: 14, weight: .light, design: .default))
        }
        .padding(5)
    }
}
    
struct SearchShowView: View {
    @State var show: SearchSeries
    
    var body: some View {
        //        if gridView == .blockView {
        ZStack {
            AsyncImage(url: URL(string: show.images.first(where: {$0.coverType == "banner"})?.url ?? "")) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .frame(maxWidth: .infinity, idealHeight: 80, maxHeight: .infinity)
                        .foregroundColor(.gray)
                        .cornerRadius(8)
                        .opacity(0.2)
                        .overlay(SearchShowInformationView(show: show), alignment: .leading)
                case .success(let image):
                    image
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .opacity(0.2)
                        .overlay(SearchShowInformationView(show: show), alignment: .leading)
                case .failure:
                    Rectangle()
                        .frame(maxWidth: .infinity, idealHeight: 80, maxHeight: .infinity)
                        .foregroundColor(.gray)
                        .cornerRadius(8)
                        .opacity(0.2)
                        .overlay(SearchShowInformationView(show: show), alignment: .leading)
                @unknown default:
                    Text("Unknown error. Please try again.")
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct SearchShowInformationView: View {
    @State var show: SearchSeries
    
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
                        url: URL(string: show.images.first(where: {$0.coverType == "poster"})?.url ?? ""),
                        content: { image in
                            image.renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 45, height: 70)
                                .clipped()
                                .cornerRadius(8)
                            
                        },
                        placeholder: {
                            //
                        }
                    ))
            VStack(alignment: .leading, spacing: 2) {
                Text(show.title)
                    .font(.system(size: 16, weight: .medium, design: .default))
                
                HStack {
                    Text(String(show.seasonCount) + " Season" + (show.seasonCount == 1 ? "" : "s"))
                    Text("|")
                    Text(String(show.year))
                }.font(.system(size: 12, weight: .light, design: .default))
                
                Text(show.overview ?? "")
                    .font(.system(size: 12, weight: .light, design: .default))
            }
        }
        .padding(5)
    }
}

struct DetailShowView: View {
    @State var show: Series
    
    var body: some View {
        ZStack {
            AsyncImage(
                url: URL(string: show.images.first(where: {$0.coverType == "banner"})?.remoteUrl ?? show.images.first(where: {$0.coverType == "fanart"})?.remoteUrl ?? "https://artworks.thetvdb.com/banners/graphical/78650-g2.jpg"),
                content: { image in
                    image.renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 80)
                        .cornerRadius(8)
                        .opacity(0.2)
                        .overlay(DetailShowInformationView(show: show), alignment: .leading)
                    
                },
                placeholder: {
                    LoadingAnimation()
                }
            )
        }
    }
}

struct DetailShowInformationView: View {
    @State var show: Series
    
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
                        url: URL(string: show.images[1].remoteUrl),
                        content: { image in
                            image.renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 45, height: 70)
                                .clipped()
                                .cornerRadius(8)
                            
                        },
                        placeholder: {}
                    ))
            VStack(alignment: .leading, spacing: 2) {
                Text(show.title)
                    .font(.system(size: 16, weight: .medium, design: .default))
                
                Text(show.overview).font(.system(size: 12, weight: .light, design: .default))
            }
        }
        .padding(5)
    }
}

struct MissingShowView: View {
    @State var show: MissingRecord
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: show.series.images.first(where: {$0.coverType == "banner"})?.url ?? "")) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .frame(maxWidth: .infinity, idealHeight: 90, maxHeight: .infinity)
                        .foregroundColor(.gray)
                        .cornerRadius(8)
                        .opacity(0.2)
                        .overlay(MissingShowInformationView(show: show), alignment: .leading)
                case .success(let image):
                    image
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .opacity(0.2)
                        .overlay(MissingShowInformationView(show: show), alignment: .leading)
                case .failure:
                    Rectangle()
                        .frame(maxWidth: .infinity, idealHeight: 90, maxHeight: .infinity)
                        .foregroundColor(.gray)
                        .cornerRadius(8)
                        .opacity(0.2)
                        .overlay(MissingShowInformationView(show: show), alignment: .leading)
                @unknown default:
                    Text("Unknown error. Please try again.")
                        .foregroundColor(.red)
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct MissingShowInformationView: View {
    @State var show: MissingRecord
    
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
                        url: URL(string: show.series.images.first(where: {$0.coverType == "poster"})?.url ?? ""),
                        content: { image in
                            image.renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 45, height: 70)
                                .clipped()
                                .cornerRadius(8)
                            
                        },
                        placeholder: {
                            //
                        }
                    ))
            VStack(alignment: .leading, spacing: 2) {
                Text(show.series.title)
                    .font(.system(size: 16, weight: .medium, design: .default))
                HStack{
                    Text("Season \(show.seasonNumber)")
                    Text("|")
                    Text("Episode \(show.episodeNumber)")
                }
                Text(show.title)
                    .font(.system(size: 12, weight: .light, design: .default))
                    .italic()
                Text(GetDateFromStringDate(date: show.airDate))
                    .font(.system(size: 14, weight: .bold, design: .default))
                    .foregroundColor(.blue)
            }.padding(.vertical)
        }
        .padding(5)
    }
}
