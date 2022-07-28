//
//  DateFunctions.swift
//  Mediarr v2
//
//  Created by David Sudar on 13/6/2022.
//

import Foundation

func GetNextAiring(date: String?) -> String? {
    if date == nil
    {
        return date
    }
    else
    {
        let inputDate = date!.replacingOccurrences(of: "T", with: " ")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        let date = dateFormatter.date(from: inputDate) ?? Date()
        dateFormatter.dateFormat = "MMM d, yyyy @ h:mm a"
        return dateFormatter.string(from: date)
    }
}

func GetNextAiringUpcoming(date: String?) -> String? {
    if date == nil
    {
        return date
    }
    else
    {
        let inputDate = date!.replacingOccurrences(of: "T", with: " ")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        let date = dateFormatter.date(from: inputDate) ?? Date()
        dateFormatter.dateFormat = "EEEE / MMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
}

func GetDateFromString(date: String?) -> Date {
  
        let inputDate = date!.replacingOccurrences(of: "T", with: " ")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        return dateFormatter.date(from: inputDate)!
    
}
func GetDateFromStringDay(date: String?) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "EEEE, MMM d"
    return dateFormatter.date(from: date!)!
    
}

func GetEpisodePercentage(onDisk: Int, episodeCount: Int) -> Int {
    var percentage = round((Double(onDisk) / Double(episodeCount)) * 100)
    if percentage.isNaN
    {
        percentage = 0
    }
    return Int(percentage)
}

func GetShowFileSize(bytes: Int) -> String {
    var fileSize: String = ""
    
    if bytes < 1000
    {
        fileSize = String(bytes) + " B"
    }
    else if bytes < 1000000
    {
        fileSize = String((Double(bytes) / 1000).rounded(toPlaces: 1))+" KB"
    }
    else if bytes < 1000000000
    {
        fileSize = String((Double(bytes) / 1000000).rounded(toPlaces: 1))+" MB"
    }
    else if bytes < 1000000000000 {
        fileSize = String((Double(bytes) / 1000000000).rounded(toPlaces: 1))+" GB"
    }
    else {
        fileSize = String((Double(bytes) / 1000000000000).rounded(toPlaces: 1))+" TB"

    }
    return fileSize
}

func GetEpisodeCount(onDisk: Int, episodeCount: Int) -> String {
    var episodesString: String = ""
    var percentage = round((Double(onDisk) / Double(episodeCount)) * 100)
    if percentage.isNaN
    {
        percentage = 0
    }
    let percentageInt = Int(percentage)
    episodesString = String(onDisk)+"/"+String(episodeCount) + " " + "(" + String(percentageInt) + "%)"
    return episodesString
}

public func removeTimeStamp(fromDate: Date) -> Date {
    guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: fromDate)) else {
        fatalError("Failed to strip time from Date object")
    }
    return date
}

public func GetTimeFromDate(fromDate: String) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let date = dateFormatter.date(from:fromDate)!
    
    let form = DateFormatter()
    form.dateFormat = "h:mm a"
    let time = form.string(from:date)
    return time
}

public func SortUpcomingIntoDictionary(upcoming: [Upcoming]) -> [String: [Upcoming]] {
    
    var dict = [String: [Upcoming]]()
    
    var cleanUpcoming = [Upcoming]()
    
    for show in upcoming {
        if !cleanUpcoming.contains(where: { $0.title == show.title }) {
            cleanUpcoming.append(show)
        }
    }
    
    for show in cleanUpcoming {
        //get day only
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:show.airDateUtc)!
        
        let form = DateFormatter()
        form.dateFormat = "EEEE, MMM d"
        let day = form.string(from:date)
        
        if var val = dict[day] {
            val.append(show)
        }
        else
        {
            dict[day] = [show]
        }
    }
    
    return dict
}
