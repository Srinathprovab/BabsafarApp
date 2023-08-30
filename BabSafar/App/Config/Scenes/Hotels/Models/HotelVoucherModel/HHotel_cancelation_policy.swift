//
//  HHotel_cancelation_policy.swift
//  BabSafar
//
//  Created by FCI on 29/08/23.
//

import Foundation

struct HHotel_cancelation_policy : Codable {
    let origin : String?
    let app_reference : String?
    let booking_reference : String?
    let amount : String?
    let date : String?
    let currency : String?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case app_reference = "app_reference"
        case booking_reference = "booking_reference"
        case amount = "amount"
        case date = "date"
        case currency = "currency"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        booking_reference = try values.decodeIfPresent(String.self, forKey: .booking_reference)
        amount = try values.decodeIfPresent(String.self, forKey: .amount)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
    }

}
