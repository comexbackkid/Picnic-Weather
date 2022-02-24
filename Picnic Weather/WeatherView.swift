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
        // Something like a .onAppear() will then fire on each view
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
                    vm.loadForecast()
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
    
    private var startView: some View {
        VStack {
            
            Spacer()
            
            Image(systemName: "ant.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .foregroundColor(.white)
            
            Text("Welcome to Picnic Weather!")
                .fontWeight(.heavy)
                .padding()
                .foregroundColor(.white)
            
            Text("Share your location in order to receive accurate weather ⛅️")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.white)
            
            Spacer()
            
            Button {
                self.locationMgr.start()
                
            } label: {
                Text("Share location")
                    .bold()
                    .foregroundColor(.black)
                
                Image(systemName: "location.fill")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .clipShape(Capsule())
            .padding()
        }
        .padding()
    }
    
    private var headerView: some View {
        HStack {
            
            Text(self.locationMgr.cityName?.uppercased() ?? "")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
        }
        .padding(.top, 10)
    }
    
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
                
                if let icon = day.icon {
                    icon.image
                        .iconStyle()
                    
                } else {
                    Image(systemName: "cloud.fill")
                        .iconStyle()
                }
                
                Text(day.temperature.toString() + "ºF")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top)
            } else {
                ProgressView()
            }
        }
    }
}
