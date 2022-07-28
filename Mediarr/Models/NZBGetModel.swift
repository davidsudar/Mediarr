//
//  NZBGetModel.swift
//  Mediarr v2
//
//  Created by David Sudar on 27/6/2022.
//

import Foundation

struct NZBResult: Hashable, Decodable {
    let result: [NZB]
}

struct NZB: Hashable, Decodable, Identifiable {
    let id, Progress: Int
    let NZBName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID", Progress
        case NZBName
    }
}

struct NZBStatusResult: Hashable, Decodable {
    let result: [NZBStatus]
}

struct NZBStatus: Hashable, Decodable {
    let Progress: Int
    let NZBName: String
}
