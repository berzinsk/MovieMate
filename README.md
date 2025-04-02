# MovieMate

MovieMate is an iOS application designed to provide users with a seamless movie browsing experience. Using data from the [TMDB API](https://www.themoviedb.org/documentation/api), MovieMate allows users to explore movies, view detailed information, and enjoy offline access to their favorite content.

## Features

- Movie List:
  - A curated list of movies fetched from TMDB API
  - Pull-to-refresh functionality for content updates
  - Offline access to previously loaded movies
  - Beautiful movie posters with efficient image caching

- Movie Details:
  - Comprehensive movie information including:
    - Title and overview
    - Release date (formatted for local display)
    - Rating and vote count
    - Popularity metrics
    - Original language
  - High-quality backdrop images
  - Responsive layout optimized for both iPhone and iPad

## Technical Features

- **Clean Architecture**:
  - Separation of concerns with distinct layers:
    - Views: SwiftUI-based user interface
    - ViewModels: Business logic and state management
    - Services: Data access and API communication
    - Models: Data structures and CoreData entities
  - Protocol-oriented design for better testability
  - Dependency injection for improved modularity

- **Data Persistence**:
  - CoreData implementation for local storage
  - Automatic background updates when online
  - Seamless offline/online transition
  - Efficient data synchronization

- **Image Caching**:
  - URLCache-based image caching system
  - Memory and disk caching with configurable limits
  - Remote image loading with placeholder support

- **API Integration**:
  - TMDB API integration for movie data
  - Efficient API response handling
  - Error handling and retry mechanisms
  - Rate limiting consideration

## Getting Started

### Prerequisites

- Xcode 16.0 or later
- iOS 16.0 or later
- TMDB API key

### Installation

1. Clone the repository to your local machine:
```bash
git clone https://github.com/berzinsk/MovieMate
```

2. Create a `Config.swift` file in the project root with your TMDB API key:
```swift
enum APIConfig {
    static let tmdbApiKey = "your_api_key_here"
}
```

3. Open `MovieMate.xcodeproj` in Xcode

4. Select a target device or simulator

5. Press Cmd + R to build and run the application

## Architecture

MovieMate follows a clean architecture pattern with the following key components:

- **Views Layer**:
  - SwiftUI-based views with MVVM pattern
  - Reusable components (e.g., CachedImageView)
  - Responsive layouts using SwiftUI's layout system

- **ViewModels Layer**:
  - Observable state management
  - Business logic implementation
  - Data transformation and formatting

- **Services Layer**:
  - Remote service for API communication
  - Local service for CoreData operations
  - Image caching service
  - Repository pattern for data access

- **Models Layer**:
  - CoreData entities for persistence
  - DTOs for API communication
  - Value objects for business logic

## Testing

The app includes comprehensive unit tests. To run the tests:

1. Open the project in Xcode
2. Select Product > Test or press Cmd + U
3. View test results in the Test Navigator

Test coverage includes:
- ViewModel logic
- Image caching

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE.md` for more information.

## Contact

Kārlis Bērziņš - berzinsh.karlis@gmail.com

Project Link: [https://github.com/berzinsk/MovieMate](https://github.com/berzinsk/MovieMate)
