//
//  CurrencyListData.swift
//  BestFares365App
//
//  Created by FCI on 16/02/23.
//

import Foundation

struct CurrencyListData : Codable {
    let origin : String?
    let symbol : String?
    let value : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case symbol = "symbol"
        case value = "value"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
