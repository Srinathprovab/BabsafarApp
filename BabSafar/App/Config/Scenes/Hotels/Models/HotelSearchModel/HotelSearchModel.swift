//
//  HotelSearchModel.swift
//  BabSafar
//
//  Created by FCI on 16/12/22.
//

import Foundation


struct HotelSearchModel : Codable {
    let booking_source : String?
    let data : HData?
    let source_result_count : Int?
    let status : Int?
    let filter_sumry : Filter_sumry?
    let filter_result_count : Int?
    let msg : String?
    let search_id : Int?
    let offset : Int?

    enum CodingKeys: String, CodingKey {

        case booking_source = "booking_source"
        case data = "data"
        case source_result_count = "source_result_count"
        case status = "status"
        case filter_sumry = "filter_sumry"
        case filter_result_count = "filter_result_count"
        case msg = "msg"
        case search_id = "search_id"
        case offset = "offset"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        data = try values.decodeIfPresent(HData.self, forKey: .data)
        source_result_count = try values.decodeIfPresent(Int.self, forKey: .source_result_count)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        filter_sumry = try values.decodeIfPresent(Filter_sumry.self, forKey: .filter_sumry)
        filter_result_count = try values.decodeIfPresent(Int.self, forKey: .filter_result_count)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
    }

}
