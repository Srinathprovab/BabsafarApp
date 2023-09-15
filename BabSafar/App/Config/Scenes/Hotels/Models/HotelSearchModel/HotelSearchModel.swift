//
//  HotelSearchModel.swift
//  BabSafar
//
//  Created by FCI on 16/12/22.
//

import Foundation


struct HotelSearchModel : Codable {
    
    let booking_source : String?
    let search_id : Int?
    let source_result_count : Int?
    let data : HData?
    let status : Int?
    let session_expiry_details : Session_expiry_details?
    let filter_result_count : Int?
    let msg : String?
    let filter_sumry : Filter_sumry?
    let offset : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case booking_source = "booking_source"
        case search_id = "search_id"
        case source_result_count = "source_result_count"
        case data = "data"
        case status = "status"
        case session_expiry_details = "session_expiry_details"
        case filter_result_count = "filter_result_count"
        case msg = "msg"
        case filter_sumry = "filter_sumry"
        case offset = "offset"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        source_result_count = try values.decodeIfPresent(Int.self, forKey: .source_result_count)
        data = try values.decodeIfPresent(HData.self, forKey: .data)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
        filter_result_count = try values.decodeIfPresent(Int.self, forKey: .filter_result_count)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        filter_sumry = try values.decodeIfPresent(Filter_sumry.self, forKey: .filter_sumry)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
    }
    
}
