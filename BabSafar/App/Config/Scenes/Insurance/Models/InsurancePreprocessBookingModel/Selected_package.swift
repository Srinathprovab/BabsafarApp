/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Selected_package : Codable {
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
	let planContent : String?
	let planQualifiedPassengers : String?
	let planPricingBreakdown : PlanPricingBreakdown?
	let planType : String?
	let up_sell_plan : Bool?
	let currency : String?
	let price : Price?

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
		case planContent = "PlanContent"
		case planQualifiedPassengers = "PlanQualifiedPassengers"
		case planPricingBreakdown = "PlanPricingBreakdown"
		case planType = "PlanType"
		case up_sell_plan = "up_sell_plan"
		case currency = "Currency"
		case price = "price"
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
		planContent = try values.decodeIfPresent(String.self, forKey: .planContent)
		planQualifiedPassengers = try values.decodeIfPresent(String.self, forKey: .planQualifiedPassengers)
		planPricingBreakdown = try values.decodeIfPresent(PlanPricingBreakdown.self, forKey: .planPricingBreakdown)
		planType = try values.decodeIfPresent(String.self, forKey: .planType)
		up_sell_plan = try values.decodeIfPresent(Bool.self, forKey: .up_sell_plan)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		price = try values.decodeIfPresent(Price.self, forKey: .price)
	}

}