//
//  IBooking_details.swift
//  BabSafar
//
//  Created by FCI on 05/09/23.
//

import Foundation

struct IBooking_details : Codable {
    let origin : String?
    let app_reference : String?
    let booking_source : String?
    let api_message : String?
    let domain_origin : String?
    let ins_attr : String?
    let name : String?
    let email : String?
    let phone_code : String?
    let contact_no : String?
    let postalcode : String?
    let city : String?
    let country : String?
    let address1 : String?
    let address2 : String?
    let payment_mode : String?
    let complete_booking_details_pax : String?
    let canceled_by : String?
    let policyCancelDateTime : String?
    let policyRefundDateTime : String?
    let status : String?
    let user_type : String?
    let created_at : String?
    let created_by_id : String?
    let trip_type_label : String?
    let pnr : String?
    let fare : Int?
    let admin_commission : Int?
    let agent_commission : Int?
    let admin_markup : Int?
    let agent_markup : Int?
    let agent_tds_on_commission : Int?
    let admin_buying_price : Int?
    let agent_buying_price : Int?
    let grand_total : Int?
    let currency : String?
    let cutomer_city : String?
    let cutomer_zipcode : String?
    let cutomer_address : String?
    let cutomer_country : String?
    let lead_pax_name : String?
    let lead_pax_phone_number : String?
    let lead_pax_email : String?
    let domain_name : String?
    let domain_ip : String?
    let domain_key : String?
    let theme_id : String?
    let domain_logo : String?
    let booked_date : String?
    let booking_itinerary_details : [IBooking_itinerary_details]?
    let booking_transaction_details : [IBooking_transaction_details]?
    let customer_details : [ICustomer_details]?
    let cancellation_details : String?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case app_reference = "app_reference"
        case booking_source = "booking_source"
        case api_message = "api_message"
        case domain_origin = "domain_origin"
        case ins_attr = "ins_attr"
        case name = "name"
        case email = "email"
        case phone_code = "phone_code"
        case contact_no = "contact_no"
        case postalcode = "postalcode"
        case city = "city"
        case country = "country"
        case address1 = "address1"
        case address2 = "address2"
        case payment_mode = "payment_mode"
        case complete_booking_details_pax = "complete_booking_details_pax"
        case canceled_by = "canceled_by"
        case policyCancelDateTime = "PolicyCancelDateTime"
        case policyRefundDateTime = "PolicyRefundDateTime"
        case status = "status"
        case user_type = "user_type"
        case created_at = "created_at"
        case created_by_id = "created_by_id"
        case trip_type_label = "trip_type_label"
        case pnr = "pnr"
        case fare = "fare"
        case admin_commission = "admin_commission"
        case agent_commission = "agent_commission"
        case admin_markup = "admin_markup"
        case agent_markup = "agent_markup"
        case agent_tds_on_commission = "agent_tds_on_commission"
        case admin_buying_price = "admin_buying_price"
        case agent_buying_price = "agent_buying_price"
        case grand_total = "grand_total"
        case currency = "currency"
        case cutomer_city = "cutomer_city"
        case cutomer_zipcode = "cutomer_zipcode"
        case cutomer_address = "cutomer_address"
        case cutomer_country = "cutomer_country"
        case lead_pax_name = "lead_pax_name"
        case lead_pax_phone_number = "lead_pax_phone_number"
        case lead_pax_email = "lead_pax_email"
        case domain_name = "domain_name"
        case domain_ip = "domain_ip"
        case domain_key = "domain_key"
        case theme_id = "theme_id"
        case domain_logo = "domain_logo"
        case booked_date = "booked_date"
        case booking_itinerary_details = "booking_itinerary_details"
        case booking_transaction_details = "booking_transaction_details"
        case customer_details = "customer_details"
        case cancellation_details = "cancellation_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        api_message = try values.decodeIfPresent(String.self, forKey: .api_message)
        domain_origin = try values.decodeIfPresent(String.self, forKey: .domain_origin)
        ins_attr = try values.decodeIfPresent(String.self, forKey: .ins_attr)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phone_code = try values.decodeIfPresent(String.self, forKey: .phone_code)
        contact_no = try values.decodeIfPresent(String.self, forKey: .contact_no)
        postalcode = try values.decodeIfPresent(String.self, forKey: .postalcode)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        address1 = try values.decodeIfPresent(String.self, forKey: .address1)
        address2 = try values.decodeIfPresent(String.self, forKey: .address2)
        payment_mode = try values.decodeIfPresent(String.self, forKey: .payment_mode)
        complete_booking_details_pax = try values.decodeIfPresent(String.self, forKey: .complete_booking_details_pax)
        canceled_by = try values.decodeIfPresent(String.self, forKey: .canceled_by)
        policyCancelDateTime = try values.decodeIfPresent(String.self, forKey: .policyCancelDateTime)
        policyRefundDateTime = try values.decodeIfPresent(String.self, forKey: .policyRefundDateTime)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        user_type = try values.decodeIfPresent(String.self, forKey: .user_type)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
        trip_type_label = try values.decodeIfPresent(String.self, forKey: .trip_type_label)
        pnr = try values.decodeIfPresent(String.self, forKey: .pnr)
        fare = try values.decodeIfPresent(Int.self, forKey: .fare)
        admin_commission = try values.decodeIfPresent(Int.self, forKey: .admin_commission)
        agent_commission = try values.decodeIfPresent(Int.self, forKey: .agent_commission)
        admin_markup = try values.decodeIfPresent(Int.self, forKey: .admin_markup)
        agent_markup = try values.decodeIfPresent(Int.self, forKey: .agent_markup)
        agent_tds_on_commission = try values.decodeIfPresent(Int.self, forKey: .agent_tds_on_commission)
        admin_buying_price = try values.decodeIfPresent(Int.self, forKey: .admin_buying_price)
        agent_buying_price = try values.decodeIfPresent(Int.self, forKey: .agent_buying_price)
        grand_total = try values.decodeIfPresent(Int.self, forKey: .grand_total)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        cutomer_city = try values.decodeIfPresent(String.self, forKey: .cutomer_city)
        cutomer_zipcode = try values.decodeIfPresent(String.self, forKey: .cutomer_zipcode)
        cutomer_address = try values.decodeIfPresent(String.self, forKey: .cutomer_address)
        cutomer_country = try values.decodeIfPresent(String.self, forKey: .cutomer_country)
        lead_pax_name = try values.decodeIfPresent(String.self, forKey: .lead_pax_name)
        lead_pax_phone_number = try values.decodeIfPresent(String.self, forKey: .lead_pax_phone_number)
        lead_pax_email = try values.decodeIfPresent(String.self, forKey: .lead_pax_email)
        domain_name = try values.decodeIfPresent(String.self, forKey: .domain_name)
        domain_ip = try values.decodeIfPresent(String.self, forKey: .domain_ip)
        domain_key = try values.decodeIfPresent(String.self, forKey: .domain_key)
        theme_id = try values.decodeIfPresent(String.self, forKey: .theme_id)
        domain_logo = try values.decodeIfPresent(String.self, forKey: .domain_logo)
        booked_date = try values.decodeIfPresent(String.self, forKey: .booked_date)
        booking_itinerary_details = try values.decodeIfPresent([IBooking_itinerary_details].self, forKey: .booking_itinerary_details)
        booking_transaction_details = try values.decodeIfPresent([IBooking_transaction_details].self, forKey: .booking_transaction_details)
        customer_details = try values.decodeIfPresent([ICustomer_details].self, forKey: .customer_details)
        cancellation_details = try values.decodeIfPresent(String.self, forKey: .cancellation_details)
    }

}
