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
    
    
    
    // can add more protocols to resolver, could make base resolver but typealias is fine for now.
    typealias Resolver = WeatherFetching
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    @MainActor
    public func fetchWeather(city: String) async {
        selectedCity = city
        do {
            loadingState = .loading
            weatherData = try await resolver.fetchWeather(for: selectedCity)
            loadingState = .loaded
        } catch {
            loadingState = .failure
        }
    }
    
    //    public func setUserDefaults() {
    //        UserDefaults.setValue(city)
    //    }
    
    //    getUserDefaults() {
    //        UserDefaults.
    //    }
}
