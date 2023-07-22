//
//  Transaction.swift
//  BabSafar
//
//  Created by FCI on 27/02/23.
//

import Foundation

struct Transaction : Codable {
    let currency : String?
    let fare : String?

    enum CodingKeys: String, CodingKey {

        case currency = "currency"
        case fare = "fare"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        fare = try values.decodeIfPresent(String.self, forKey: .fare)
    }

}
