//
//  Alerts.swift
//  Picnic Weather
//
//  Created by Christian Nachtrieb on 2/25/22.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let primaryButton: Alert.Button
    let secondaryButton: Alert.Button
}

struct AlertContext {
    static let deniedPermission = AlertItem(title: Text("Location Services Disabled"),
                                            message: Text("Picnic Weather needs access to your current location in order to provide you with accurate weather information."),
                                            primaryButton: .default(Text("OK")),
                                            secondaryButton: .default(Text("Settings"), action: {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!,
                                  options: [:],
                                  completionHandler: nil)
    }))
}
