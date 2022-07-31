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

func ConvertDateToString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMM y"
    return formatter.string(from: date)
}

func GetDateFromStringDate(date: String?) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: date!)!
    
    let form = DateFormatter()
    form.dateFormat = "d MMM y"
    return form.string(from:date)
}
