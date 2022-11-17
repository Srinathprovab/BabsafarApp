//
//  RTRaw_flight_list.swift
//  BabSafar
//
//  Created by FCI on 16/11/22.
//

import Foundation

struct RTRaw_flight_list : Codable {
    let journeySummary : RTJourneySummary?
    let flights : [[RTFlights]]?

    enum CodingKeys: String, CodingKey {

        case journeySummary = "JourneySummary"
        case flights = "Flights"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        journeySummary = try values.decodeIfPresent(RTJourneySummary.self, forKey: .journeySummary)
        flights = try values.decodeIfPresent([[RTFlights]].self, forKey: .flights)
    }

}
