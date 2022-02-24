//
//  WeatherViewModel.swift
//  Picnic Weather
//
//  Created by Christian Nachtrieb on 2/20/22.
//

import Foundation
import SwiftUI
import CoreLocation

let apiURL = "https://api.lil.software/weather"

class WeatherViewModel: ObservableObject {
    @Published var forecast: [Day] = []
    
    var timer: Timer?
    
    init() {
//        loadForecast()
//        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
//            self?.loadForecast()
//        }
    }
    
//    deinit {
//        timer?.invalidate()
//    }
      
    
    // What do we do if the forecast fails to load? How long do we give it?
    func loadForecast() {
        guard let coords = LocationManager.shared.lastKnownCoordinate else { return }
        
        guard let url = URL(string: "\(apiURL)?latitude=\(coords.latitude)&longitude=\(coords.longitude)") else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let decodedWeather = try JSONDecoder().decode(Weather.self, from: data)
                
                DispatchQueue.main.async {
                    self.forecast = decodedWeather.forecast
                }
            } catch {
                print("Error loading weather:")
            }
        }
        session.resume()
    }
}
