

import Foundation
struct Pg_record : Codable {
    let rewards_amount : Int?
    let promocode_discount : String?
    let rewards_point : Int?
    let phone : String?
    let productinfo : String?
    let reward_earned : String?
    let booking_source : String?
    let booking_fare : String?
    let convenience_amount : String?
    let txnid : String?
    let firstname : String?
    let email : String?

    enum CodingKeys: String, CodingKey {

        case rewards_amount = "rewards_amount"
        case promocode_discount = "promocode_discount"
        case rewards_point = "rewards_point"
        case phone = "phone"
        case productinfo = "productinfo"
        case reward_earned = "reward_earned"
        case booking_source = "booking_source"
        case booking_fare = "booking_fare"
        case convenience_amount = "convenience_amount"
        case txnid = "txnid"
        case firstname = "firstname"
        case email = "email"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rewards_amount = try values.decodeIfPresent(Int.self, forKey: .rewards_amount)
        promocode_discount = try values.decodeIfPresent(String.self, forKey: .promocode_discount)
        rewards_point = try values.decodeIfPresent(Int.self, forKey: .rewards_point)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        productinfo = try values.decodeIfPresent(String.self, forKey: .productinfo)
        reward_earned = try values.decodeIfPresent(String.self, forKey: .reward_earned)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        booking_fare = try values.decodeIfPresent(String.self, forKey: .booking_fare)
        convenience_amount = try values.decodeIfPresent(String.self, forKey: .convenience_amount)
        txnid = try values.decodeIfPresent(String.self, forKey: .txnid)
        firstname = try values.decodeIfPresent(String.self, forKey: .firstname)
        email = try values.decodeIfPresent(String.self, forKey: .email)
    }

}
