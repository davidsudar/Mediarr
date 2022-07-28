//
//  GridLayoutViewModel.swift
//  Mediarr v2
//
//  Created by David Sudar on 11/6/2022.
//

import Foundation

enum GridLayoutViewModel: Int, CaseIterable {
    case blockView
    case gridView
    
    var title: String {
        switch self {
        case .blockView: return "Block View"
        case .gridView: return "Grid View"
        }
    }
    
    var imageName: String {
        switch self {
        case .blockView: return "square.grid.2x2"
        case .gridView: return "rectangle.grid.1x2"
        }
    }
}
