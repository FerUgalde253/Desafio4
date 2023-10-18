//
//  ClimaData.swift
//  ClimaApp
//
//  Created by Fernando Ugalde on 11/09/23.
//

import Foundation
struct WeatherData: Decodable {
    let name: String
    let id: Int
    let main: Main
    let weather: [Weather]
    
}
struct Main: Decodable{
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
