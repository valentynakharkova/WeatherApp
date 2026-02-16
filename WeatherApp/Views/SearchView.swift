//
//  SearchView.swift
//  WeatherApp
//
//  Created by Valentyna Kharkova on 15.02.2026.
//

import SwiftUI

struct SearchView: View {
    
    let viewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            //MARK: background
            LinearGradient(
                colors: [
                    Color("BackgroundGradientStart"),
                    Color("BackgroundGradientEnd")
                        ],
                startPoint: .top,
                endPoint: .bottom
            ).ignoresSafeArea()
            
        }
    }
}

#Preview {
    SearchView()
}
