//
//  HBooking_details.swift
//  BabSafar
//
//  Created by FCI on 29/08/23.
//

import Foundation

struct HBooking_details : Codable {
    
    let origin : String?
    let domain_origin : String?
    let status : String?
    let app_reference : String?
    let booking_source : String?
    let booking_id : String?
    let booking_reference : String?
    let confirmation_reference : String?
    let hotel_name : String?
    let star_rating : String?
    let hotel_code : String?
    let phone_number : String?
    let alternate_number : String?
    let email : String?
    let hotel_check_in : String?
    let hotel_check_out : String?
    let payment_mode : String?
    let convinence_value : String?
    let convinence_value_type : String?
    let convinence_per_pax : String?
    let convinence_amount : String?
    let promo_code : String?
    let deal_code : String?
    let deal_code_amount : String?
    let use_limit : String?
    let cashback_status : String?
    let discount : String?
    let currency : String?
    let currency_conversion_rate : String?
    let search_id : String?
    let search_params : String?
    let booked_by_id : String?
    let parent_id : String?
    let created_by_id : String?
    let created_datetime : String?
    let reward_amount : String?
    let reward_points : String?
    let reward_earned : String?
    let guest_remark : String?
    let user_specification : String?
    let rateComments : String?
    let hotel_image : String?
    let hotel_location : String?
    let hotel_address : String?
    let total_nights : Int?
    let total_rooms : Int?
    let adult_count : Int?
    let child_count : Int?
    let fare : Double?
    let admin_markup : Int?
    let agent_markup : Int?
    let admin_buying_price : Double?
    let agent_buying_price : Int?
    let grand_total : Double?
    let voucher_date : String?
    let cutomer_city : String?
    let cutomer_zipcode : String?
    let cutomer_address : String?
    let cutomer_country : String?
    let lead_pax_name : String?
    let admin_lead_pax_name : String?
    let lead_pax_phone_number : String?
    let lead_pax_email : String?
    let domain_name : String?
    let domain_ip : String?
    let domain_key : String?
    let theme_id : String?
    let domain_logo : String?
    let itinerary_details : [HItinerary_details]?
    let customer_details : [HCustomer_details]?
    let cancellation_details : String?
    let hotel_cancelation_policy : [HHotel_cancelation_policy]?
    let image : String?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case domain_origin = "domain_origin"
        case status = "status"
        case app_reference = "app_reference"
        case booking_source = "booking_source"
        case booking_id = "booking_id"
        case booking_reference = "booking_reference"
        case confirmation_reference = "confirmation_reference"
        case hotel_name = "hotel_name"
        case star_rating = "star_rating"
        case hotel_code = "hotel_code"
        case phone_number = "phone_number"
        case alternate_number = "alternate_number"
        case email = "email"
        case hotel_check_in = "hotel_check_in"
        case hotel_check_out = "hotel_check_out"
        case payment_mode = "payment_mode"
        case convinence_value = "convinence_value"
        case convinence_value_type = "convinence_value_type"
        case convinence_per_pax = "convinence_per_pax"
        case convinence_amount = "convinence_amount"
        case promo_code = "promo_code"
        case deal_code = "deal_code"
        case deal_code_amount = "deal_code_amount"
        case use_limit = "use_limit"
        case cashback_status = "cashback_status"
        case discount = "discount"
        case currency = "currency"
        case currency_conversion_rate = "currency_conversion_rate"
        case search_id = "search_id"
        case search_params = "search_params"
        case booked_by_id = "booked_by_id"
        case parent_id = "parent_id"
        case created_by_id = "created_by_id"
        case created_datetime = "created_datetime"
        case reward_amount = "reward_amount"
        case reward_points = "reward_points"
        case reward_earned = "reward_earned"
        case guest_remark = "guest_remark"
        case user_specification = "user_specification"
        case rateComments = "rateComments"
        case hotel_image = "hotel_image"
        case hotel_location = "hotel_location"
        case hotel_address = "hotel_address"
        case total_nights = "total_nights"
        case total_rooms = "total_rooms"
        case adult_count = "adult_count"
        case child_count = "child_count"
        case fare = "fare"
        case admin_markup = "admin_markup"
        case agent_markup = "agent_markup"
        case admin_buying_price = "admin_buying_price"
        case agent_buying_price = "agent_buying_price"
        case grand_total = "grand_total"
        case voucher_date = "voucher_date"
        case cutomer_city = "cutomer_city"
        case cutomer_zipcode = "cutomer_zipcode"
        case cutomer_address = "cutomer_address"
        case cutomer_country = "cutomer_country"
        case lead_pax_name = "lead_pax_name"
        case admin_lead_pax_name = "admin_lead_pax_name"
        case lead_pax_phone_number = "lead_pax_phone_number"
        case lead_pax_email = "lead_pax_email"
        case domain_name = "domain_name"
        case domain_ip = "domain_ip"
        case domain_key = "domain_key"
        case theme_id = "theme_id"
        case domain_logo = "domain_logo"
        case itinerary_details = "itinerary_details"
        case customer_details = "customer_details"
        case cancellation_details = "cancellation_details"
        case hotel_cancelation_policy = "hotel_cancelation_policy"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        domain_origin = try values.decodeIfPresent(String.self, forKey: .domain_origin)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        booking_id = try values.decodeIfPresent(String.self, forKey: .booking_id)
        booking_reference = try values.decodeIfPresent(String.self, forKey: .booking_reference)
        confirmation_reference = try values.decodeIfPresent(String.self, forKey: .confirmation_reference)
        hotel_name = try values.decodeIfPresent(String.self, forKey: .hotel_name)
        star_rating = try values.decodeIfPresent(String.self, forKey: .star_rating)
        hotel_code = try values.decodeIfPresent(String.self, forKey: .hotel_code)
        phone_number = try values.decodeIfPresent(String.self, forKey: .phone_number)
        alternate_number = try values.decodeIfPresent(String.self, forKey: .alternate_number)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        hotel_check_in = try values.decodeIfPresent(String.self, forKey: .hotel_check_in)
        hotel_check_out = try values.decodeIfPresent(String.self, forKey: .hotel_check_out)
        payment_mode = try values.decodeIfPresent(String.self, forKey: .payment_mode)
        convinence_value = try values.decodeIfPresent(String.self, forKey: .convinence_value)
        convinence_value_type = try values.decodeIfPresent(String.self, forKey: .convinence_value_type)
        convinence_per_pax = try values.decodeIfPresent(String.self, forKey: .convinence_per_pax)
        convinence_amount = try values.decodeIfPresent(String.self, forKey: .convinence_amount)
        promo_code = try values.decodeIfPresent(String.self, forKey: .promo_code)
        deal_code = try values.decodeIfPresent(String.self, forKey: .deal_code)
        deal_code_amount = try values.decodeIfPresent(String.self, forKey: .deal_code_amount)
        use_limit = try values.decodeIfPresent(String.self, forKey: .use_limit)
        cashback_status = try values.decodeIfPresent(String.self, forKey: .cashback_status)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        currency_conversion_rate = try values.decodeIfPresent(String.self, forKey: .currency_conversion_rate)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        search_params = try values.decodeIfPresent(String.self, forKey: .search_params)
        booked_by_id = try values.decodeIfPresent(String.self, forKey: .booked_by_id)
        parent_id = try values.decodeIfPresent(String.self, forKey: .parent_id)
        created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
        created_datetime = try values.decodeIfPresent(String.self, forKey: .created_datetime)
        reward_amount = try values.decodeIfPresent(String.self, forKey: .reward_amount)
        reward_points = try values.decodeIfPresent(String.self, forKey: .reward_points)
        reward_earned = try values.decodeIfPresent(String.self, forKey: .reward_earned)
        guest_remark = try values.decodeIfPresent(String.self, forKey: .guest_remark)
        user_specification = try values.decodeIfPresent(String.self, forKey: .user_specification)
        rateComments = try values.decodeIfPresent(String.self, forKey: .rateComments)
        hotel_image = try values.decodeIfPresent(String.self, forKey: .hotel_image)
        hotel_location = try values.decodeIfPresent(String.self, forKey: .hotel_location)
        hotel_address = try values.decodeIfPresent(String.self, forKey: .hotel_address)
        total_nights = try values.decodeIfPresent(Int.self, forKey: .total_nights)
        total_rooms = try values.decodeIfPresent(Int.self, forKey: .total_rooms)
        adult_count = try values.decodeIfPresent(Int.self, forKey: .adult_count)
        child_count = try values.decodeIfPresent(Int.self, forKey: .child_count)
        fare = try values.decodeIfPresent(Double.self, forKey: .fare)
        admin_markup = try values.decodeIfPresent(Int.self, forKey: .admin_markup)
        agent_markup = try values.decodeIfPresent(Int.self, forKey: .agent_markup)
        admin_buying_price = try values.decodeIfPresent(Double.self, forKey: .admin_buying_price)
        agent_buying_price = try values.decodeIfPresent(Int.self, forKey: .agent_buying_price)
        grand_total = try values.decodeIfPresent(Double.self, forKey: .grand_total)
        voucher_date = try values.decodeIfPresent(String.self, forKey: .voucher_date)
        cutomer_city = try values.decodeIfPresent(String.self, forKey: .cutomer_city)
        cutomer_zipcode = try values.decodeIfPresent(String.self, forKey: .cutomer_zipcode)
        cutomer_address = try values.decodeIfPresent(String.self, forKey: .cutomer_address)
        cutomer_country = try values.decodeIfPresent(String.self, forKey: .cutomer_country)
        lead_pax_name = try values.decodeIfPresent(String.self, forKey: .lead_pax_name)
        admin_lead_pax_name = try values.decodeIfPresent(String.self, forKey: .admin_lead_pax_name)
        lead_pax_phone_number = try values.decodeIfPresent(String.self, forKey: .lead_pax_phone_number)
        lead_pax_email = try values.decodeIfPresent(String.self, forKey: .lead_pax_email)
        domain_name = try values.decodeIfPresent(String.self, forKey: .domain_name)
        domain_ip = try values.decodeIfPresent(String.self, forKey: .domain_ip)
        domain_key = try values.decodeIfPresent(String.self, forKey: .domain_key)
        theme_id = try values.decodeIfPresent(String.self, forKey: .theme_id)
        domain_logo = try values.decodeIfPresent(String.self, forKey: .domain_logo)
        itinerary_details = try values.decodeIfPresent([HItinerary_details].self, forKey: .itinerary_details)
        customer_details = try values.decodeIfPresent([HCustomer_details].self, forKey: .customer_details)
        cancellation_details = try values.decodeIfPresent(String.self, forKey: .cancellation_details)
        hotel_cancelation_policy = try values.decodeIfPresent([HHotel_cancelation_policy].self, forKey: .hotel_cancelation_policy)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }

}
