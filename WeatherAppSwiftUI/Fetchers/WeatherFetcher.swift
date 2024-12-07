//
//  WeatherFetcher.swift
//  WeatherAppSwiftUI
//
//  Created by Zack Boutchyard on 12/7/24.
//

import Foundation

class WeatherFetcher: WeatherFetching {
    private let apiKey = "b50f9b36ec79404aacc200638240712"
    private let baseURL = "api.weatherapi.com/v1"
    
    func fetchWeather(for city: String) async throws -> Weather {
        guard let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(city)&aqi=no") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let weatherData = try JSONDecoder().decode(Weather.self, from: data)
        return weatherData
    }
}
