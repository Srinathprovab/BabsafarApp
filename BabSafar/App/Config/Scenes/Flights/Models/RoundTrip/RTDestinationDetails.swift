//
//  RTDestinationDetails.swift
//  BabSafar
//
//  Created by FCI on 16/11/22.
//

import Foundation

struct RTDestinationDetails : Codable {
    
    let airportCode : String?
    let cityName : String?
    let airportName : String?
    let dateTime : String?
    let fDTV : String?
    let baggage : String?
    let terminal : String?
    let facilitate : String?
    let marketing_carrier : String?
    let operatingCarrier : String?
    let _DateTime : String?
    let _Date : String?

    enum CodingKeys: String, CodingKey {

        case airportCode = "AirportCode"
        case cityName = "CityName"
        case airportName = "AirportName"
        case dateTime = "DateTime"
        case fDTV = "FDTV"
        case baggage = "Baggage"
        case terminal = "terminal"
        case facilitate = "facilitate"
        case marketing_carrier = "marketing_carrier"
        case operatingCarrier = "operatingCarrier"
        case _DateTime = "_DateTime"
        case _Date = "_Date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        airportCode = try values.decodeIfPresent(String.self, forKey: .airportCode)
        cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
        airportName = try values.decodeIfPresent(String.self, forKey: .airportName)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        fDTV = try values.decodeIfPresent(String.self, forKey: .fDTV)
        baggage = try values.decodeIfPresent(String.self, forKey: .baggage)
        terminal = try values.decodeIfPresent(String.self, forKey: .terminal)
        facilitate = try values.decodeIfPresent(String.self, forKey: .facilitate)
        marketing_carrier = try values.decodeIfPresent(String.self, forKey: .marketing_carrier)
        operatingCarrier = try values.decodeIfPresent(String.self, forKey: .operatingCarrier)
        _DateTime = try values.decodeIfPresent(String.self, forKey: ._DateTime)
        _Date = try values.decodeIfPresent(String.self, forKey: ._Date)
    }

}
