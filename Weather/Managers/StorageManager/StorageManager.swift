//
//  StorageManager.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation
import RealmSwift

protocol IStorageManager {
    func saveSearchHistoryItem(_ item: SearchHistoryItem)
    func loadSearchHistory() -> [SearchHistoryItem]
    func deleteHistoryItem(at offsets: IndexSet)
}

final class StorageManager: IStorageManager {
    // MARK: - Properties
    
    private let realm = try! Realm()

    // MARK: - Public Methods
    
    func saveSearchHistoryItem(_ item: SearchHistoryItem) {
        guard !item.searchText.isEmpty else {
            return
        }
      
        let existingItem = realm.objects(RSearchHistoryItem.self)
            .filter("searchText == %@", item.searchText)
            .first
        guard existingItem == nil else { return }
        
        let historyItem = RSearchHistoryItem()
        historyItem._id = item.id.uuidString
        historyItem.searchText = item.searchText
        
        do {
            try realm.write {
                realm.add(historyItem)
            }
        } catch {
            assertionFailure("Error saving search history: \(error)")
        }
    }
    
    func loadSearchHistory() -> [SearchHistoryItem] {
        let searchHistory = realm.objects(RSearchHistoryItem.self)
        let searchTexts = searchHistory.map { SearchHistoryItem(searchText: $0.searchText) }
        return Array(searchTexts)
    }
    
    func deleteHistoryItem(at offsets: IndexSet) {
        let searchHistory = realm.objects(RSearchHistoryItem.self)
        guard let index = offsets.first else { return }
        
        do {
            try realm.write {
                realm.delete(searchHistory[index])
            }
        } catch {
            print("Error deleting search history item: \(error)")
        }
    }
}

class RSearchHistoryItem: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var searchText: String
}
