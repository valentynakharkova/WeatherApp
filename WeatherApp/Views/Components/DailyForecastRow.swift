//
//  DailyForecastRow.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 15.02.2026.
//

import SwiftUI

struct DailyForecastRow: View {
    
    let item: ForecastItem
    
    private var dayOfWeek: String {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let itemDate = calendar.startOfDay(for: item.date)
        
        if today == itemDate {
            return "Today"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EE" // Full day name
        return formatter.string(from: item.date)
    }
    
    private var weatherIcon: String {
        guard let main = item.weather.first?.main else { return "cloud.fill" }
        
        switch main.lowercased() {
        case "clear":
            return "sun.max.fill"
        case "clouds":
            return "cloud.fill"
        case "rain":
            return "cloud.rain.fill"
        case "drizzle":
            return "cloud.drizzle.fill"
        case "thunderstorm":
            return "cloud.bolt.fill"
        case "snow":
            return "cloud.snow.fill"
        case "mist", "fog":
            return "cloud.fog.fill"
        default:
            return "cloud.fill"
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            // Day of week
            HStack(spacing: 16) {
                Text(dayOfWeek.uppercased())
                    .font(.body)
                    .fontWeight(.medium)
                    .colorModifier()
                    .frame(width: 60, alignment: .leading)
                
                Spacer()
                
                // Weather icon
                Image(systemName: weatherIcon)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(width: 40, alignment: .center)
                
                Spacer()
                
                // Temperature range
                HStack(spacing: 8) {
                    
                    // Low temp
                    Text("\(Int(item.main.tempMin))°")
                        .font(.body)
                        .foregroundStyle(.white)
                        .frame(width: 35, alignment: .trailing)
                    
                    // Temperature bar (visual indicator)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(
                            LinearGradient(
                                colors: [.blue.opacity(0.7), .orange.opacity(0.7)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: 80, height: 4)
                    
                    // High temp
                    Text("\(Int(item.main.tempMax))°")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 35, alignment: .leading)
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(.white.opacity(0.1))
            .cornerRadius(12)
            
        }
    }
}

#Preview {
    ZStack {
        BackgroundGradient()
        VStack(spacing: 12) {
            DailyForecastRow(item: ForecastData.mock.list[0])
            DailyForecastRow(item: ForecastData.mock.list[1])
            DailyForecastRow(item: ForecastData.mock.list[2])
        }
        .padding()
    }
}
