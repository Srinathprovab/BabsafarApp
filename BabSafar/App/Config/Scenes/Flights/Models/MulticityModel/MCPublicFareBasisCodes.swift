//
//  MCPublicFareBasisCodes.swift
//  BabSafar
//
//  Created by FCI on 14/10/22.
//

import Foundation

struct MCPublicFareBasisCodes : Codable {
    let publicFareBasisCodes_value : String?

    enum CodingKeys: String, CodingKey {

        case publicFareBasisCodes_value = "publicFareBasisCodes_value"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        publicFareBasisCodes_value = try values.decodeIfPresent(String.self, forKey: .publicFareBasisCodes_value)
    }

}
