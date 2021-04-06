# Flight Finder
A flutter app that displays local flight information from https://aviationstack.com

## Preview

[Try Web Version](http://flightfinder.tk)
## Features

- Displays a list of flights in your area, including departure time, arrival time, the airline and the flight number.

- Supports infinite scroll.

- Displays detailed airplane info, airports details and airlines info.

- Displays flight routes on a map.
## To Do

- [X] Implement fake data (dummy_flight_data.json) for testing

- [X] Fake/real data toggle function

- [X] Flight finder screen (including arrival and destination airport dropdowns)

- [X] Flights list screen with infinite scroll

- [ ] Flight information screen (including airplane info, airports details and airlines info)

- [X] Display flight route on map

- [X] Add home button to appbar

## Issues

## Notes
- dummy_flight_data.json created from http://api.aviationstack.com/v1/flights?access_key=a39004f6dc73f46eceaa6d5375191b6d&limit=10000&dep_iata=JNB

- aviationstack.com does not allow https connections on it's free plan. The following has been implemented to avoid Dio().get errors: https://stackoverflow.com/questions/64197752/bad-state-insecure-http-is-not-allowed-by-platform
