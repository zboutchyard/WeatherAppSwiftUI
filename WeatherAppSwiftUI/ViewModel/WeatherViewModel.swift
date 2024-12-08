//
//  WeatherViewModel.swift
//  WeatherAppSwiftUI
//
//  Created by Zack Boutchyard on 12/7/24.
//

import Foundation

class WeatherViewModel: ObservableObject {
    
    enum LoadingState {
        case loading
        case loaded
        case failure
    }
    
    @Published var weatherData: Weather?
    @Published var loadingState: LoadingState = .loaded
    @Published var selectedCity: String = ""
    @Published var userDefaultSelected: Bool = false
    
    
    
    // can add more protocols to resolver, could make base resolver but typealias is fine for now.
    typealias Resolver = WeatherFetching
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver       
    }
    
    @MainActor
    public func fetchWeather(city: String, firstLoad: Bool = false) async {
        selectedCity = city
        do {
            if firstLoad == false {
                clearUserDefaults()
            }
            loadingState = .loading
            weatherData = try await resolver.fetchWeather(for: selectedCity)
            loadingState = .loaded
        } catch {
            loadingState = .failure
        }
    }
    
    public func setUserDefaults() {
        UserDefaults.standard.set(selectedCity, forKey: "selectedCity")
        userDefaultSelected = true
    }
    
    @MainActor
    public func getUserDefaults() {
        self.selectedCity = UserDefaults.standard.string(forKey: "selectedCity") ?? ""
        if self.selectedCity != "" {
            userDefaultSelected = true
        }
    }
    
    public func clearUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "selectedCity")
        userDefaultSelected = false
    }
}
