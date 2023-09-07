//
//  QBookingModel.swift
//  BabSafar
//
//  Created by FCI on 07/09/23.
//

import Foundation



struct QBookingModel : Codable {
    let booking_source : String?
    let active_booking_source : String?
    let product_details : QProduct_details?
    let status : Bool?
    let fasttrack_search_params : QFasttrack_search_params?
    let search_id : String?
    let currency : String?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case booking_source = "booking_source"
        case active_booking_source = "active_booking_source"
        case product_details = "product_details"
        case status = "status"
        case fasttrack_search_params = "fasttrack_search_params"
        case search_id = "search_id"
        case currency = "currency"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        active_booking_source = try values.decodeIfPresent(String.self, forKey: .active_booking_source)
        product_details = try values.decodeIfPresent(QProduct_details.self, forKey: .product_details)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        fasttrack_search_params = try values.decodeIfPresent(QFasttrack_search_params.self, forKey: .fasttrack_search_params)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}
