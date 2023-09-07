//
//  QData.swift
//  BabSafar
//
//  Created by FCI on 07/09/23.
//

import Foundation

struct QData : Codable {
    let to : QTo?
    let from : QFrom?

    enum CodingKeys: String, CodingKey {

        case to = "to"
        case from = "from"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        to = try values.decodeIfPresent(QTo.self, forKey: .to)
        from = try values.decodeIfPresent(QFrom.self, forKey: .from)
    }

}
