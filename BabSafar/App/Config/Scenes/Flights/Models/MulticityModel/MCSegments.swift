//
//  MCSegments.swift
//  BabSafar
//
//  Created by FCI on 14/10/22.
//

import Foundation

struct MCSegments : Codable {
    
    let mc0 : MC0?
    let flightDetailsRef_Key : String?
    let mc1 : MC1?

    enum CodingKeys: String, CodingKey {

        case mc0 = "0"
        case flightDetailsRef_Key = "FlightDetailsRef_Key"
        case mc1 = "1"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mc0 = try values.decodeIfPresent(MC0.self, forKey: .mc0)
        flightDetailsRef_Key = try values.decodeIfPresent(String.self, forKey: .flightDetailsRef_Key)
        mc1 = try values.decodeIfPresent(MC1.self, forKey: .mc1)
    }

}
