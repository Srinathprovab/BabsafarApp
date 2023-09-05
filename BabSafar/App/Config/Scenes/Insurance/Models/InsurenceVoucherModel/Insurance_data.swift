

import Foundation
struct Insurance_data : Codable {
	let planCode : String?
	let sSRFeeCode : String?
	let currencyCode : String?
	let totalPremiumAmount : String?
	let totalCoverageAmount : String?
	let planPremiumChargeType : String?
	let planTitle : String?
	let planDesc : String?
	let planAdditionalInfoTitle : String?
	let planAdditionalInfoDesc : String?
	let planYesDesc : String?
	let planNoDesc : String?
	let planNoConsideration : String?
	let planTnC : String?
	let isDefaultPlan : String?
	let planQualifiedPassengers : String?
	let planType : String?
	let up_sell_plan : Bool?
	let currency : String?
	let plan_image : String?

	enum CodingKeys: String, CodingKey {

		case planCode = "PlanCode"
		case sSRFeeCode = "SSRFeeCode"
		case currencyCode = "CurrencyCode"
		case totalPremiumAmount = "TotalPremiumAmount"
		case totalCoverageAmount = "TotalCoverageAmount"
		case planPremiumChargeType = "PlanPremiumChargeType"
		case planTitle = "PlanTitle"
		case planDesc = "PlanDesc"
		case planAdditionalInfoTitle = "PlanAdditionalInfoTitle"
		case planAdditionalInfoDesc = "PlanAdditionalInfoDesc"
		case planYesDesc = "PlanYesDesc"
		case planNoDesc = "PlanNoDesc"
		case planNoConsideration = "PlanNoConsideration"
		case planTnC = "PlanTnC"
		case isDefaultPlan = "IsDefaultPlan"
		case planQualifiedPassengers = "PlanQualifiedPassengers"
		case planType = "PlanType"
		case up_sell_plan = "up_sell_plan"
		case currency = "Currency"
		case plan_image = "plan_image"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		planCode = try values.decodeIfPresent(String.self, forKey: .planCode)
		sSRFeeCode = try values.decodeIfPresent(String.self, forKey: .sSRFeeCode)
		currencyCode = try values.decodeIfPresent(String.self, forKey: .currencyCode)
		totalPremiumAmount = try values.decodeIfPresent(String.self, forKey: .totalPremiumAmount)
		totalCoverageAmount = try values.decodeIfPresent(String.self, forKey: .totalCoverageAmount)
		planPremiumChargeType = try values.decodeIfPresent(String.self, forKey: .planPremiumChargeType)
		planTitle = try values.decodeIfPresent(String.self, forKey: .planTitle)
		planDesc = try values.decodeIfPresent(String.self, forKey: .planDesc)
		planAdditionalInfoTitle = try values.decodeIfPresent(String.self, forKey: .planAdditionalInfoTitle)
		planAdditionalInfoDesc = try values.decodeIfPresent(String.self, forKey: .planAdditionalInfoDesc)
		planYesDesc = try values.decodeIfPresent(String.self, forKey: .planYesDesc)
		planNoDesc = try values.decodeIfPresent(String.self, forKey: .planNoDesc)
		planNoConsideration = try values.decodeIfPresent(String.self, forKey: .planNoConsideration)
		planTnC = try values.decodeIfPresent(String.self, forKey: .planTnC)
		isDefaultPlan = try values.decodeIfPresent(String.self, forKey: .isDefaultPlan)
		planQualifiedPassengers = try values.decodeIfPresent(String.self, forKey: .planQualifiedPassengers)
		planType = try values.decodeIfPresent(String.self, forKey: .planType)
		up_sell_plan = try values.decodeIfPresent(Bool.self, forKey: .up_sell_plan)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		plan_image = try values.decodeIfPresent(String.self, forKey: .plan_image)
	}

}
