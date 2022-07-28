//
//  SideMenuViewModel.swift
//  SideMenuSwiftUITutorial
//
//  Created by Stephen Dowless on 12/8/20.
//

import Foundation
import SwiftUI

enum SideMenuViewModel: Int, CaseIterable {
    case sonarr
    case radarr
    case bazarr
    case prowlerr
    case transmission
    case settings
    
    var title: String {
        switch self {
        case .sonarr: return "Sonarr"
        case .radarr: return "Radarr"
        case .bazarr: return "Bazarr"
        case .prowlerr: return "Prowlerr"
        case .transmission: return "Transmission"
        case .settings: return "Settings"
        }
    }
    
    var imageName: String {
        switch self {
        case .sonarr: return "Sonarr"
        case .radarr: return "Radarr"
        case .bazarr: return "Radarr"
        case .prowlerr: return "Radarr"
        case .transmission: return "Radarr"
        case .settings: return "systemName: settings"
        }
    }
//    var destination: View {
//        switch self {
//        case .sonarr: return SonarrView()
//        case .radarr: return RadarrView()
//        case .bazarr: return SonarrView()
//        case .prowlerr: return SonarrView()
//        case .transmission: return SonarrView()
//        case .settings: return SonarrView()
//        }
//    }
}
