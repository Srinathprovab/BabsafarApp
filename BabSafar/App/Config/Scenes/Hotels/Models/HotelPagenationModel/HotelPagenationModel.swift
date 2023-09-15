//
//  HotelPagenationModel.swift
//  BabSafar
//
//  Created by FCI on 11/09/23.
//

import Foundation


struct HotelPagenationModel : Codable {
    let data : HotelPagenationData?
    let msg : String?
    let status : Int?
    let source_result_count : Int?
    let filter_result_count : Int?
    let offset : Int?
    let booking_source : String?
    let search_id : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
        case source_result_count = "source_result_count"
        case filter_result_count = "filter_result_count"
        case offset = "offset"
        case booking_source = "booking_source"
        case search_id = "search_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(HotelPagenationData.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        source_result_count = try values.decodeIfPresent(Int.self, forKey: .source_result_count)
        filter_result_count = try values.decodeIfPresent(Int.self, forKey: .filter_result_count)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
    }

}
