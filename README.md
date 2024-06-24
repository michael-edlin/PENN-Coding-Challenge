# PENN Coding Challenge

## Overview

The PENN Code Challenge application is designed to fetch and display Air Quality Index (AQI) scores from a free API based on the user's current location. The app allows users to view AQI data for the current day, one day prior, and one day in the future. Additionally, users can enter another location to fetch AQI information. This project incorporates modern Swift features, including async/await for network requests, and integrates Firebase Authentication for user login functionality.

## Goal

- Fetch AQI scores from a free API.
- Display AQI data based on user’s current location.
- Show AQI information for one day prior and one day in the future.
- Allow users to enter another location to fetch AQI information.
- Implement user authentication using Firebase.
- Showcase a simple SwiftUI integration within a UIKit application.

## Tools, Packages, and APIs Used

- **UIKit**: For the main application UI.
- **SwiftUI**: For the sign-out button using HostingController.
- **Firebase Authentication**: For user login functionality.
- **CoreLocation**: For fetching user’s current location.
- **Combine**: For handling asynchronous events.
- **Jira**: For project management and tracking.
  ```bash
  https://tyedlin.atlassian.net/jira/software/projects/KAN/boards/1
- **GitHub**: For version control and collaboration.

## Features

- **Launch Screen**: Displays when the app is launched.
- **Main View**: Shows AQI data for the current location with options to select predefined locations.
- **Location Selection**: Users can choose a different location to fetch AQI data.
- **User Authentication**: Users can sign in or create an account using Firebase Authentication.
- **AQI Data**: Displays AQI scores for the current day, one day prior, and one day in the future.
- **Weather Station Information**: Displays the name of the weather station providing the data.
- **SwiftUI Integration**: Demonstrates how to integrate SwiftUI components into a UIKit application.

## Setup and Usage

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/michael-edlin/PENN-Coding-Challenge.git
   cd PENN-Coding-Challenge

## Navigational Setup Screenshot
![Screenshot 2024-06-24 at 1 44 19 PM](https://github.com/michael-edlin/PENN-Coding-Challenge/assets/80922342/b7ce0244-667e-4a93-b4a5-8ca825154aa7) 

## Launch Screen LoginView Screenshot
![Simulator Screenshot - iPhone 15 Pro - 2024-06-24 at 13 41 18](https://github.com/michael-edlin/PENN-Coding-Challenge/assets/80922342/21cfd359-52dc-46bd-a392-5479aa9d5478)

## HomeView UI Layout Screenshot
![Simulator Screenshot - iPhone 15 Pro - 2024-06-24 at 13 42 10](https://github.com/michael-edlin/PENN-Coding-Challenge/assets/80922342/83afd8d0-1739-40cc-91ef-8adc1ae389a0)

## HomeView LocationSearch Screenshot
![Simulator Screenshot - iPhone 15 Pro - 2024-06-24 at 13 42 30](https://github.com/michael-edlin/PENN-Coding-Challenge/assets/80922342/99779243-2d5f-4412-857b-6256ce5987d1)

## HomeView API Data Fetched Screenshot
![Simulator Screenshot - iPhone 15 Pro - 2024-06-24 at 13 42 47](https://github.com/michael-edlin/PENN-Coding-Challenge/assets/80922342/96834615-4a2e-4c09-873d-1787e7b17b9a)

## Raw JSON Response

```json
{
  "status": "ok",
  "data": {
    "aqi": 50,
    "idx": 3900,
    "attributions": [
      {
        "url": "http://www.arb.ca.gov/",
        "name": "CARB - California Air Resources Board",
        "logo": "USA-CAARB.png"
      },
      {
        "url": "http://www.airnow.gov/",
        "name": "Air Now - US EPA"
      },
      {
        "url": "https://waqi.info/",
        "name": "World Air Quality Index Project"
      }
    ],
    "city": {
      "geo": [37.76595, -122.39902],
      "name": "San Francisco-Arkansas Street, San Francisco, California",
      "url": "https://aqicn.org/city/california/san-francisco/san-francisco-arkansas-street",
      "location": ""
    },
    "dominentpol": "pm25",
    "iaqi": {
      "co": {"v": 4.5},
      "h": {"v": 71.5},
      "no2": {"v": 3.5},
      "o3": {"v": 16},
      "p": {"v": 1012.3},
      "pm25": {"v": 50},
      "t": {"v": 17.6},
      "w": {"v": 3.1},
      "wg": {"v": 7.8}
    },
    "time": {
      "s": "2024-06-24 09:00:00",
      "tz": "-07:00",
      "v": 1719219600,
      "iso": "2024-06-24T09:00:00-07:00"
    },
    "forecast": {
      "daily": {
        "o3": [
          {"avg": 14, "day": "2024-06-22", "max": 22, "min": 11},
          {"avg": 11, "day": "2024-06-23", "max": 16, "min": 8},
          {"avg": 12, "day": "2024-06-24", "max": 19, "min": 11},
          {"avg": 12, "day": "2024-06-25", "max": 19, "min": 10},
          {"avg": 13, "day": "2024-06-26", "max": 17, "min": 12},
          {"avg": 12, "day": "2024-06-27", "max": 17, "min": 11},
          {"avg": 11, "day": "2024-06-28", "max": 18, "min": 10}
        ],
        "pm10": [
          {"avg": 13, "day": "2024-06-22", "max": 17, "min": 11},
          {"avg": 6, "day": "2024-06-23", "max": 10, "min": 5},
          {"avg": 8, "day": "2024-06-24", "max": 10, "min": 6},
          {"avg": 9, "day": "2024-06-25", "max": 10, "min": 7},
          {"avg": 7, "day": "2024-06-26", "max": 9, "min": 6},
          {"avg": 5, "day": "2024-06-27", "max": 6, "min": 3},
          {"avg": 6, "day": "2024-06-28", "max": 8, "min": 5}
        ],
        "pm25": [
          {"avg": 29, "day": "2024-06-22", "max": 40, "min": 22},
          {"avg": 13, "day": "2024-06-23", "max": 20, "min": 10},
          {"avg": 16, "day": "2024-06-24", "max": 21, "min": 13},
          {"avg": 21, "day": "2024-06-25", "max": 24, "min": 18},
          {"avg": 14, "day": "2024-06-26", "max": 23, "min": 10},
          {"avg": 9, "day": "2024-06-27", "max": 12, "min": 7}
        ]
      }
    }
  }
}
