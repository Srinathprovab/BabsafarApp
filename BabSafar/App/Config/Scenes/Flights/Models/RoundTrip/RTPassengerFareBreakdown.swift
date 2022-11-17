//
//  RTPassengerFareBreakdown.swift
//  BabSafar
//
//  Created by FCI on 16/11/22.
//

import Foundation

struct RTPassengerFareBreakdown : Codable {
    let aDT : RTADT?

    enum CodingKeys: String, CodingKey {

        case aDT = "ADT"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        aDT = try values.decodeIfPresent(RTADT.self, forKey: .aDT)
    }

}
