//
//  HotelSelectedDetailsModel.swift
//  BabSafar
//
//  Created by FCI on 09/02/23.
//


import Foundation
struct HotelSelectedDetailsModel : Codable {
    let params : Params?
    let hotel_search_params : Hotel_search_params?
    let active_booking_source : String?
    let status : Bool?
    let session_expiry_details : Session_expiry_details?
    let currency_obj : Currency_obj?
    let msg : String?
    //  let advertisement : [String]?
    let hotel_details : Hotel_details?
    
    enum CodingKeys: String, CodingKey {
        
        case params = "params"
        case hotel_search_params = "hotel_search_params"
        case active_booking_source = "active_booking_source"
        case status = "status"
        case session_expiry_details = "session_expiry_details"
        case currency_obj = "currency_obj"
        case msg = "msg"
        //     case advertisement = "advertisement"
        case hotel_details = "hotel_details"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        params = try values.decodeIfPresent(Params.self, forKey: .params)
        hotel_search_params = try values.decodeIfPresent(Hotel_search_params.self, forKey: .hotel_search_params)
        active_booking_source = try values.decodeIfPresent(String.self, forKey: .active_booking_source)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
        currency_obj = try values.decodeIfPresent(Currency_obj.self, forKey: .currency_obj)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        //     advertisement = try values.decodeIfPresent([String].self, forKey: .advertisement)
        hotel_details = try values.decodeIfPresent(Hotel_details.self, forKey: .hotel_details)
    }
    
}
