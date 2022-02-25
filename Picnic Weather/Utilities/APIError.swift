//
//  APIError.swift
//  Picnic Weather
//
//  Created by Christian Nachtrieb on 2/24/22.
//

import Foundation

struct ErrorType: Error, Identifiable {
    let id = UUID()
    let error: APIError
    
    // Just making the parameters anonymous
    init(_ error: APIError) {
        self.error = error
    }
}

enum APIError: Error, LocalizedError {
    case invalidCoordinates
    case invalidURL
    case invalidData
    case unableToComplete
    
    var errorDescription: String {
        switch self {
        case .invalidCoordinates: return "Invalid Location"
        case .invalidURL: return "Invalid URL"
        case .invalidData: return "Invalid Data"
        case .unableToComplete: return "Unable to Complete"
        }
    }
}
