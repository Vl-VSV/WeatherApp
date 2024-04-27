//
//  Date+getStringTitle.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation

extension Date {
    func getStringTitle(format: String = "dd MMMM") -> String {
        let calendar = Calendar.current
        let now = calendar.startOfDay(for: Date())
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: now)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        let dateString: String
        
        if calendar.isDate(self, inSameDayAs: now) {
            dateString = "Today".localized()
        } else if calendar.isDate(self, inSameDayAs: tomorrow) {
            dateString = "Tomorrow".localized()
        } else {
            dateString = dateFormatter.string(from: self)
        }
        
        return dateString
    }
}
