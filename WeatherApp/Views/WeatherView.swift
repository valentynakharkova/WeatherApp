//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 13.02.2026.
//

import SwiftUI
import Combine

struct WeatherView: View {
    
    @StateObject private var viewModel: WeatherViewModel
    
    @ObservedObject var citiesManager = SavedCityManager.shared
    @ObservedObject private var tempSettings = TemperatureSettings.shared
    
    @State private var selectedCityIndex: Int = 0
    @State private var showPopover: Bool = false
    
    
    init() {
        _viewModel = StateObject(wrappedValue: WeatherViewModel())
    }
    
    init(viewModel: WeatherViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Group {
                    if let currentWeather = currentCityWeather {
                        BackgroundGradient(weather: currentWeather)
                    } else {
                        BackgroundGradient()
                    }
                }
                .animation(.easeInOut(duration: 0.6), value: selectedCityIndex)
                
                if citiesManager.savedCities.isEmpty {
                    emptyState
                } else {
                    //MARK: TabView
                    TabView(selection: $selectedCityIndex) {
                        ForEach(Array(citiesManager.savedCities.enumerated()), id: \.element.id) { index, city in
                            let _ = print("🏙 Looking up city: \(city.name), id: \(city.id), hasWeather: \(viewModel.savedCitiesWeather[city.id] != nil)")
                            if let weather = viewModel.savedCitiesWeather[city.id],
                               let forecast = viewModel.savedCitiesForecast[city.id] {
                                WeatherPageView(weather: weather, forecast: forecast)
                                    .tag(index)
                            } else {
                                VStack(alignment: .center) {
                                    Text(city.name)
                                    Text("— —")
                                }
                                .font(.system(size: 35, weight: .medium))
                                .foregroundStyle(.white)
                                .tag(index)
                                .task {
                                    await viewModel.loadCitiesWeather(city: city)
                                }
                            }
                        }
                    }
                    .padding(.top, 100)
                    .ignoresSafeArea()
                    .tabViewStyle(.page(indexDisplayMode: .always))
                }
            }
            .toolbar {
                //MARK: Toolbar: Cities List button
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink(value: "citiesList") {
                        Image(systemName: "list.bullet")
                    }
                    .navigationDestination(for: String.self) { _ in
                        CitiesListView(viewModel: viewModel, selectedCityIndex: $selectedCityIndex)
                    }
                }
                //MARK: Toolbar: Popover Button
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showPopover = true
                    } label: {
                        Image(systemName: tempSettings.unit.systemImage)
                            .foregroundStyle(.primary)
                    }
                    .popover(isPresented: $showPopover) {
                        VStack(alignment: .leading, spacing: 0) {
                            Button {
                                tempSettings.unit = .celsius
                                showPopover = false
                            } label: {
                                HStack(spacing: 15) {
                                    Image(systemName: "degreesign.celsius")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .frame(width: 20)
                                    Text("Celsius")
                                        .font(.title3)
                                        .fontWeight(.light)
                                    
                                }
                            }
                            .padding(.top, 8)
                            .padding()
                            
                            Button {
                                tempSettings.unit = .fahrenheit
                                showPopover = false
                            } label: {
                                HStack(spacing: 15) {
                                    Image(systemName: "degreesign.fahrenheit")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .frame(width: 20)
                                    Text("Fahrenheit")
                                        .font(.title3)
                                        .fontWeight(.light)
                                }
                                
                            }
                            .padding(.bottom, 8)
                            .padding()
                        }
                        .foregroundStyle(.primary)
                        .presentationCompactAdaptation(.popover)
                    }
                }
            }
            .onAppear {
                loadAllCitiesWeather()
            }
            .onChange(of: citiesManager.savedCities.count) { _, newCount in
                if selectedCityIndex >= newCount {
                    selectedCityIndex = max(0, newCount - 1)
                }
            }
        }
    }
    
    //MARK: Current City Weather for background
    private var currentCityWeather: WeatherData? {
        guard selectedCityIndex < citiesManager.savedCities.count else { return nil }
        let city = citiesManager.savedCities[selectedCityIndex]
        return viewModel.savedCitiesWeather[city.id]
    }
    
    //MARK: Load All City Weather
    private func loadAllCitiesWeather() {
        Task {
            for city in citiesManager.savedCities {
                await viewModel.loadCitiesWeather(city: city)
            }
        }
    }
    
    //MARK: Empty state when no cities saved
    private var emptyState: some View {
        VStack(spacing: 20) {
            Image(systemName: "cloud.sun.fill")
                .font(.system(size: 80))
                .foregroundStyle(.white.opacity(0.5))
            
            Text("No Cities Added")
                .font(.title)
                .foregroundStyle(.white)
            
            Text("Search for a city to get started")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.7))
        }
    }
}


#Preview {
    WeatherView()
    
}
