

import Foundation
struct Pg_record : Codable {
	let origin : String?
	let domain_origin : String?
	let app_reference : String?
	let payment_type : String?
	let status : String?
	let invoice_id : String?
	let amount : String?
	let currency : String?
	let request_params : String?
	let response_params : String?
	let request_params_pay : String?
	let pg_req : String?
	let pg_res : String?
	let updated_payment_gateway_response : String?
	let updated_payment_gateway_response_time : String?
	let created_datetime : String?
	let promocode : String?
	let deal_code : String?
	let use_limit : String?
	let rewards_point : String?
	let rewards_amount : String?
	let reward_earned : String?
	let pg_link : String?
	let mb_ap_ref : String?
	let payment_mode : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case domain_origin = "domain_origin"
		case app_reference = "app_reference"
		case payment_type = "payment_type"
		case status = "status"
		case invoice_id = "invoice_id"
		case amount = "amount"
		case currency = "currency"
		case request_params = "request_params"
		case response_params = "response_params"
		case request_params_pay = "request_params_pay"
		case pg_req = "pg_req"
		case pg_res = "pg_res"
		case updated_payment_gateway_response = "updated_payment_gateway_response"
		case updated_payment_gateway_response_time = "updated_payment_gateway_response_time"
		case created_datetime = "created_datetime"
		case promocode = "promocode"
		case deal_code = "deal_code"
		case use_limit = "use_limit"
		case rewards_point = "rewards_point"
		case rewards_amount = "rewards_amount"
		case reward_earned = "reward_earned"
		case pg_link = "pg_link"
		case mb_ap_ref = "mb_ap_ref"
		case payment_mode = "payment_mode"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		domain_origin = try values.decodeIfPresent(String.self, forKey: .domain_origin)
		app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
		payment_type = try values.decodeIfPresent(String.self, forKey: .payment_type)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		invoice_id = try values.decodeIfPresent(String.self, forKey: .invoice_id)
		amount = try values.decodeIfPresent(String.self, forKey: .amount)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		request_params = try values.decodeIfPresent(String.self, forKey: .request_params)
		response_params = try values.decodeIfPresent(String.self, forKey: .response_params)
		request_params_pay = try values.decodeIfPresent(String.self, forKey: .request_params_pay)
		pg_req = try values.decodeIfPresent(String.self, forKey: .pg_req)
		pg_res = try values.decodeIfPresent(String.self, forKey: .pg_res)
		updated_payment_gateway_response = try values.decodeIfPresent(String.self, forKey: .updated_payment_gateway_response)
		updated_payment_gateway_response_time = try values.decodeIfPresent(String.self, forKey: .updated_payment_gateway_response_time)
		created_datetime = try values.decodeIfPresent(String.self, forKey: .created_datetime)
		promocode = try values.decodeIfPresent(String.self, forKey: .promocode)
		deal_code = try values.decodeIfPresent(String.self, forKey: .deal_code)
		use_limit = try values.decodeIfPresent(String.self, forKey: .use_limit)
		rewards_point = try values.decodeIfPresent(String.self, forKey: .rewards_point)
		rewards_amount = try values.decodeIfPresent(String.self, forKey: .rewards_amount)
		reward_earned = try values.decodeIfPresent(String.self, forKey: .reward_earned)
		pg_link = try values.decodeIfPresent(String.self, forKey: .pg_link)
		mb_ap_ref = try values.decodeIfPresent(String.self, forKey: .mb_ap_ref)
		payment_mode = try values.decodeIfPresent(String.self, forKey: .payment_mode)
	}

}
