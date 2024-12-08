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
                        if viewModel.userDefaultSelected {
                            userDefaultWeatherView
                        } else {
                            currentWeatherView
                        }
                    }
                case .failure:
                    ProgressView()
                }
            }
            .task {
                viewModel.getUserDefaults()
                if viewModel.selectedCity != "" {
                    Task {
                        await viewModel.fetchWeather(city: viewModel.selectedCity, firstLoad: true)
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                textFieldView
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
    }
    
    @ViewBuilder
    var userDefaultWeatherView: some View {
        VStack {
            if let icon = viewModel.weatherData?.current.condition.icon {
                AsyncImage(url: URL(string: "https:\(icon)")) { result in
                    result.image?
                        .resizable()
                        .scaledToFill()
                }
                .frame(width: 200, height: 200)
            }
            HStack {
                Text(viewModel.weatherData?.location.name ?? "")
                    .font(.title)
                    .fontDesign(.rounded)
                    .fontWeight(.semibold)
                Image(systemName: "location.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            Text("\(Int(viewModel.weatherData?.current.feelslikeF ?? 0) )°")
                .font(.system(size: 60))
                .fontDesign(.rounded)
                .fontWeight(.semibold)
            userDefaultWeatherCard
        }
    }
    
    @ViewBuilder
    var userDefaultWeatherCard: some View {
        RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.1))
            .overlay {
                HStack {
                    VStack(alignment: .center, spacing: 15) {
                        Text("Humidity")
                            .fontDesign(.rounded)
                            .fontWeight(.light).opacity(0.5)
                        Text("\(viewModel.weatherData?.current.humidity ?? 0)%")
                            .fontDesign(.rounded)
                            .fontWeight(.light).opacity(0.8)
                    }
                    Spacer()
                    VStack(alignment: .center, spacing: 15) {
                        Text("UV")
                            .fontDesign(.rounded)
                            .fontWeight(.light).opacity(0.5)
                        Text("\(Int(viewModel.weatherData?.current.uv ?? 0))")
                            .fontDesign(.rounded)
                            .fontWeight(.light).opacity(0.8)
                    }
                    Spacer()
                    VStack(alignment: .center, spacing: 15) {
                        Text("Feels Like")
                            .fontDesign(.rounded)
                            .fontWeight(.light).opacity(0.5)
                        Text("\(Int(viewModel.weatherData?.current.feelslikeF ?? 0))°")
                            .fontDesign(.rounded)
                            .fontWeight(.light).opacity(0.8)
                    }
                }
                .padding()
            }
        .frame(maxHeight: 125)
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    var currentWeatherView: some View {
        Button {
            viewModel.setUserDefaults()
        } label: {
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
