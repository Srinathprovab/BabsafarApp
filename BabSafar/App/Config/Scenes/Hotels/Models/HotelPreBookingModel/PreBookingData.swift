//
//  PreBookingData.swift
//  BabSafar
//
//  Created by FCI on 14/04/23.
//

import Foundation

struct PreBookingData : Codable {
    let post_data : Postdata?

    enum CodingKeys: String, CodingKey {

        case post_data = "post_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        post_data = try values.decodeIfPresent(Postdata.self, forKey: .post_data)
    }

}
