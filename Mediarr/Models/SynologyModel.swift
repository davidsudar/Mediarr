//
//  SynologyModel.swift
//  Mediarr
//
//  Created by David Sudar on 19/7/2022.
//

import Foundation

struct SynologyAuth: Hashable, Decodable {
    let data: SynologyAuthData
}

struct SynologyAuthData: Hashable, Decodable {
    let did, sid: String
}

struct SynologyStorage: Hashable, Decodable {
    let data: SynologyStorageData
}

struct SynologyStorageData: Hashable, Decodable {
    let shares: [SynologyStorageShare]
}

struct SynologyStorageShareAdditional: Hashable, Decodable {
    let volume_status: SynologyVolumeStatus
}
struct SynologyVolumeStatus: Hashable, Decodable {
    let freespace, totalspace: Int
    let readonly: Bool
}

struct SynologyStorageShare: Hashable, Decodable {
    let path, name: String
    let additional: SynologyStorageShareAdditional
}

struct SynologyUtilisation: Hashable, Decodable {
    let data: SynologyUtilisationData
}

struct SynologyUtilisationData: Hashable, Decodable {
    let cpu: SynologyUtilisationDataCPU
    let memory: SynologyUtilisationDataMemory
    let network: [SynologyUtilisationDataNetwork]
}

struct SynologyUtilisationDataCPU: Hashable, Decodable {
    let fifteenMin_load, oneMin_load, fiveMin_load, other_load, system_load, user_load: Int
    let device: String
    
    enum CodingKeys: String, CodingKey {
        case fifteenMin_load = "15min_load", oneMin_load = "1min_load", fiveMin_load = "5min_load", other_load, system_load, user_load
        case device
    }
}

struct SynologyUtilisationDataMemory: Hashable, Decodable {
    let real_usage: Int
    let device: String
}

struct SynologyUtilisationDataNetwork: Hashable, Decodable {
    let rx, tx: Int
    let device: String
}

struct SynologyNetworkChartObject: Hashable, Decodable {
    let type: String
    let data: [SynologyNetworkChartObjectData]
}

struct SynologyNetworkChartObjectData: Hashable, Decodable {
    let date: Date
    let speed: Int
}

