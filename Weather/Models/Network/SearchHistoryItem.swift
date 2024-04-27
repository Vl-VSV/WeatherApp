//
//  SearchHistoryItem.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation

struct SearchHistoryItem: Identifiable {
    let id = UUID()
    let searchText: String
}
