//
//  EBookingModel.swift
//  BabSafar
//
//  Created by FCI on 05/09/23.
//

import Foundation


struct EBookingModel : Codable {
    let search_id : String?
    let booking_source : String?
    let fasttrack_search_params : EFasttrack_search_params?
    let active_booking_source : String?
    let currency : String?
    let msg : String?
    let status : Bool?
    let product_details : EProduct_details?

    enum CodingKeys: String, CodingKey {

        case search_id = "search_id"
        case booking_source = "booking_source"
        case fasttrack_search_params = "fasttrack_search_params"
        case active_booking_source = "active_booking_source"
        case currency = "currency"
        case msg = "msg"
        case status = "status"
        case product_details = "product_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        fasttrack_search_params = try values.decodeIfPresent(EFasttrack_search_params.self, forKey: .fasttrack_search_params)
        active_booking_source = try values.decodeIfPresent(String.self, forKey: .active_booking_source)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        product_details = try values.decodeIfPresent(EProduct_details.self, forKey: .product_details)
    }

}
