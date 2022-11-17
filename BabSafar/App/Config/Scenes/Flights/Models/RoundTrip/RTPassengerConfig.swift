//
//  RTPassengerConfig.swift
//  BabSafar
//
//  Created by FCI on 16/11/22.
//

import Foundation

struct RTPassengerConfig : Codable {
    let adult : Int?
    let child : Int?
    let infant : Int?
    let totalPassenger : Int?

    enum CodingKeys: String, CodingKey {

        case adult = "Adult"
        case child = "Child"
        case infant = "Infant"
        case totalPassenger = "TotalPassenger"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decodeIfPresent(Int.self, forKey: .adult)
        child = try values.decodeIfPresent(Int.self, forKey: .child)
        infant = try values.decodeIfPresent(Int.self, forKey: .infant)
        totalPassenger = try values.decodeIfPresent(Int.self, forKey: .totalPassenger)
    }

}
