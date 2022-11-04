//
//  MCTotal_breakup.swift
//  BabSafar
//
//  Created by FCI on 14/10/22.
//

import Foundation

struct MCTotal_breakup : Codable {
    
    let api_total_fare : Int?
    let api_total_tax : String?
    let api_total_fare_publish : Int?
    let api_total_tax_publish : Int?

    enum CodingKeys: String, CodingKey {

        case api_total_fare = "api_total_fare"
        case api_total_tax = "api_total_tax"
        case api_total_fare_publish = "api_total_fare_publish"
        case api_total_tax_publish = "api_total_tax_publish"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        api_total_fare = try values.decodeIfPresent(Int.self, forKey: .api_total_fare)
        api_total_tax = try values.decodeIfPresent(String.self, forKey: .api_total_tax)
        api_total_fare_publish = try values.decodeIfPresent(Int.self, forKey: .api_total_fare_publish)
        api_total_tax_publish = try values.decodeIfPresent(Int.self, forKey: .api_total_tax_publish)
    }

}
