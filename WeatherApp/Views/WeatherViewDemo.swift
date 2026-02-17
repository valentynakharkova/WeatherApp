//
//  WeatherViewDemo.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 14.02.2026.
//

import SwiftUI

struct WeatherViewDemo: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    @State private var searchQuery = ""

    var body: some View {
                ZStack {
                    // Background gradient
                    LinearGradient(
                        colors: [Color.blue, Color.purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
        
                    ScrollView {
                        VStack(spacing: 20) {
        
                            // SEARCH BAR
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.white.opacity(0.7))
        
                                TextField("Search city...", text: $searchQuery)
                                    .foregroundColor(.white)
                                    .onChange(of: searchQuery) { oldValue, newValue in
                                        if newValue.count >= 2 {
                                            viewModel.searchCities(query: newValue)
                                        } else {
                                            viewModel.clearSearch()
                                        }
                                    }
        
                                if !searchQuery.isEmpty {
                                    Button(action: {
                                        searchQuery = ""
                                        viewModel.clearSearch()
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.white.opacity(0.7))
                                    }
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(15)
                            .padding(.horizontal)
                            .padding(.top, 20)
        
                            // SEARCH RESULTS
                            if !viewModel.searchResults.isEmpty {
                                VStack(spacing: 0) {
                                    ForEach(viewModel.searchResults) { city in
                                        Button(action: {
                                            viewModel.getWeather(lat: city.lat, lon: city.lon)
                                            searchQuery = ""
                                            viewModel.clearSearch()
                                        }) {
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    Text(city.name)
                                                        .font(.headline)
                                                        .foregroundColor(.white)
                                                    Text(city.displayName)
                                                        .font(.caption)
                                                        .foregroundColor(.white.opacity(0.7))
                                                }
                                                Spacer()
                                            }
                                            .padding()
                                        }
        
                                        if city.id != viewModel.searchResults.last?.id {
                                            Divider()
                                                .background(Color.white.opacity(0.3))
                                        }
                                    }
                                }
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(15)
                                .padding(.horizontal)
                            }
        
                            // LOADING
                            if viewModel.isLoading {
                                ProgressView()
                                    .tint(.white)
                                    .scaleEffect(1.5)
                                    .padding(.top, 50)
                            }
        
                            // CURRENT WEATHER
                            if let weather = viewModel.weatherData {
                                VStack(spacing: 30) {
        
                                    // City name
                                    Text("\(weather.name), \(weather.sys.country)")
                                        .font(.system(size: 32, weight: .medium))
                                        .foregroundColor(.white)
        
                                    // Temperature
                                    Text("\(Int(weather.main.temp))°")
                                        .font(.system(size: 90, weight: .thin))
                                        .foregroundColor(.white)
        
                                    // Weather description
                                    Text(weather.weather.first?.description.capitalized ?? "")
                                        .font(.title2)
                                        .foregroundColor(.white.opacity(0.8))
        
                                    // Feels like
                                    Text("Feels like \(Int(weather.main.feelsLike))°")
                                        .font(.title3)
                                        .foregroundColor(.white.opacity(0.7))
        
                                    // WEATHER DETAILS GRID
                                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
        
                                        DetailCard(icon: "thermometer.low", title: "Min", value: "\(Int(weather.main.tempMin))°")
                                        DetailCard(icon: "thermometer.high", title: "Max", value: "\(Int(weather.main.tempMax))°")
                                        DetailCard(icon: "humidity", title: "Humidity", value: "\(weather.main.humidity)%")
                                        DetailCard(icon: "wind", title: "Wind", value: "\(Int(weather.wind.speed)) m/s")
                                        DetailCard(icon: "gauge", title: "Pressure", value: "\(weather.main.pressure) hPa")
                                        DetailCard(icon: "cloud", title: "Clouds", value: "\(weather.clouds.all)%")
                                    }
                                    .padding(.horizontal)
        
                                    // 5-DAY FORECAST
                                    if let forecast = viewModel.forecastData {
                                        VStack(alignment: .leading, spacing: 15) {
                                            Text("5-Day Forecast")
                                                .font(.title2)
                                                .bold()
                                                .foregroundColor(.white)
                                                .padding(.horizontal)
        
                                            ScrollView(.horizontal, showsIndicators: false) {
                                                HStack(spacing: 15) {
                                                    ForEach(getDailyForecasts(from: forecast.list)) { item in
                                                        ForecastCard(item: item)
                                                    }
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                                    }
                                }
                                .padding(.top, 30)
                            }
        
                            // ERROR MESSAGE
                            if let error = viewModel.errorMessage {
                                VStack {
                                    Image(systemName: "exclamationmark.triangle")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                    Text(error)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
            
            // Helper function to get daily forecasts
            private func getDailyForecasts(from list: [ForecastItem]) -> [ForecastItem] {
                var dailyForecasts: [ForecastItem] = []
                var seenDates: Set<String> = []
        
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
        
                for item in list {
                    let dateString = dateFormatter.string(from: item.date)
        
                    if !seenDates.contains(dateString) && item.dtTxt.contains("12:00:00") {
                        dailyForecasts.append(item)
                        seenDates.insert(dateString)
                    }
                }
        
                return Array(dailyForecasts.prefix(5))
            }
        }

        // Detail Card Component
        struct DetailCard: View {
            let icon: String
            let title: String
            let value: String
        
            var body: some View {
                VStack(spacing: 10) {
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(.white)
        
                    Text(title)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
        
                    Text(value)
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(15)
            }
        }

        // Forecast Card Component
        struct ForecastCard: View {
            let item: ForecastItem
        
            private var dayOfWeek: String {
                let formatter = DateFormatter()
                formatter.dateFormat = "EEE"
                return formatter.string(from: item.date)
            }
        
            var body: some View {
                VStack(spacing: 10) {
                    Text(dayOfWeek)
                        .font(.headline)
                        .foregroundColor(.white)
        
                    Image(systemName: "cloud.sun.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
        
                    Text("\(Int(item.main.temp))°")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
        
                    Text(item.weather.first?.main ?? "")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
                .frame(width: 100)
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(15)
            }
        }

#Preview {
    WeatherViewDemo()
}
