//
//  String+Date.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/14/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


extension String {
    
    static func timeAgo(from date: Date) -> String {
        let currentDate = Date()
        guard date < currentDate else { return "A long time ago in a galaxy far, far away...." }
        
        var result: String
        let components = Calendar.current.dateComponents([.day, .hour, .minute], from: date, to: currentDate)
        
        if let days = components.day {
            if days >= 2 {
                result = "\(days) days ago"
            } else {
                result = "A day ago"
            }
        } else if let hours = components.hour {
            if hours >= 2 {
                result = "\(hours) hours ago"
            } else {
                result = "An hour ago"
            }
        } else if let minutes = components.minute {
            if minutes >= 2 {
                result = "\(minutes) minutes ago"
            } else {
                result = "A minute ago"
            }
        } else {
            result = "Just posted"
        }
        
        return result
    }
    
}
