//
//  RadarrModel.swift
//  Mediarr v2
//
//  Created by David Sudar on 24/6/2022.
//

import Foundation

struct Movie: Hashable, Decodable, Identifiable {
    let id, year, runtime: Int
    let title, sortTitle, status, overview, path, added, studio: String
    let monitored: Bool
    let certification: String?
    let images: Array<RadarrImage>
    let genres: [String]
    let tags: [Int]
}

struct RadarrImage: Decodable, Hashable {
    let coverType, url, remoteUrl: String
}
