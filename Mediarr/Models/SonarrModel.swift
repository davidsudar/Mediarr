//
//  Series.swift
//  Mediarr v2
//
//  Created by David Sudar on 7/6/2022.
//

import Foundation

struct RootFolder: Hashable, Decodable {
    let id, freeSpace: Int
    let path: String    
}

struct QualityProfile: Hashable, Decodable {
    let id: Int
    let name: String
}
struct LanguageProfile: Hashable, Decodable {
    let id: Int
    let name: String
    let upgradeAllowed: Bool
}
struct Tag: Hashable, Decodable {
    let id: Int
    let label: String
}

struct Series: Hashable, Decodable, Identifiable {
    let id, tvdbId, year, runtime: Int
    let title, sortTitle, status, overview, network, seriesType, path, added: String
    let monitored: Bool
    let nextAiring, certification: String?
    let images: Array<SonarrImage>
    let statistics: ShowStatistic
    let genres: [String]
    let tags: [Int]
    
}

struct AlternateTitle: Decodable {
    var title = ""
    var seasonNumber: Int? = 0
}

struct SonarrImage: Decodable, Hashable {
    let coverType, url, remoteUrl: String
}

struct Season: Decodable, Hashable {
    let seasonNumber: Int
    let monitored: Bool
//    var statistics = Array<Statistic>()
}

struct Statistic: Decodable {
    var previousAiring = ""
    var episodeFileCount: Int? = 0
    var episodeCount: Int? = 0
    var totalEpisodeCount: Int? = 0
    var sizeOnDisk: Int? = 0
    // var releaseGroups = 0
    var percentOfEpisodes: Int? = 0
}

struct ShowStatistic: Decodable, Hashable {
    let seasonCount, episodeFileCount, episodeCount, totalEpisodeCount, sizeOnDisk: Int
}

struct SearchSeries: Hashable, Decodable, Identifiable {
    let title, titleSlug: String
    let overview: String?
    let seasonCount, year, id, profileId:Int
    let images: [SonarrSearchImage]
    let seasons: [SonarrSearchSeason]
    
    enum CodingKeys: String, CodingKey {
        case id = "tvdbId", seasonCount, year, profileId
        case title, titleSlug
        case overview
        case images
        case seasons
    }
}

struct SonarrSearchImage: Decodable, Hashable, Encodable {
    let coverType, url: String
}

struct SonarrSearchSeason: Decodable, Hashable, Encodable {
    let seasonNumber: Int
    let monitored: Bool
}

struct AddShowObject: Codable {
    let title, titleSlug, rootFolderPath: String
    let seasons: [SonarrSearchSeason]
    let profileId, tvdbId, qualityProfileId, languageProfileId: Int
    let addOptions: AddOptions
    let seasonFolder, monitored: Bool
    let images: [SonarrSearchImage]
    
}
struct AddOptions: Codable {
    let monitor: MonitorEnum.RawValue
    let searchForCutoffUnmetEpisodes: Bool
    let searchForMissingEpisodes: Bool
}

public struct Upcoming: Hashable, Decodable, Identifiable {
    public let id, seasonNumber, episodeNumber: Int
    let title, airDateUtc: String
    let series: UpcomingSeries
}

struct EpisodeFile: Hashable, Decodable {
    let seasonNumber: Int
}

struct UpcomingSeries: Hashable, Decodable {
    let title: String
    let images: Array<SonarrSearchImage>
}

struct Missing: Hashable, Decodable, Identifiable {
    let id: Int
    let records: [MissingRecord]
}
struct MissingRecord: Hashable, Decodable {
    let title: String
    let series: MissingRecordSeries
}

struct MissingRecordSeries: Hashable, Decodable {
    let title: String
}

enum MonitorEnum: Int, CaseIterable {
    case all
    case future
    case missing
    case existing
    case pilot
    case first
    case latest
    case none
    
    var title: String {
        switch self {
        case .all: return "All Episodes"
        case .future: return "Future Episodes"
        case .missing: return "Missing Episodes"
        case .existing: return "Existing Episodes"
        case .pilot: return "Pilot Episode"
        case .first: return "Only First Season"
        case .latest: return "Only Latest Season"
        case .none: return "None"
        }
    }
}

enum SeriesTypeEnum: Int, CaseIterable {
    case standard
    case daily
    case anime
    
    var title: String {
        switch self {
        case .standard: return "Standard"
        case .daily: return "Daily"
        case .anime: return "Anime"
        }
    }
}



var previewSeries: Series = Series(id: 0, tvdbId: 377777, year: 2005, runtime: 46, title: "Doctor Who", sortTitle: "doctor who", status: "Airing", overview: "Empty Description", network: "BBC One", seriesType: "", path: "", added: "", monitored: true, nextAiring: #"2022-06-16T00:00:00Z"#, certification: "TV-14", images: [SonarrImage(coverType: "banner", url: "/MediaCover/4/banner.jpg?lastWrite=637892622071839549", remoteUrl: "https://artworks.thetvdb.com/banners/graphical/78804-g28.jpg"), SonarrImage(coverType: "poster", url: "/MediaCover/4/poster.jpg?lastWrite=637892622094159549", remoteUrl: "https://artworks.thetvdb.com/banners/posters/78804-52.jpg")], statistics: ShowStatistic(seasonCount: 13, episodeFileCount: 106, episodeCount: 153, totalEpisodeCount: 312, sizeOnDisk: 347), genres: ["action"], tags: [])

