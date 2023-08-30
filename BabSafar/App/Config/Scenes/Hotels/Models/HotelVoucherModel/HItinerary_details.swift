//
//  HItinerary_details.swift
//  BabSafar
//
//  Created by FCI on 29/08/23.
//

import Foundation

struct HItinerary_details : Codable {
    
    let origin : String?
    let app_reference : String?
    let location : String?
    let check_in : String?
    let check_out : String?
    let room_id : String?
    let room_type_name : String?
    let bed_type_code : String?
    let status : String?
    let smoking_preference : String?
    let total_fare : String?
    let admin_markup : String?
    let agent_markup : String?
    let currency : String?
    let attributes : String?
    let roomPrice : String?
    let tax : String?
    let extraGuestCharge : String?
    let childCharge : String?
    let otherCharges : String?
    let discount : String?
    let serviceTax : String?
    let agentCommission : String?
    let agentMarkUp : String?
    let tDS : String?
    let payment_status : String?
    let convenience_fee : String?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case app_reference = "app_reference"
        case location = "location"
        case check_in = "check_in"
        case check_out = "check_out"
        case room_id = "room_id"
        case room_type_name = "room_type_name"
        case bed_type_code = "bed_type_code"
        case status = "status"
        case smoking_preference = "smoking_preference"
        case total_fare = "total_fare"
        case admin_markup = "admin_markup"
        case agent_markup = "agent_markup"
        case currency = "currency"
        case attributes = "attributes"
        case roomPrice = "RoomPrice"
        case tax = "Tax"
        case extraGuestCharge = "ExtraGuestCharge"
        case childCharge = "ChildCharge"
        case otherCharges = "OtherCharges"
        case discount = "Discount"
        case serviceTax = "ServiceTax"
        case agentCommission = "AgentCommission"
        case agentMarkUp = "AgentMarkUp"
        case tDS = "TDS"
        case payment_status = "payment_status"
        case convenience_fee = "convenience_fee"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        check_in = try values.decodeIfPresent(String.self, forKey: .check_in)
        check_out = try values.decodeIfPresent(String.self, forKey: .check_out)
        room_id = try values.decodeIfPresent(String.self, forKey: .room_id)
        room_type_name = try values.decodeIfPresent(String.self, forKey: .room_type_name)
        bed_type_code = try values.decodeIfPresent(String.self, forKey: .bed_type_code)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        smoking_preference = try values.decodeIfPresent(String.self, forKey: .smoking_preference)
        total_fare = try values.decodeIfPresent(String.self, forKey: .total_fare)
        admin_markup = try values.decodeIfPresent(String.self, forKey: .admin_markup)
        agent_markup = try values.decodeIfPresent(String.self, forKey: .agent_markup)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        attributes = try values.decodeIfPresent(String.self, forKey: .attributes)
        roomPrice = try values.decodeIfPresent(String.self, forKey: .roomPrice)
        tax = try values.decodeIfPresent(String.self, forKey: .tax)
        extraGuestCharge = try values.decodeIfPresent(String.self, forKey: .extraGuestCharge)
        childCharge = try values.decodeIfPresent(String.self, forKey: .childCharge)
        otherCharges = try values.decodeIfPresent(String.self, forKey: .otherCharges)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        serviceTax = try values.decodeIfPresent(String.self, forKey: .serviceTax)
        agentCommission = try values.decodeIfPresent(String.self, forKey: .agentCommission)
        agentMarkUp = try values.decodeIfPresent(String.self, forKey: .agentMarkUp)
        tDS = try values.decodeIfPresent(String.self, forKey: .tDS)
        payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
        convenience_fee = try values.decodeIfPresent(String.self, forKey: .convenience_fee)
    }

}
