//
//  sortModeViewModel.swift
//  Mediarr v2
//
//  Created by David Sudar on 9/6/2022.
//

import Foundation

enum sortModeViewModel: Int, CaseIterable {
    case alphabetical
    case episodes
    case nextAiring
    case network
    
    var title: String {
        switch self {
        case .alphabetical: return "Alphabetical"
        case .episodes: return "Episodes"
        case .nextAiring: return "Next Airing"
        case .network: return "Network"
        }
    }
    
    var imageName: String {
        switch self {
        case .alphabetical: return "textformat"
        case .episodes: return "film"
        case .nextAiring: return "calendar"
        case .network: return "network"
        }
    }
}

enum transmissionSortModeViewModel: Int, CaseIterable {
    case alphabetical
    case percentDone
    
    var title: String {
        switch self {
        case .alphabetical: return "Alphabetical"
        case .percentDone: return "Percent Done"
        }
    }
    
    var imageName: String {
        switch self {
        case .alphabetical: return "textformat"
        case .percentDone: return "percent"
        }
    }
}
