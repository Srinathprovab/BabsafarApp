

import Foundation
struct Booking_transaction_details : Codable {
    let origin : String?
    let app_reference : String?
    let tF_booking_reference : String?
    let supplier_reference : String?
    let source : String?
    let airline : String?
    let pnr : String?
    let airline_pnr : String?
    let suppliercode : String?
    let providerlocatorcode : String?
    let invoice_number : String?
    let provab_invoice_number : String?
    let status : String?
    let sales_chanel : String?
    let wego_click_id : String?
    let status_description : String?
    let book_id : String?
    let booking_source : String?
    let ref_id : String?
    let is_dom : String?
    let total_fare : String?
    let admin_commission : String?
    let dist_commission : String?
    let agent_commission : String?
    let admin_tds_on_commission : String?
    let dist_tds_on_commission : String?
    let agent_tds_on_commission : String?
    let admin_markup : String?
    let dist_markup : String?
    let agent_markup : String?
    let handling_charge : String?
    let service_tax : String?
    let convinence_amount : String?
    let currency : String?
    let fare_attributes : String?
    let flight_fare_attributes : String?
    let getbooking_StatusCode : String?
    let getbooking_Description : String?
    let getbooking_Category : String?
    let attributes : String?
    let api_attributes : String?
    let sequence_number : String?
    let api_total_fare : String?
    let payment_status : String?
    let payment_mode : String?
    let payment_invoice_id : String?
    let payment_invoice_ref : String?
    let manual_payment_status : String?
    let manual_payment_mode : String?
    let manual_payment_invoice_id : String?
    let manual_payment_invoice_ref : String?
    let booking_ip_address : String?
    let search_data : String?
    let email_sent : String?
    let customer_payment_details : String?
    let amount_adjustment_type : String?
    let amount_adjustment_value : String?
    let cabin_class : String?
    let total_pax : String?
    let pos : String?
    let pcc : String?
    let language : String?
    let exchange_rate : String?
    let action_by_id : String?
    let tre : String?
    let last_manual_booking_date_time : String?
    let count_manual_booking : String?
    let all_last_manual_booking_date_time : String?
    let manual_booking_reference_num : String?
    let latestTicketingTime : String?
    let remarks : String?
    let modified : String?
    let seat_data_req : String?
    let seat_data : String?
    let seat_cost : String?
    let intial_cancellation_data : String?
    let final_cancellation_data : String?
    let final_cancellation_made_by : String?
    let invoice_status : String?
    let search_id : String?
    let booking_customer_details : [Booking_customer_details]?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case app_reference = "app_reference"
        case tF_booking_reference = "TF_booking_reference"
        case supplier_reference = "supplier_reference"
        case source = "source"
        case airline = "airline"
        case pnr = "pnr"
        case airline_pnr = "airline_pnr"
        case suppliercode = "suppliercode"
        case providerlocatorcode = "providerlocatorcode"
        case invoice_number = "invoice_number"
        case provab_invoice_number = "provab_invoice_number"
        case status = "status"
        case sales_chanel = "sales_chanel"
        case wego_click_id = "wego_click_id"
        case status_description = "status_description"
        case book_id = "book_id"
        case booking_source = "booking_source"
        case ref_id = "ref_id"
        case is_dom = "is_dom"
        case total_fare = "total_fare"
        case admin_commission = "admin_commission"
        case dist_commission = "dist_commission"
        case agent_commission = "agent_commission"
        case admin_tds_on_commission = "admin_tds_on_commission"
        case dist_tds_on_commission = "dist_tds_on_commission"
        case agent_tds_on_commission = "agent_tds_on_commission"
        case admin_markup = "admin_markup"
        case dist_markup = "dist_markup"
        case agent_markup = "agent_markup"
        case handling_charge = "handling_charge"
        case service_tax = "service_tax"
        case convinence_amount = "convinence_amount"
        case currency = "currency"
        case fare_attributes = "fare_attributes"
        case flight_fare_attributes = "flight_fare_attributes"
        case getbooking_StatusCode = "getbooking_StatusCode"
        case getbooking_Description = "getbooking_Description"
        case getbooking_Category = "getbooking_Category"
        case attributes = "attributes"
        case api_attributes = "api_attributes"
        case sequence_number = "sequence_number"
        case api_total_fare = "api_total_fare"
        case payment_status = "payment_status"
        case payment_mode = "payment_mode"
        case payment_invoice_id = "payment_invoice_id"
        case payment_invoice_ref = "payment_invoice_ref"
        case manual_payment_status = "manual_payment_status"
        case manual_payment_mode = "manual_payment_mode"
        case manual_payment_invoice_id = "manual_payment_invoice_id"
        case manual_payment_invoice_ref = "manual_payment_invoice_ref"
        case booking_ip_address = "booking_ip_address"
        case search_data = "search_data"
        case email_sent = "email_sent"
        case customer_payment_details = "customer_payment_details"
        case amount_adjustment_type = "amount_adjustment_type"
        case amount_adjustment_value = "amount_adjustment_value"
        case cabin_class = "cabin_class"
        case total_pax = "total_pax"
        case pos = "pos"
        case pcc = "pcc"
        case language = "language"
        case exchange_rate = "exchange_rate"
        case action_by_id = "action_by_id"
        case tre = "tre"
        case last_manual_booking_date_time = "last_manual_booking_date_time"
        case count_manual_booking = "count_manual_booking"
        case all_last_manual_booking_date_time = "all_last_manual_booking_date_time"
        case manual_booking_reference_num = "manual_booking_reference_num"
        case latestTicketingTime = "LatestTicketingTime"
        case remarks = "remarks"
        case modified = "modified"
        case seat_data_req = "seat_data_req"
        case seat_data = "seat_data"
        case seat_cost = "seat_cost"
        case intial_cancellation_data = "intial_cancellation_data"
        case final_cancellation_data = "final_cancellation_data"
        case final_cancellation_made_by = "final_cancellation_made_by"
        case invoice_status = "invoice_status"
        case search_id = "search_id"
        case booking_customer_details = "booking_customer_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        tF_booking_reference = try values.decodeIfPresent(String.self, forKey: .tF_booking_reference)
        supplier_reference = try values.decodeIfPresent(String.self, forKey: .supplier_reference)
        source = try values.decodeIfPresent(String.self, forKey: .source)
        airline = try values.decodeIfPresent(String.self, forKey: .airline)
        pnr = try values.decodeIfPresent(String.self, forKey: .pnr)
        airline_pnr = try values.decodeIfPresent(String.self, forKey: .airline_pnr)
        suppliercode = try values.decodeIfPresent(String.self, forKey: .suppliercode)
        providerlocatorcode = try values.decodeIfPresent(String.self, forKey: .providerlocatorcode)
        invoice_number = try values.decodeIfPresent(String.self, forKey: .invoice_number)
        provab_invoice_number = try values.decodeIfPresent(String.self, forKey: .provab_invoice_number)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        sales_chanel = try values.decodeIfPresent(String.self, forKey: .sales_chanel)
        wego_click_id = try values.decodeIfPresent(String.self, forKey: .wego_click_id)
        status_description = try values.decodeIfPresent(String.self, forKey: .status_description)
        book_id = try values.decodeIfPresent(String.self, forKey: .book_id)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        ref_id = try values.decodeIfPresent(String.self, forKey: .ref_id)
        is_dom = try values.decodeIfPresent(String.self, forKey: .is_dom)
        total_fare = try values.decodeIfPresent(String.self, forKey: .total_fare)
        admin_commission = try values.decodeIfPresent(String.self, forKey: .admin_commission)
        dist_commission = try values.decodeIfPresent(String.self, forKey: .dist_commission)
        agent_commission = try values.decodeIfPresent(String.self, forKey: .agent_commission)
        admin_tds_on_commission = try values.decodeIfPresent(String.self, forKey: .admin_tds_on_commission)
        dist_tds_on_commission = try values.decodeIfPresent(String.self, forKey: .dist_tds_on_commission)
        agent_tds_on_commission = try values.decodeIfPresent(String.self, forKey: .agent_tds_on_commission)
        admin_markup = try values.decodeIfPresent(String.self, forKey: .admin_markup)
        dist_markup = try values.decodeIfPresent(String.self, forKey: .dist_markup)
        agent_markup = try values.decodeIfPresent(String.self, forKey: .agent_markup)
        handling_charge = try values.decodeIfPresent(String.self, forKey: .handling_charge)
        service_tax = try values.decodeIfPresent(String.self, forKey: .service_tax)
        convinence_amount = try values.decodeIfPresent(String.self, forKey: .convinence_amount)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        fare_attributes = try values.decodeIfPresent(String.self, forKey: .fare_attributes)
        flight_fare_attributes = try values.decodeIfPresent(String.self, forKey: .flight_fare_attributes)
        getbooking_StatusCode = try values.decodeIfPresent(String.self, forKey: .getbooking_StatusCode)
        getbooking_Description = try values.decodeIfPresent(String.self, forKey: .getbooking_Description)
        getbooking_Category = try values.decodeIfPresent(String.self, forKey: .getbooking_Category)
        attributes = try values.decodeIfPresent(String.self, forKey: .attributes)
        api_attributes = try values.decodeIfPresent(String.self, forKey: .api_attributes)
        sequence_number = try values.decodeIfPresent(String.self, forKey: .sequence_number)
        api_total_fare = try values.decodeIfPresent(String.self, forKey: .api_total_fare)
        payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
        payment_mode = try values.decodeIfPresent(String.self, forKey: .payment_mode)
        payment_invoice_id = try values.decodeIfPresent(String.self, forKey: .payment_invoice_id)
        payment_invoice_ref = try values.decodeIfPresent(String.self, forKey: .payment_invoice_ref)
        manual_payment_status = try values.decodeIfPresent(String.self, forKey: .manual_payment_status)
        manual_payment_mode = try values.decodeIfPresent(String.self, forKey: .manual_payment_mode)
        manual_payment_invoice_id = try values.decodeIfPresent(String.self, forKey: .manual_payment_invoice_id)
        manual_payment_invoice_ref = try values.decodeIfPresent(String.self, forKey: .manual_payment_invoice_ref)
        booking_ip_address = try values.decodeIfPresent(String.self, forKey: .booking_ip_address)
        search_data = try values.decodeIfPresent(String.self, forKey: .search_data)
        email_sent = try values.decodeIfPresent(String.self, forKey: .email_sent)
        customer_payment_details = try values.decodeIfPresent(String.self, forKey: .customer_payment_details)
        amount_adjustment_type = try values.decodeIfPresent(String.self, forKey: .amount_adjustment_type)
        amount_adjustment_value = try values.decodeIfPresent(String.self, forKey: .amount_adjustment_value)
        cabin_class = try values.decodeIfPresent(String.self, forKey: .cabin_class)
        total_pax = try values.decodeIfPresent(String.self, forKey: .total_pax)
        pos = try values.decodeIfPresent(String.self, forKey: .pos)
        pcc = try values.decodeIfPresent(String.self, forKey: .pcc)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        exchange_rate = try values.decodeIfPresent(String.self, forKey: .exchange_rate)
        action_by_id = try values.decodeIfPresent(String.self, forKey: .action_by_id)
        tre = try values.decodeIfPresent(String.self, forKey: .tre)
        last_manual_booking_date_time = try values.decodeIfPresent(String.self, forKey: .last_manual_booking_date_time)
        count_manual_booking = try values.decodeIfPresent(String.self, forKey: .count_manual_booking)
        all_last_manual_booking_date_time = try values.decodeIfPresent(String.self, forKey: .all_last_manual_booking_date_time)
        manual_booking_reference_num = try values.decodeIfPresent(String.self, forKey: .manual_booking_reference_num)
        latestTicketingTime = try values.decodeIfPresent(String.self, forKey: .latestTicketingTime)
        remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
        modified = try values.decodeIfPresent(String.self, forKey: .modified)
        seat_data_req = try values.decodeIfPresent(String.self, forKey: .seat_data_req)
        seat_data = try values.decodeIfPresent(String.self, forKey: .seat_data)
        seat_cost = try values.decodeIfPresent(String.self, forKey: .seat_cost)
        intial_cancellation_data = try values.decodeIfPresent(String.self, forKey: .intial_cancellation_data)
        final_cancellation_data = try values.decodeIfPresent(String.self, forKey: .final_cancellation_data)
        final_cancellation_made_by = try values.decodeIfPresent(String.self, forKey: .final_cancellation_made_by)
        invoice_status = try values.decodeIfPresent(String.self, forKey: .invoice_status)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        booking_customer_details = try values.decodeIfPresent([Booking_customer_details].self, forKey: .booking_customer_details)
    }

}
