//
//  IBooking_transaction_details.swift
//  BabSafar
//
//  Created by FCI on 05/09/23.
//

import Foundation

struct IBooking_transaction_details : Codable {
    let origin : String?
    let app_reference : String?
    let booking_source : String?
    let itineraryID : String?
    let policy_no : String?
    let policyPurchasedDateTime : String?
    let status : String?
    let payment_status : String?
    let payment_mode : String?
    let payment_invoice_id : String?
    let payment_invoice_ref : String?
    let lastupdated_manual_booking : String?
    let total_price : String?
    let base_fare : String?
    let tax : String?
    let currency : String?
    let total_pax : String?
    let language : String?
    let exchange_rate : String?
    let trip_type : String?
    let search_data : String?
    let booking_ip_address : String?
    let email_sent : String?
    let created_at : String?
    let booking_customer_details : [IBooking_customer_details]?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case app_reference = "app_reference"
        case booking_source = "booking_source"
        case itineraryID = "itineraryID"
        case policy_no = "policy_no"
        case policyPurchasedDateTime = "policyPurchasedDateTime"
        case status = "status"
        case payment_status = "payment_status"
        case payment_mode = "payment_mode"
        case payment_invoice_id = "payment_invoice_id"
        case payment_invoice_ref = "payment_invoice_ref"
        case lastupdated_manual_booking = "lastupdated_manual_booking"
        case total_price = "total_price"
        case base_fare = "base_fare"
        case tax = "tax"
        case currency = "currency"
        case total_pax = "total_pax"
        case language = "language"
        case exchange_rate = "exchange_rate"
        case trip_type = "trip_type"
        case search_data = "search_data"
        case booking_ip_address = "booking_ip_address"
        case email_sent = "email_sent"
        case created_at = "created_at"
        case booking_customer_details = "booking_customer_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        itineraryID = try values.decodeIfPresent(String.self, forKey: .itineraryID)
        policy_no = try values.decodeIfPresent(String.self, forKey: .policy_no)
        policyPurchasedDateTime = try values.decodeIfPresent(String.self, forKey: .policyPurchasedDateTime)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
        payment_mode = try values.decodeIfPresent(String.self, forKey: .payment_mode)
        payment_invoice_id = try values.decodeIfPresent(String.self, forKey: .payment_invoice_id)
        payment_invoice_ref = try values.decodeIfPresent(String.self, forKey: .payment_invoice_ref)
        lastupdated_manual_booking = try values.decodeIfPresent(String.self, forKey: .lastupdated_manual_booking)
        total_price = try values.decodeIfPresent(String.self, forKey: .total_price)
        base_fare = try values.decodeIfPresent(String.self, forKey: .base_fare)
        tax = try values.decodeIfPresent(String.self, forKey: .tax)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        total_pax = try values.decodeIfPresent(String.self, forKey: .total_pax)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        exchange_rate = try values.decodeIfPresent(String.self, forKey: .exchange_rate)
        trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
        search_data = try values.decodeIfPresent(String.self, forKey: .search_data)
        booking_ip_address = try values.decodeIfPresent(String.self, forKey: .booking_ip_address)
        email_sent = try values.decodeIfPresent(String.self, forKey: .email_sent)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        booking_customer_details = try values.decodeIfPresent([IBooking_customer_details].self, forKey: .booking_customer_details)
    }

}
