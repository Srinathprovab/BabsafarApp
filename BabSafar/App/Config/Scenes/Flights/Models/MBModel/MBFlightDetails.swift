//
//  MBFlightDetails.swift
//  BabSafar
//
//  Created by FCI on 06/12/22.
//

import Foundation

struct MBFlightDetails : Codable {
  
    let details : [[MBdetails]]?

    enum CodingKeys: String, CodingKey {
        case details = "details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        details = try values.decodeIfPresent([[MBdetails]].self, forKey: .details)
    }

}
