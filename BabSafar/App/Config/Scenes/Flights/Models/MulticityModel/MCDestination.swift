//
//  MCDestination.swift
//  BabSafar
//
//  Created by FCI on 14/10/22.
//

import Foundation

struct MCDestination : Codable {
    
    let loc : String?
    let city : String?
    let datetime : String?
    let date : String?
    let time : String?
//    let fdtv : Int?

    enum CodingKeys: String, CodingKey {

        case loc = "loc"
        case city = "city"
        case datetime = "datetime"
        case date = "date"
        case time = "time"
 //       case fdtv = "fdtv"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        loc = try values.decodeIfPresent(String.self, forKey: .loc)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        datetime = try values.decodeIfPresent(String.self, forKey: .datetime)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        time = try values.decodeIfPresent(String.self, forKey: .time)
//        fdtv = try values.decodeIfPresent(Int.self, forKey: .fdtv)
    }

}
