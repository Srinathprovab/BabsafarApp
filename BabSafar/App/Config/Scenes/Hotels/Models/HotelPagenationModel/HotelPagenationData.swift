//
//  HotelPagenationData.swift
//  BabSafar
//
//  Created by FCI on 11/09/23.
//

import Foundation

struct HotelPagenationData : Codable {
    let hotelSearchResult : [PHotelSearchResult]?

    enum CodingKeys: String, CodingKey {

        case hotelSearchResult = "HotelSearchResult"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hotelSearchResult = try values.decodeIfPresent([PHotelSearchResult].self, forKey: .hotelSearchResult)
    }

}
