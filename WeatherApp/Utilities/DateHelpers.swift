//
//  DateHelpers.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 15.02.2026.
//

import Foundation
//MARK: Date
extension Date {
    func formatted(as format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func formattedTime() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
//MARK: Int
extension Int {
    func toDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
    
    func toTimeString() -> String {
        return toDate().formattedTime()
    }
}
