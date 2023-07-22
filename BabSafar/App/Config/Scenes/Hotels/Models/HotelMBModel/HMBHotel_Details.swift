//
//  HMBHotel_Details.swift
//  BabSafar
//
//  Created by FCI on 27/03/23.
//

import Foundation

struct HMBHotel_Details : Codable {
    let hotel_code : Int?
    let name : String?
    let address : String?
    let image : String?
    let thumb_image : String?
    let star_rating : Int?
    let checkIn : String?
    let checkOut : String?
  //  let price : Double?

    enum CodingKeys: String, CodingKey {

        case hotel_code = "hotel_code"
        case name = "name"
        case address = "address"
        case image = "image"
        case thumb_image = "thumb_image"
        case star_rating = "star_rating"
        case checkIn = "checkIn"
        case checkOut = "checkOut"
    //    case price = "price"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hotel_code = try values.decodeIfPresent(Int.self, forKey: .hotel_code)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        thumb_image = try values.decodeIfPresent(String.self, forKey: .thumb_image)
        star_rating = try values.decodeIfPresent(Int.self, forKey: .star_rating)
        checkIn = try values.decodeIfPresent(String.self, forKey: .checkIn)
        checkOut = try values.decodeIfPresent(String.self, forKey: .checkOut)
    //    price = try values.decodeIfPresent(Double.self, forKey: .price)
    }

}
