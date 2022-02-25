//
//  Extensions.swift
//  Picnic Weather
//
//  Created by Christian Nachtrieb on 2/20/22.
//

import Foundation
import SwiftUI

extension Int {
    
    public func toString() -> String {
        return String(self)
    }
}

extension Image {
    
    public func iconStyle() -> some View {
        self
            .resizable()
            .foregroundColor(.white)
            .scaledToFit()
            .frame(height: 150)
    }
}
