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
        HStack(spacing: 20) {
            // Day of week
            HStack(spacing: 16) {
                Text(dayOfWeek.uppercased())
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.thinMaterial)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Weather icon
                Image(systemName: weatherIcon)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            // Temperature range
            HStack(spacing: 10) {

                // Low temp
                Text("\(Int(item.main.tempMin))°")
                    .font(.body)
                    .foregroundStyle(.white)
                
                // Temperature bar (visual indicator)
                RoundedRectangle(cornerRadius: 2)
                    .fill(
                        LinearGradient(
                            colors: [.blue.opacity(0.5), .orange.opacity(0.5)],
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
            }
        }
//        .frame(maxWidth: .infinity)

        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(.white.opacity(0.1))
        .cornerRadius(12)

    }
}

#Preview {
    ZStack {
        BackgroundGradient()
        DailyForecastRow(item: ForecastData.mock.list[0])
    }
}
