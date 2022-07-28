//
//  Global Functions.swift
//  Mediarr
//
//  Created by David Sudar on 14/7/2022.
//

import Foundation
import SwiftUI

func configureScrollEdgeAppearance() {
    let navigationBar = UINavigationBar.appearance()
    
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground() // use `configureWithTransparentBackground` for transparent background
    appearance.backgroundColor = UIColor(Color("Secondary"))
    appearance.shadowColor = .clear
    appearance.shadowImage = UIImage()
    
    navigationBar.standardAppearance = appearance
    navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        }
