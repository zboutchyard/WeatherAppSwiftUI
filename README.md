Weather App
Overview
The Weather App is a SwiftUI-based iOS application that provides users with real-time weather updates for their selected city. 
The app is designed with an emphasis on clean architecture, intuitive UI/UX, and reliable performance.



Features
Search Functionality: Users can search for a city to fetch its current weather conditions.
Weather Details: Displays comprehensive weather data including:
Temperature (Celsius/Fahrenheit)
Weather condition (text and icon)
Humidity
UV index
"Feels like" temperature
Local Storage: Persistently saves the selected city using UserDefaults.
Responsive UI: Adheres to Figma design specifications and adjusts seamlessly to device orientations.
Error Handling: Handles API errors gracefully with user-friendly messages.
Technical Architecture
Design Pattern
The application follows the MVVM (Model-View-ViewModel) architecture to ensure separation of concerns and code modularity.

Model: Defines the weather data structures (WeatherData, Location, CurrentWeather).
ViewModel: Manages data flow between the model and the view, including networking and local storage logic.
View: Implements SwiftUI views for search, weather display, and error states.
Code Quality
Clean and modular code ensures readability and maintainability.
Unit tests verify ViewModel logic and network calls.
Networking
Integrated with a weather API for real-time updates.
Smoothly handles edge cases (e.g., no internet, invalid cities).
Uses URLSession for asynchronous API requests.
Local Storage
Selected city is reliably stored using UserDefaults.
Ensures persistent access even after the app is closed and reopened.
