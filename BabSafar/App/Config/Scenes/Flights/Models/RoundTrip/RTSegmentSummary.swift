//
//  RTSegmentSummary.swift
//  BabSafar
//
//  Created by FCI on 16/11/22.
//

import Foundation

struct RTSegmentSummary : Codable {
    let airlineDetails : RTAirlineDetails?
    let originDetails : RTOriginDetails?
    let destinationDetails : RTDestinationDetails?
    let totalStops : Int?
    let totalDuaration : String?

    enum CodingKeys: String, CodingKey {

        case airlineDetails = "AirlineDetails"
        case originDetails = "OriginDetails"
        case destinationDetails = "DestinationDetails"
        case totalStops = "TotalStops"
        case totalDuaration = "TotalDuaration"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        airlineDetails = try values.decodeIfPresent(RTAirlineDetails.self, forKey: .airlineDetails)
        originDetails = try values.decodeIfPresent(RTOriginDetails.self, forKey: .originDetails)
        destinationDetails = try values.decodeIfPresent(RTDestinationDetails.self, forKey: .destinationDetails)
        totalStops = try values.decodeIfPresent(Int.self, forKey: .totalStops)
        totalDuaration = try values.decodeIfPresent(String.self, forKey: .totalDuaration)
    }

}
