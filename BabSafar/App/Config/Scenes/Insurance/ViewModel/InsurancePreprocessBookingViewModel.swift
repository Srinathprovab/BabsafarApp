//
//  InsurancePreprocessBookingViewModel.swift
//  BabSafar
//
//  Created by FCI on 23/08/23.
//

import Foundation


protocol InsurancePreprocessBookingViewModelDelegate : BaseViewModelProtocol {
    func insurencePaymentshow(response : InsurancePreprocessBookingModel)
    
}

class InsurancePreprocessBookingViewModel {

    var view: InsurancePreprocessBookingViewModelDelegate!
    init(_ view: InsurancePreprocessBookingViewModelDelegate) {
        self.view = view
    }


    func CALL_MOBILE_PRE_PROCESS_BOOKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.insurance_pre_process_booking, parameters: parms, resultType: InsurancePreprocessBookingModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.insurencePaymentshow(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    


}
