//
//  FilterModeViewModel.swift
//  Mediarr v2
//
//  Created by David Sudar on 10/6/2022.
//

import Foundation

//Figure out how to filter
enum filterModeViewModel: Int, CaseIterable {
    case genre
    case none
    
    var title: String {
        switch self {
        case .genre: return "Genre"
        case .none: return "No Filter"
//        case .adventure: return "Adventure"
//        case .drama: return "Drama"
//        case .horror: return "Horror"
//        case .fantasy: return "Fantasy"
//        case .scienceFiction: return "Science Fiction"
//        case .miniSeries: return "Mini-Series"
        }
    }
    
    var imageName: String {
        switch self {
        case .genre: return "textformat"
        case .none: return "textformat"
        }
    }
    
    var subMenus: [String] {
        switch self {
        case.genre: return ["Action", "Adventure", "Horror"]
        case .none: return []
        }
    }
    
//    enum subMenus: Int, CaseIterable {
//        case action
//        case adventure
//        case drama
//        case horror
//        case fantasy
//        case scienceFiction
//        case miniSeries
//    }
    
    
}
