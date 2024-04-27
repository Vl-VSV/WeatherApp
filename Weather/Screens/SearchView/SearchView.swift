//
//  SearchView.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import SwiftUI

struct SearchView: View {
    // MARK: - Properties

    @Binding var searchText: String
    let action: () -> Void
    
    // MARK: - Body

    var body: some View {
        VStack {
            SearchBarView(searchText: $searchText) {
                action()
            }
            
            List {
                
            }
        }
    }
}

// MARK: - Preview

#Preview {
    SearchView(searchText: .constant("Moscow")) {}
}

