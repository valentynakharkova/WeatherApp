
//  CitiesListView.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 16.02.2026.


import SwiftUI
import Combine

struct CitiesListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: WeatherViewModel
    @ObservedObject var citiesManager = SavedCityManager.shared
    @State private var searchQuery: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                // background
                BackgroundGradient(weather: viewModel.weatherData)
                
                ScrollView {
                    VStack {
                        HStack(spacing: 12) {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.thinMaterial)
                            
                            TextField("Search for cities...", text: $searchQuery)
                                .foregroundStyle(.white)
                                .onChange(of: searchQuery) { oldValue, newValue in
                                    if newValue.count > 2 {
                                        viewModel.searchCities(query: newValue)
                                    } else {
                                        viewModel.clearSearch()
                                    }
                                }
                        }
                        .padding()
                        .background(.white.opacity(0.15))
                        .cornerRadius(12)
                        .padding()
                        
                        Spacer()
                        
                        //MARK: Search Results
                        if !viewModel.searchResults.isEmpty {
                            ScrollView {
                                searchResults
                            }
                            
                            if citiesManager.savedCities.isEmpty {
                                emptyState
                            }
                        } else {
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Cities")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    //MARK: Empty state
    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "cloud.sun.fill")
                .font(.system(size: 60))
                .foregroundStyle(.white.opacity(0.5))
            
            Text("No saved cities")
                .font(.title3)
                .foregroundStyle(.white)
            
            Text("Search for a city to add it here")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.7))
        }
    }
    
    // MARK: Cities List
    private var citiesList: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(citiesManager.savedCities) { city in
                    CityRow(city: city) {
                        //Tap to show weather
                        viewModel.getWeather(lat: city.lat, lon: city.lon)
                        dismiss()
                    }
                }
            }
            .padding()
        }
    }
    //MARK: Search Results
    private var searchResults: some View {
        VStack(spacing: 8) {
            ForEach(viewModel.searchResults) { city in
                Button {
                    SavedCityManager.shared.saveCity(city)
                    viewModel.getWeather(lat: city.lat, lon: city.lon)
                    viewModel.clearSearch()
                    searchQuery = ""
                    dismiss()
                } label: {
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text(city.name)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(city.displayName)
                            .font(.subheadline)
                            .foregroundStyle(.thinMaterial)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
        }
    }
}



#Preview {
    CitiesListView(viewModel: WeatherViewModel())
}
