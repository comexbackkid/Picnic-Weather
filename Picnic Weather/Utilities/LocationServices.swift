//
//  LocationServices.swift
//  Picnic Weather
//
//  Created by Christian Nachtrieb on 2/22/22.
//

import Foundation
import CoreLocation
import SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // You can store anything here related to the location if we want like speed, altitude, coordinates, distance, etc.
    // We're just using coordinates becuase our Weather API needs coordinates to get us the weather data
    @Published var lastKnownCoordinate: CLLocationCoordinate2D?
    @Published var cityName: String?
    @Published var locationAuth: Bool = false
    
    // This is a singleton, you create the Object once, then it can be used or shared everywhere. Sometimes named "shared"
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    // Giving a new init, but also calling the original one
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        updateAuthorizationStatus()
    }
    
    // We put the request in a function that gets called after user clicks the Location button, but it can also go in the super init
    // Can also rename this function to something like: func requestLocation()
    func start() {
        manager.requestWhenInUseAuthorization()
    }
    
    // This function is what monitors changes of the user's location status
    // We can add a switch statement to determine actions based on the user's status
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        updateAuthorizationStatus()
    }
    
    func updateAuthorizationStatus() {
        switch manager.authorizationStatus {
            
        case .notDetermined: print("DEBUG: Status not determined.")
        case .restricted: print("DEBUG: Status restricted due to parental controls.")
        case .denied: print("DEBUG: Denied.")
        case .authorizedAlways: print("Status always authorized.")
        case .authorizedWhenInUse: self.locationAuth = true
            print("Status authorized when in use.")
        @unknown default: break
        }
    }
    
    // This function is what actually receives the user's location data
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.first else { return }
        
        DispatchQueue.main.async {
            self.lastKnownCoordinate = userLocation.coordinate
            self.getCityName(location: userLocation)
        }
    }
    
    // Geocode has a method called reverseGeocode that takes in a CLLocation object and let's you grab the city or street, etc.
    func getCityName(location: CLLocation) {
        geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
            
            if error == nil {
                DispatchQueue.main.async {
                    self.cityName = places?.first?.locality
                }
                
            } else {
                self.cityName = "LOCATION UNKNOWN"
            }
        })
    }
}
