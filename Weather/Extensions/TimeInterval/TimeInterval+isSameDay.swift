//
//  TimeInterval+isSameDay.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation

extension TimeInterval {
    func isSameDay(with date: Date = Date()) -> Bool {
        let calendar = Calendar.current
        let selfDate = Date(timeIntervalSince1970: self)

        return calendar.isDate(selfDate, inSameDayAs: date)
    }
}
