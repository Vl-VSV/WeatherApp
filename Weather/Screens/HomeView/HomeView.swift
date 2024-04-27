//
//  HomeView.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    
    @ObservedObject private var viewModel = HomeViewModel()
    
    @State private var searchText: String = ""
    @State private var showSearchView: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                if viewModel.isLoading {
                    ProgressView()
                } else if let weather = viewModel.weather, let forecast = viewModel.forecast {
                    VStack {
                        Text(weather.cityName)
                            .font(.largeTitle)
                        
                        Text(weather.tempuratureString)
                            .font(.system(size: 96))
                            .fontWeight(.thin)
                        
                        Image(systemName: weather.iconSF)
                            .font(.system(size: 48))
                            .foregroundStyle(.secondary)
                        
                        Text(weather.description.capitalized)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .multilineTextAlignment(.center)
                    
                    if !(forecast.filter { $0.timeInterval.isSameDay(with: .now) }).isEmpty {
                        ForecastView(
                            title: "Today",
                            forecast: forecast.filter { $0.timeInterval.isSameDay(with: .now) }
                        )
                    }
                    ForecastView(
                        title: "Tomorrow",
                        forecast: forecast.filter { $0.timeInterval.isSameDay(with: .tommorow) }
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSearchView.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
            .animation(.easeIn, value: viewModel.isLoading)
            .sheet(isPresented: $showSearchView) {
                SearchView(searchText: $searchText) {
                    Task {
                        await viewModel.showWeatherIn(city: searchText)
                        showSearchView.toggle()
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    HomeView()
}
