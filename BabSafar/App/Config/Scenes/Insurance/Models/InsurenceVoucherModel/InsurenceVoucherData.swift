//
//  InsurenceVoucherData.swift
//  BabSafar
//
//  Created by FCI on 05/09/23.
//

import Foundation

struct InsurenceVoucherData : Codable {
    let booking_details : [IBooking_details]?

    enum CodingKeys: String, CodingKey {

        case booking_details = "booking_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_details = try values.decodeIfPresent([IBooking_details].self, forKey: .booking_details)
    }

}
