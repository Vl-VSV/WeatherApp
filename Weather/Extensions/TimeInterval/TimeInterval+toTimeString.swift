//
//  TimeInterval+toTimeString.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation

extension TimeInterval {
    func toTimeString(format: String = "HH:mm") -> String {
        let date = Date(timeIntervalSince1970: self)
        let formatter = DateFormatter()
        formatter.dateFormat = format

        return formatter.string(from: date)
    }
}

