//
//  WeatherViewModel.swift
//  Picnic Weather
//
//  Created by Christian Nachtrieb on 2/20/22.
//

import Foundation
import SwiftUI
import CoreLocation

class WeatherViewModel: ObservableObject {
    
    @Published var forecast: [Day] = []
    @Published var error: ErrorType? = nil
    
    func loadForecast() async {
        
        guard let coordinates = LocationManager.shared.lastKnownCoordinate else {
            error = ErrorType(.invalidCoordinates)
            return }
        
        guard let url = URL(string: "https://api.lil.software/weather?latitude=\(coordinates.latitude)&longitude=\(coordinates.longitude)") else {
            error = ErrorType(.invalidURL)
            return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedWeather = try JSONDecoder().decode(Weather.self, from: data)
            DispatchQueue.main.async { self.forecast = decodedWeather.forecast }
            
        } catch {
            DispatchQueue.main.async { self.error = ErrorType(.invalidData) }
        }
    }
}
    
    
    
    
    
    
    
    
    
    








    
    // Using "async throws" here & so we have to handle the proper task handlng on our View
    // Any errors from this function will get thrown up and handled top level where it was called.
    // Anytime we see the word "try" it means the method can throw an error
    
//    func fetchForecast() async throws {
//        let apiURL = "https://api.lil.software/weather"
//
//        guard let coordinates = LocationManager.shared.lastKnownCoordinate else { throw APIError.invalidCoordinates }
//        let url = URL(string: "\(apiURL)?latitude=\(coordinates.latitude)&longitude=\(coordinates.longitude)")
//        let (data, _) = try await URLSession.shared.data(from: url!)
//        let decodedWeather = try JSONDecoder().decode(Weather.self, from: data)
//
//        DispatchQueue.main.async {
//            self.forecast = decodedWeather.forecast
//        }
//    }
    
    
    
    
    
    
    
    
    
    
    // Don't need "async throws" because the error is handled from within the function
    // If it's written async throws, the error needs to be handled top level somewhere
    // Think of "throws" as like throwing away the responsibility?
    // We can also use the Task {} and then not have to put that on our View
    
//    func oldLoadForecast() async {
//        //    Task {
//        let apiURL = "https://api.lil.software/weather"
//
//        do {
//            guard let coords = LocationManager.shared.lastKnownCoordinate else {
//                throw APIError.invalidCoordinates
//            }
//            guard let url = URL(string: "\(apiURL)?latitude=\(coords.latitude)&longitude=\(coords.longitude)") else {
//                throw APIError.invalidURL
//            }
//
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let decodedWeather = try JSONDecoder().decode(Weather.self, from: data)
//
//            DispatchQueue.main.async {
//                self.forecast = decodedWeather.forecast
//            }
//        } catch {
//            DispatchQueue.main.async {
//                self.error = error
//            }
//        }
//    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //  Old way of doing it with a completion handler
    //
    //    func fetchForecast(completed: @escaping (Result<Weather, APIError>) -> Void) {
    //        guard let coords = LocationManager.shared.lastKnownCoordinate else {
    //            completed(.failure(.invalidCoordinates))
    //            return
    //        }
    //
    //        guard let url = URL(string: "\(apiURL)?latitude=\(coords.latitude)&longitude=\(coords.longitude)") else {
    //            completed(.failure(.invalidURL))
    //            return
    //        }
    //
    //        let task = URLSession.shared.dataTask(with: url) { data, _, error in
    //            if let _ = error {
    //                completed(.failure(.unableToComplete))
    //                return
    //            }
    //
    //            guard let data = data else {
    //                completed(.failure(.invalidData))
    //                return
    //            }
    //
    //            do {
    //                let decodedWeather = try JSONDecoder().decode(Weather.self, from: data)
    //                completed(.success(decodedWeather))
    //            } catch {
    //                completed(.failure(.invalidData))
    //            }
    //        }
    //        task.resume()
    //    }
    
    
    
    
  

