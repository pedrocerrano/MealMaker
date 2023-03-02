//
//  NetworkError.swift
//  MealMaker
//
//  Created by iMac Pro on 3/1/23.
//

import Foundation

enum NetworkError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    case emptyArray
    case unsuccessfulStatusCode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL. Check your endpoint."
        case .thrownError(let error):
            return "Thrown error: \(error.localizedDescription)"
        case .noData:
            return "No data received from successful network fetch."
        case .unableToDecode:
            return "Unable to decode model object from data."
        case .emptyArray:
            return "Unable to retrieve recipe from array, as the array was empty."
        case .unsuccessfulStatusCode:
            return "Fetch returned an unsuccessful Status Code that wasn't 200."
        }
    }
}
