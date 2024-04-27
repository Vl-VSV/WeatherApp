//
//  SearchBarView.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import SwiftUI

struct SearchBarView: View {
    // MARK: - Properties

    @Binding var searchText: String
    var action: () -> Void

    // MARK: - Private Properties

    @State private var showAlert: Bool = false

    // MARK: - Body

    var body: some View {
        HStack(spacing: 2) {
            TextField("Search a city", text: $searchText)

            Button {
                if searchText.isEmpty {
                    showAlert = true
                } else {
                    action()
                }
            } label: {
                Image(systemName: "magnifyingglass")
            }
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 7)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.secondary.opacity(0.4))
        }
        .padding()
        .alert("The field should not be empty", isPresented: $showAlert) {
            Button("Ok", role: .cancel) {}
        }
    }
}

// MARK: - Preview

#Preview {
    SearchBarView(searchText: .constant("Moscow")) {}
}
