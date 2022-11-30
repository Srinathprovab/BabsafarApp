//
//  MCFlight_details.swift
//  BabSafar
//
//  Created by FCI on 14/10/22.
//

import Foundation

struct MCFlight_details : Codable {
    let summary : [MCSummary]?

    enum CodingKeys: String, CodingKey {

        case summary = "summary"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        summary = try values.decodeIfPresent([MCSummary].self, forKey: .summary)
    }

}
