//
//  Hdata.swift
//  BabSafar
//
//  Created by FCI on 20/12/22.
//

import Foundation



struct HData : Codable {
    let hotelSearchResult : [HotelSearchResult]?
    let source_result_count : Int?
    let filter_result_count : Int?

    enum CodingKeys: String, CodingKey {

        case hotelSearchResult = "HotelSearchResult"
        case source_result_count = "source_result_count"
        case filter_result_count = "filter_result_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hotelSearchResult = try values.decodeIfPresent([HotelSearchResult].self, forKey: .hotelSearchResult)
        source_result_count = try values.decodeIfPresent(Int.self, forKey: .source_result_count)
        filter_result_count = try values.decodeIfPresent(Int.self, forKey: .filter_result_count)
    }

}
