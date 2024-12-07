//
//  ContentView.swift
//  WeatherAppSwiftUI
//
//  Created by Zack Boutchyard on 12/7/24.
//

import SwiftUI

struct ContentView: View {
    @State var selectedLocation: String = ""
       @StateObject var viewModel: WeatherViewModel

       init(resolver: WeatherFetching = WeatherFetcher()) {
           _viewModel = StateObject(wrappedValue: WeatherViewModel(resolver: resolver))
       }

    var body: some View {
            VStack {
                switch viewModel.loadingState {
                case .loading:
                    ProgressView()
                case .loaded:
                    if viewModel.selectedCity == "" {
                        noCitySelectedView
                    } else {
                        currentWeatherView
                    }
                case .failure:
                    ProgressView()
                }
            }
            .safeAreaInset(edge: .top) {
                textFieldView
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
    }
    
    @ViewBuilder
    var currentWeatherView: some View {
                RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1))
                    .overlay {
                        HStack {
                            VStack(alignment: .center) {
                                Text(viewModel.weatherData?.location.name ?? "")
                                    .font(.callout)
                                    .fontDesign(.rounded)
                                    .fontWeight(.semibold)
                                Text("\(Int(viewModel.weatherData?.current.feelslikeF ?? 0) )°")
                                    .font(.system(size: 60))
                                    .fontDesign(.rounded)
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            VStack {
                                if let icon = viewModel.weatherData?.current.condition.icon {
                                    AsyncImage(url: URL(string: "https:\(icon)")) { result in
                                        result.image?
                                            .resizable()
                                            .scaledToFill()
                                    }
                                    .frame(width: 200, height: 200)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding()
                    }
                .frame(maxHeight: 150)
                .padding(.top)
    }
    
    @ViewBuilder
    var noCitySelectedView: some View {
        VStack {
            Text("No City Selected")
                .font(.largeTitle)
                .fontDesign(.rounded)
                .fontWeight(.semibold)
            Text("Please Search For A City")
                .font(.callout)
                .fontDesign(.rounded)
                .fontWeight(.semibold)
                .padding(.top, 1)
            Spacer()
                .frame(height: 400)
        }
        .padding()
        .padding(.top, 100)
    }
    
    
    @ViewBuilder
    var textFieldView: some View {
        TextField(text: $selectedLocation) {
            VStack {
                Text("Search Location")
            }
        }
        .onSubmit {
            Task {
                await viewModel.fetchWeather(city: selectedLocation)
            }
        }
        .overlay(
            HStack {
                Spacer()
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray.opacity(0.4))
                    .padding(.trailing, 20)
            }
        )
        .textFieldStyle(OvalTextFieldStyle())
    }
}

#Preview {
    ContentView()
}
