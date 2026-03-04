//  CitiesListView.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 16.02.2026.


import SwiftUI
import Combine

struct CitiesListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: WeatherViewModel
    @ObservedObject private var citiesManager = SavedCityManager.shared
    
    @Binding var selectedCityIndex: Int
    
    @State private var searchQuery: String = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            // Background
            Group {
                if let currentWeather = currentCityWeather {
                    BackgroundGradient(weather: currentWeather)
                } else {
                    BackgroundGradient()
                }
            }
            .animation(.easeInOut(duration: 0.6), value: selectedCityIndex)
            
            // Main VStack
            VStack(spacing: 30) {
                searchBar
                    .padding(.top, 16)
                List {
                    if !viewModel.searchResults.isEmpty {
                        searchResults
                            .listRowBackground(Color(.clear))
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                    } else if citiesManager.savedCities.isEmpty {
                        emptyState
                            .listRowBackground(Color(.clear))
                            .listRowSeparator(.hidden)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 60)
                    } else {
                        citiesList
                            .contentShape(.dragPreview, RoundedRectangle(cornerRadius: 12))
                            .listRowBackground(Color(.clear))
                            .listRowSeparator(.hidden)
                            .scrollContentBackground(.hidden)
                        
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .listRowBackground(Color(.clear))
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("WEATHER")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    //MARK: Search Bar
    private var searchBar: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .colorModifier()
            
            TextField("Search for cities...", text: $searchQuery)
                .foregroundStyle(.white)
                .onChange(of: searchQuery) { oldValue, newValue in
                    if newValue.count > 2 {
                        viewModel.searchCities(query: newValue)
                    } else {
                        viewModel.clearSearch()
                    }
                }
            if !searchQuery.isEmpty {
                Button {
                    searchQuery = ""
                    viewModel.clearSearch()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .colorModifier()
                }
            }
        }
        .padding()
        .background(.white.opacity(0.15))
        .cornerRadius(12)
        .padding(.horizontal)
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
        ForEach(citiesManager.savedCities) { city in
            Group {
                if let weather = viewModel.savedCitiesWeather[city.id] {
                    CityRow(
                        city: city,
                        weather: weather,
                        onTap: {
                            if let index = citiesManager.savedCities.firstIndex(
                                where: { $0.id == city.id }) {
                                selectedCityIndex = index
                                dismiss()
                            }
                        }, onDelete: {
                            if let index = citiesManager.savedCities.firstIndex(
                                where: { $0.id == city.id }) {
                                deleteCity(at: IndexSet([index]))
                            }
                    })
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    
                } else {
                    loadingRow(for: city)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
        }
        .onMove(perform: moveCity)
        .onDelete(perform: deleteCity)
        
    }
    
    //MARK: Delete City
    private func deleteCity(at offsets: IndexSet) {
        offsets.forEach { index in
            let city = citiesManager.savedCities[index]
            citiesManager.removeCity(city)
        }
        // Safety check: Ensure selectedCityIndex isn't out of bounds after deletion
        if selectedCityIndex >= citiesManager.savedCities.count {
            selectedCityIndex = max(0, citiesManager.savedCities.count - 1)
        }
    }
    
    //MARK: Move City
    private func moveCity(from sourse: IndexSet, to destination: Int) {
        let selectedCity = selectedCityIndex < citiesManager.savedCities.count ? citiesManager.savedCities[selectedCityIndex] : nil
        citiesManager.moveCity(from: sourse, to: destination)
        if let selected = selectedCity, let newIndex = citiesManager.savedCities.firstIndex(where: { $0.id == selected.id }) {
            selectedCityIndex = newIndex
        }
    }
    
    //MARK: Loading Row
    private func loadingRow(for city: GeocodingData) -> some View {
        HStack {
            Text(city.name)
                .font(.title3)
                .foregroundStyle(.white)
            Spacer()
            ProgressView().tint(.white)
        }
        .frame(height: 80)
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(12)
        .task {
            await viewModel.loadCitiesWeather(city: city)
        }
    }
    //MARK: Search Results
    private var searchResults: some View {
            ForEach(viewModel.searchResults) { city in
                let alreadySaved = citiesManager.savedCities.contains(where: {$0.name == city.name && $0.country == city.country })
                let atLimit = citiesManager.savedCities.count >= 5
                
                Button {
                    guard !alreadySaved && !atLimit else { return }
                    citiesManager.saveCity(city)
                    searchQuery = ""
                    Task {
                        await viewModel.loadCitiesWeather(city: city)
                    }
                    dismiss()
                } label: {
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text(city.name)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(city.displayName)
                            .font(.subheadline)
                            .colorModifier()
                        
                        Spacer()
                        
                        if alreadySaved {
                            Text("Saved")
                                .font(.caption)
                                .colorModifier()
                        } else if atLimit {
                            Text("Limit reached")
                                .font(.caption)
                                .colorModifier()
                        } else {
                            Image(systemName: "chevron.right")
                                .colorModifier()
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.white.opacity(alreadySaved || atLimit ? 0.05 : 0.1))
                    .cornerRadius(12)
                }
                .disabled(alreadySaved || atLimit)
                .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
            }
        }
    //MARK: Current City Weather for background
    private var currentCityWeather: WeatherData? {
        guard selectedCityIndex < citiesManager.savedCities.count else { return nil }
        let city = citiesManager.savedCities[selectedCityIndex]
        return viewModel.savedCitiesWeather[city.id]
    }
    
    private func configureListAppearance() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
}



#Preview {
    @Previewable @StateObject var viewModel = WeatherViewModel()
    @Previewable @State var selectedCityIndex = 0
    NavigationStack {
        CitiesListView(viewModel: viewModel, selectedCityIndex: $selectedCityIndex)
    }
    
}

