//
//  CardView.swift
//  Picnic Weather
//
//  Created by Christian Nachtrieb on 2/19/22.
//

import SwiftUI

struct CardView: View {
    
    let day: Day
    
    var body: some View {
        VStack {
            
            Text(day.name)
                .font(.subheadline)
                .bold()
                .lineLimit(1)
            
            Spacer()
            
            // This new Image is deriving its string from computed property in our Day struct
            Image(systemName: day.cardIcon ?? day.icon?.imageName ?? "smoke.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
                .symbolRenderingMode(.multicolor)
            
            Spacer()
            
            Text(day.description)
                .font(.caption2)
                .lineLimit(1)
                
        }
        .padding()
        .frame(width: 150, height: 150)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(day: Day(name: "Tomorrow", temperature: 20, description: "Rain showers"))
    }
}
