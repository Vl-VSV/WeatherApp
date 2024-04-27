//
//  ForecastView.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import SwiftUI

struct ForecastView: View {
    // MARK: - Properties

    let title: String?
    let forecast: [WeatherModel]

    // MARK: - Body

    var body: some View {
        VStack {
            if let title = title {
                Text(title)
                    .font(.title)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(forecast) { item in
                        ForecastCard(
                            time: "\(item.timeInterval.toTimeString())",
                            icon: item.iconSF,
                            temperature: item.tempuratureString
                        )
                    }
                }
            }
        }
        .padding()
    }
}

// MARK: - Forecast Card

private struct ForecastCard: View {
    // MARK: - Properties

    let time: String
    let icon: String
    let temperature: String

    // MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            Text(time)
                .font(.subheadline)

            Image(systemName: icon)
                .font(.title)

            Text(temperature)
                .font(.title3)
        }
        .multilineTextAlignment(.center)
        .frame(width: 60, height: 145)
        .background {
            RoundedRectangle(cornerRadius: 30)
                .fill(.secondary.opacity(0.3))
        }
    }
}
