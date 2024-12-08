//
//  WeatherFetching.swift
//  WeatherAppSwiftUI
//
//  Created by Zack Boutchyard on 12/7/24.
//

import Foundation

protocol WeatherFetching {
    // made protocol to make testing easier through use of mocks. Could use playground dependency resolver in test to return different instance/ mock response of Weather.
    func fetchWeather(for city: String) async throws -> Weather
}
