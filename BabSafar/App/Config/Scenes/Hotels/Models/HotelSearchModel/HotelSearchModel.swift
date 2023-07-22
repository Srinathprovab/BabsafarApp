//
//  HotelSearchModel.swift
//  BabSafar
//
//  Created by FCI on 16/12/22.
//

import Foundation


struct HotelSearchModel : Codable {
    let data : HData?
    let msg : [String]?
    let status : Int?
    let total_result_count : Int?
    let filter_result_count : Int?
    let offset : Int?
    let booking_source : String?
    let search_id : Int?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
        case total_result_count = "total_result_count"
        case filter_result_count = "filter_result_count"
        case offset = "offset"
        case booking_source = "booking_source"
        case search_id = "search_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(HData.self, forKey: .data)
        msg = try values.decodeIfPresent([String].self, forKey: .msg)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        total_result_count = try values.decodeIfPresent(Int.self, forKey: .total_result_count)
        filter_result_count = try values.decodeIfPresent(Int.self, forKey: .filter_result_count)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
    }

}
