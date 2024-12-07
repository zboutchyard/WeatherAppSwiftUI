//
//  WeatherFetching.swift
//  WeatherAppSwiftUI
//
//  Created by Zack Boutchyard on 12/7/24.
//

import Foundation

protocol WeatherFetching {
    func fetchWeather(for city: String) async throws -> Weather
}
