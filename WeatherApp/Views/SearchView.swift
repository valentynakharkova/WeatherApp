////
////  SearchView.swift
////  WeatherApp
////
////  Created by Valentyna Kharkova on 15.02.2026.
////
//
//import SwiftUI
//
//struct SearchView: View {
//    
//    @Environment(\.dismiss) private var dismiss
//    
//    @ObservedObject var viewModel: WeatherViewModel
//    
//    @State private var searchQuery: String = ""
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                //MARK: background
//                BackgroundGradient()
//                
//                VStack {
//                    //MARK: Search Bar
//                    HStack(spacing: 12) {
//                        Image(systemName: "magnifyingglass")
//                            .foregroundStyle(.thinMaterial)
//                        
//                        TextField("Search for cities...", text: $searchQuery)
//                            .foregroundStyle(.white)
//                            .onChange(of: searchQuery) { oldValue, newValue in
//                                if newValue.count > 2 {
//                                    viewModel.searchCities(query: newValue)
//                                } else {
//                                    viewModel.clearSearch()
//                                }
//                            }
//                    }
//                    .padding()
//                    .background(.white.opacity(0.15))
//                    .cornerRadius(12)
//                    .padding()
//
//                    Spacer()
//                    
//                    //MARK: Search Results
//                    if !viewModel.searchResults.isEmpty {
//                        ScrollView {
//                            VStack(spacing: 8) {
//                                ForEach(viewModel.searchResults) { city in
//                                    Button {
//                                        SavedCityManager.shared.saveCity(city)
//                                        viewModel.getWeather(lat: city.lat, lon: city.lon)
//                                        viewModel.clearSearch()
//                                        searchQuery = ""
//                                        dismiss()
//                                    } label: {
//                                        HStack(alignment: .firstTextBaseline, spacing: 4) {
//                                            Text(city.name)
//                                                .font(.headline)
//                                                .foregroundStyle(.white)
//                                            Text(city.displayName)
//                                                .font(.subheadline)
//                                                .foregroundStyle(.thinMaterial)
//                                            
//                                            Spacer()
//                                            
//                                            Image(systemName: "chevron.right")
//                                                .foregroundStyle(.white.opacity(0.5))
//                                        }
//                                        .padding()
//                                        .frame(maxWidth: .infinity)
//                                        .frame(height: 55)
//                                        .background(Color.white.opacity(0.1))
//                                        .cornerRadius(12)
//                                        .padding(.horizontal)
//                                    }
//                                }
//                            }
//                        }
//                    } else {
//                        Spacer()
//                    }
//                    
//                }
//            }
//            .navigationTitle("Search City")
//            .navigationBarTitleDisplayMode(.inline)
//
//        }
//    }
//}
//
//#Preview {
//    SearchView(viewModel: WeatherViewModel())
//}
