//
//  WeatherView.swift
//  Picnic Weather
//
//  Created by Christian Nachtrieb on 2/19/22.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    
    @StateObject var vm = WeatherViewModel()
    @ObservedObject var locationMgr = LocationManager.shared
    
    var body: some View {
        
        // Using Group because we can produce different kinds of views from a conditional
        Group {
            
            if locationMgr.locationAuth {
                VStack {
                    headerView
                    Spacer()
                    mainWeatherView
                    Spacer()
                    
                    if !vm.forecast.isEmpty {
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack (spacing: 15) {
                                
                                ForEach(1..<5, id: \.self) { day in
                                    CardView(day: vm.forecast[day])
                                }
                            }
                            .padding(.leading)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .onReceive(locationMgr.objectWillChange) { _ in
                    Task {
                        await vm.loadForecast()
                    }
                }
                
            } else {
                startView
            }
        }
        .frame(maxHeight: .infinity)
        .background(RadialGradient(colors: [Color("secondary"), Color("primary")],
                                   center: .topLeading,
                                   startRadius: 5,
                                   endRadius: 500))
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
            .preferredColorScheme(.dark)
    }
}

extension WeatherView {
    
    // Onboarding view that requests user's location
    private var startView: some View {
        VStack {
            
            Spacer()
            
            Image("ant")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .padding(.bottom, 30)
            
            Text("Welcome to Picnic Weather!")
                .fontWeight(.bold)
                .font(.title2)
                .padding(.horizontal)
                .padding(10)
                .foregroundColor(.white)
            
            Text("To get started, click the button below to allow location sharing. You can always opt out in the future by going to your Settings in iOS.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundColor(.white)
            
            Spacer()
            
            if locationMgr.manager.authorizationStatus == .denied {
                Text("Location services disabled.")
                    .bold()
                    .padding(.horizontal)
                    .padding(32)
                    .foregroundColor(.white)
            } else {
                Button {
                    self.locationMgr.start()
                } label: {
                    WeatherButtonView(title: "Share Location", imageName: "location.fill")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .alert(item: $locationMgr.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  primaryButton: alertItem.primaryButton,
                  secondaryButton: alertItem.secondaryButton)
        }
    }
    
    // User's location within nearest three kilometers
    private var headerView: some View {
        HStack {
            
            Text(self.locationMgr.cityName?.uppercased() ?? "")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding(.top, 10)
    }
    
    // Main screen with Day, Weather Description, and Icon
    private var mainWeatherView: some View {
        VStack (spacing: 5) {
            
            if let day = vm.forecast.first {
                
                Text(day.name)
                    .foregroundColor(.white)
                    .font(.title)
                
                Text(day.description)
                    .bold()
                    .font(.subheadline)
                    .padding(.bottom, 20)
                    .foregroundColor(.white)
                
                if let icon = day.weatherIcon {
                    Image(systemName: icon)
                        .iconStyle()
                    
                } else {
                    Image(systemName: "cloud.fill")
                        .iconStyle()
                }
                
                Text(day.temperature.toString() + "ºF")
                    .font(.system(size: 70))
                    .foregroundColor(.white)
                    .padding(.top)
                
            } else {
                VStack {
                    
                    ProgressView()
                        .padding(.bottom)
                        .foregroundColor(.white)
                    
                    if let error = vm.error {
                        Text("Uh oh, we've hit a snag.")
                            .bold()
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.bottom)
                        
                        Text("Error: " + error.error.errorDescription)
                            .padding()
                        
                        Button {
                            Task {
                                await vm.loadForecast()
                            }
                            
                        } label: {
                            WeatherButtonView(title: "Try again")
                        }
                    }
                }
            }
        }
    }
}
