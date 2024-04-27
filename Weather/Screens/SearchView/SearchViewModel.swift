//
//  SearchViewModel.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation

final class SearchViewModel: ObservableObject {
    // MARK: - Published Properties
    
    @Published var searchHistory: [SearchHistoryItem] = []

    // MARK: - Private Properties
    
    let storageManager: IStorageManager
    
    // MARK: - Init

    init() {
        self.storageManager = StorageManager()
        
        loadSearchHistory()
    }
    
    // MARK: - Public Methods
    
    func saveSearchItem(_ text: String) {
        storageManager.saveSearchHistoryItem(SearchHistoryItem(searchText: text))
    }
    
    func deleteSearchItem(at index: IndexSet)
    {
        storageManager.deleteHistoryItem(at: index)
    }
    // MARK: - Private Methods

    private func loadSearchHistory() {
        searchHistory = storageManager.loadSearchHistory()
    }


}
