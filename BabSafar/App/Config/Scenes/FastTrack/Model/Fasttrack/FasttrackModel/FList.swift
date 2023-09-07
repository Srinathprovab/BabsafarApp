//
//  FList.swift
//  BabSafar
//
//  Created by FCI on 24/08/23.
//

import Foundation

struct FList : Codable {
    let from : [From]?
    let to : [To]?

    enum CodingKeys: String, CodingKey {

        case from = "from"
        case to = "to"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        from = try values.decodeIfPresent([From].self, forKey: .from)
        to = try values.decodeIfPresent([To].self, forKey: .to)
    }

}
