//
//  RTJourneySummary.swift
//  BabSafar
//
//  Created by FCI on 16/11/22.
//

import Foundation

struct RTJourneySummary : Codable {
    let origin : String?
    let destination : String?
    let isDomestic : Bool?
    let roundTrip : Bool?
    let multiCity : Bool?
    let passengerConfig : RTPassengerConfig?
    let isDomesticRoundway : Bool?

    enum CodingKeys: String, CodingKey {

        case origin = "Origin"
        case destination = "Destination"
        case isDomestic = "IsDomestic"
        case roundTrip = "RoundTrip"
        case multiCity = "MultiCity"
        case passengerConfig = "PassengerConfig"
        case isDomesticRoundway = "IsDomesticRoundway"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        destination = try values.decodeIfPresent(String.self, forKey: .destination)
        isDomestic = try values.decodeIfPresent(Bool.self, forKey: .isDomestic)
        roundTrip = try values.decodeIfPresent(Bool.self, forKey: .roundTrip)
        multiCity = try values.decodeIfPresent(Bool.self, forKey: .multiCity)
        passengerConfig = try values.decodeIfPresent(RTPassengerConfig.self, forKey: .passengerConfig)
        isDomesticRoundway = try values.decodeIfPresent(Bool.self, forKey: .isDomesticRoundway)
    }

}
