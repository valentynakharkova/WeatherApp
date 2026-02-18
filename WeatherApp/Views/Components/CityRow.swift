//
//  CityRow.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 17.02.2026.
//

import SwiftUI

struct CityRow: View {
    
    let city: GeocodingData
    let onTap: (() -> Void)?
    
    var body: some View {
        Button {
            onTap?()
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(city.name)
                        .font(.headline)
                        .foregroundStyle(.white)
                    Text(city.displayName)
                        .font(.subheadline)
                        .foregroundStyle(.thinMaterial)
                }
                Spacer()
                                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white.opacity(0.5))
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(12)
        }
    }
}

#Preview {
    ZStack {
        BackgroundGradient()
        CityRow(city: .mockKyiv, onTap: nil)
            .padding()
    }
}
