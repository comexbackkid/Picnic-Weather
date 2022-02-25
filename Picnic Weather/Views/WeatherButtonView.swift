//
//  WeatherButtonView.swift
//  Picnic Weather
//
//  Created by Christian Nachtrieb on 2/25/22.
//

import SwiftUI

struct WeatherButtonView: View {
    
    let title: String
    var imageName: String?
    
    var body: some View {
        HStack {
            Text(title)
                .bold()
                .foregroundColor(.black)
            
            if let image = imageName {
                Image(systemName: image)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(Capsule())
        .padding()
    }
}

struct WeatherButtonView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherButtonView(title: "Sample text!", imageName: "location.fill")
            .preferredColorScheme(.dark)
    }
}
