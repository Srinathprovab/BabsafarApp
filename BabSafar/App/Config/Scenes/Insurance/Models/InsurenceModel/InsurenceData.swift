//
//  InsurenceData.swift
//  BabSafar
//
//  Created by FCI on 22/08/23.
//

import Foundation

struct InsurenceData : Codable {
    let col_x : Col_x?

    enum CodingKeys: String, CodingKey {

        case col_x = "col_x"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        col_x = try values.decodeIfPresent(Col_x.self, forKey: .col_x)
    }

}
