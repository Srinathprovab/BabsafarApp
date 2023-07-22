//
//  MobilsPaymentGatwayViewModel.swift
//  BabSafar
//
//  Created by FCI on 26/12/22.
//

import Foundation



protocol MobilsPaymentGatwayViewModelDelegate : BaseViewModelProtocol {
    func paymentGatewaySucess(response:MobilePrePaymentModel)
}

class MobilsPaymentGatwayViewModel {
    
    var view: MobilsPaymentGatwayViewModelDelegate!
    init(_ view: MobilsPaymentGatwayViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK:  Get voucher Details API
    func CALL_MOBILE_PAYMENT_GATE_WAY_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url , parameters: parms, resultType: MobilePrePaymentModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.paymentGatewaySucess(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }

    
}
