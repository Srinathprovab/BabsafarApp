//
//  UPComingFlightsModel.swift
//  BabSafar
//
//  Created by FCI on 14/02/23.
//

import Foundation

struct UPComingFlightsModel : Codable {
    let res_data : [Res_data]?
    let flight_data : [Flight_data]?
    let status : Bool?
    
    enum CodingKeys: String, CodingKey {

        case res_data = "res_data"
        case flight_data = "flight_data"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        res_data = try values.decodeIfPresent([Res_data].self, forKey: .res_data)
        flight_data = try values.decodeIfPresent([Flight_data].self, forKey: .flight_data)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }

}
