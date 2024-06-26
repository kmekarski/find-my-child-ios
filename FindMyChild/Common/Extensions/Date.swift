//
//  Date.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 14/06/2024.
//

import Foundation

extension Date {
    func asTimeAgoString() -> String {
        let now = Date()
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month, .weekOfYear, .day, .hour, .minute, .second], from: self, to: now)
        
        if let year = components.year, year > 0 {
            return "\(year) year\(year > 1 ? "s" : "") \(String(localized: "ago_string"))"
        } else if let month = components.month, month > 0 {
            return "\(month) month\(month > 1 ? "s" : "") \(String(localized: "ago_string"))"
        } else if let week = components.weekOfYear, week > 0 {
            return "\(week) week\(week > 1 ? "s" : "") \(String(localized: "ago_string"))"
        } else if let day = components.day, day > 0 {
            return "\(day)d \(String(localized: "ago_string"))"
        } else if let hour = components.hour, hour > 0 {
            return "\(hour)h \(String(localized: "ago_string"))"
        } else if let minute = components.minute, minute > 0 {
            return "\(minute)m \(String(localized: "ago_string"))"
        } else if let second = components.second, second > 0 {
            return "\(second)s \(String(localized: "ago_string"))"
        } else {
            return String(localized: "just_now_string")
        }
    }
}
