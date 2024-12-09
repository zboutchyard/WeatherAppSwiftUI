<h1>Weather App</h1>
<h3>Overview</h3>
<p>The Weather App is a SwiftUI-based iOS application that provides users with real-time weather updates for their selected city. <br> The app is designed with an emphasis on clean architecture, intuitive UI/UX, and reliable performance.</p> 




<h1>Features</h1>
<h3>Search Functionality: </h3>
<p>Users can search for a city to fetch its current weather conditions.</p>
<h3>Weather Details:</h3> Displays comprehensive weather data including:
Temperature (Celsius/Fahrenheit)
Weather condition (text and icon)
Humidity
UV index
"Feels like" temperature
<h3>Local Storage:</h3>Persistently saves the selected city using UserDefaults.
<h3>Responsive UI:</h3> Adheres to Figma design specifications and adjusts seamlessly to device orientations.
<h3></h3>Error Handling: </h3> Handles API errors gracefully with user-friendly messages.
<h1>Technical Architecture</h1>
<h3>Design Pattern</h3>
The application follows the MVVM (Model-View-ViewModel) architecture to ensure separation of concerns and code modularity.

<h3>Model:</h3> Defines the weather data structures (WeatherData, Location, CurrentWeather).
<h3>ViewModel:</h3> Manages data flow between the model and the view, including networking and local storage logic.
<h3>View:</h3> Implements SwiftUI views for search, weather display, and error states.
