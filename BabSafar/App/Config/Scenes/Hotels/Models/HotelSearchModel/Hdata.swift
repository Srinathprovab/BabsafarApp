//
//  Hdata.swift
//  BabSafar
//
//  Created by FCI on 20/12/22.
//

import Foundation



struct HData : Codable {
    let hotelSearchResult : [HotelSearchResult]?

    enum CodingKeys: String, CodingKey {

        case hotelSearchResult = "HotelSearchResult"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hotelSearchResult = try values.decodeIfPresent([HotelSearchResult].self, forKey: .hotelSearchResult)
    }

}
