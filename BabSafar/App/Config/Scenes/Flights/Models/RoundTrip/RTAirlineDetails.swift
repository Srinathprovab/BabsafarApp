//
//  RTAirlineDetails.swift
//  BabSafar
//
//  Created by FCI on 16/11/22.
//

import Foundation

struct RTAirlineDetails : Codable {
    let airlineCode : String?
    let airlineName : String?
    let flightNumber : String?
    let fareClass : String?
    let flightImage : String?

    enum CodingKeys: String, CodingKey {

        case airlineCode = "AirlineCode"
        case airlineName = "AirlineName"
        case flightNumber = "FlightNumber"
        case fareClass = "FareClass"
        case flightImage = "flightImage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        airlineCode = try values.decodeIfPresent(String.self, forKey: .airlineCode)
        airlineName = try values.decodeIfPresent(String.self, forKey: .airlineName)
        flightNumber = try values.decodeIfPresent(String.self, forKey: .flightNumber)
        fareClass = try values.decodeIfPresent(String.self, forKey: .fareClass)
        flightImage = try values.decodeIfPresent(String.self, forKey: .flightImage)
    }

}
