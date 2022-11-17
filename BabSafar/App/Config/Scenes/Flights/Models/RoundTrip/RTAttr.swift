//
//  RTAttr.swift
//  BabSafar
//
//  Created by FCI on 16/11/22.
//

import Foundation

struct RTAttr : Codable {
    let search_id : Int?

    enum CodingKeys: String, CodingKey {

        case search_id = "search_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
    }

}
