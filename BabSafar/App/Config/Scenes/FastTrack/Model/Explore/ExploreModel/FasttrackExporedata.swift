//
//  FasttrackExporedata.swift
//  BabSafar
//
//  Created by FCI on 04/09/23.
//

import Foundation

struct FasttrackExporedata : Codable {
    let col_x : ECol_x?

    enum CodingKeys: String, CodingKey {

        case col_x = "col_x"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        col_x = try values.decodeIfPresent(ECol_x.self, forKey: .col_x)
    }

}
