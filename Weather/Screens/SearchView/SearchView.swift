//
//  SearchView.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import SwiftUI
import RealmSwift

struct SearchView: View {
    // MARK: - Properties

    @Binding var searchText: String
    let action: () -> Void
    
    // MARK: - Private Properties
    @ObservedObject private var viewModel = SearchViewModel()

    
    // MARK: - Body

    var body: some View {
        VStack {
            SearchBarView(searchText: $searchText) {
                action()
                viewModel.saveSearchItem(searchText)
            }
        }
        
        List {
            ForEach(viewModel.searchHistory) { item in
                Text(item.searchText)
                    .onTapGesture {
                        searchText = item.searchText
                    }
            }
            .onDelete(perform: { indexSet in
                viewModel.deleteSearchItem(at: indexSet)
            })
        }
    }
}

// MARK: - Preview

#Preview {
    SearchView(searchText: .constant("Moscow")) {}
}

