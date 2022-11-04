//
//  MCFlight_details.swift
//  BabSafar
//
//  Created by FCI on 14/10/22.
//

import Foundation

struct MCFlight_details : Codable {
    let summary : [MCSummary]?
    let details : [[MCDetails]]?

    enum CodingKeys: String, CodingKey {

        case summary = "summary"
        case details = "details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        summary = try values.decodeIfPresent([MCSummary].self, forKey: .summary)
        details = try values.decodeIfPresent([[MCDetails]].self, forKey: .details)
    }

}
