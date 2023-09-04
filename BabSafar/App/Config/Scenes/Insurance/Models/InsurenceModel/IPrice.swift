//
//  IPrice.swift
//  BabSafar
//
//  Created by FCI on 28/08/23.
//

import Foundation

struct IPrice : Codable {
    //    let min_age : String?
    //    let max_age : String?
    //  let total_fare_with_markup : Double?
    let total_fare_api : String?
    //    let api_fares : Api_fares?
    //    let price_breakup : IPrice_breakup?
    
    enum CodingKeys: String, CodingKey {
        
        //        case min_age = "min_age"
        //        case max_age = "max_age"
        //        case total_fare_with_markup = "total_fare_with_markup"
        case total_fare_api = "total_fare_api"
        //        case api_fares = "api_fares"
        //        case price_breakup = "price_breakup"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //        min_age = try values.decodeIfPresent(String.self, forKey: .min_age)
        //        max_age = try values.decodeIfPresent(String.self, forKey: .max_age)
        //        total_fare_with_markup = try values.decodeIfPresent(Double.self, forKey: .total_fare_with_markup)
        total_fare_api = try values.decodeIfPresent(String.self, forKey: .total_fare_api)
        //        api_fares = try values.decodeIfPresent(Api_fares.self, forKey: .api_fares)
        //        price_breakup = try values.decodeIfPresent(IPrice_breakup.self, forKey: .price_breakup)
    }
    
}
