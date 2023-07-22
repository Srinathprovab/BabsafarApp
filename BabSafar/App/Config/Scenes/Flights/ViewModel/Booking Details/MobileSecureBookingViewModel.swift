//
//  MobileSecureBookingViewModel.swift
//  BabSafar
//
//  Created by FCI on 26/12/22.
//

import Foundation



protocol MobileSecureBookingViewModelDelegate : BaseViewModelProtocol {
    func mobilesecurebookingDetails(response:MobilePrePaymentModel)
}

class MobileSecureBookingViewModel {
    
    var view: MobileSecureBookingViewModelDelegate!
    init(_ view: MobileSecureBookingViewModelDelegate) {
        self.view = view
    }
    
    
    
    
    //MARK:  mobile_secure_booking API
    func Call_mobile_secure_booking_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url , parameters: parms, resultType: MobilePrePaymentModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.mobilesecurebookingDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }

    
}
