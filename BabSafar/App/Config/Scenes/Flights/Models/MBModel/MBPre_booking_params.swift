//
//  MBPre_booking_params.swift
//  BabSafar
//
//  Created by FCI on 06/12/22.
//

import Foundation

struct MBPre_booking_params : Codable {
    let search_access_key : String?
    let search_id : String?
    let transaction_id : String?
   // let form_params : Form_params?
    let traceId : String?
    let booking_source : String?
    let user_id : String?
    let token : String?
    let token_key : String?
    let access_key : String?
    let priceDetails : MBPriceDetails?

    enum CodingKeys: String, CodingKey {

        case search_access_key = "search_access_key"
        case search_id = "search_id"
        case transaction_id = "transaction_id"
    //    case form_params = "form_params"
        case traceId = "traceId"
        case booking_source = "booking_source"
        case user_id = "user_id"
        case token = "token"
        case token_key = "token_key"
        case access_key = "access_key"
        case priceDetails = "priceDetails"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        search_access_key = try values.decodeIfPresent(String.self, forKey: .search_access_key)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        transaction_id = try values.decodeIfPresent(String.self, forKey: .transaction_id)
    //    form_params = try values.decodeIfPresent(Form_params.self, forKey: .form_params)
        traceId = try values.decodeIfPresent(String.self, forKey: .traceId)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        token_key = try values.decodeIfPresent(String.self, forKey: .token_key)
        access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
        priceDetails = try values.decodeIfPresent(MBPriceDetails.self, forKey: .priceDetails)
    }

}
