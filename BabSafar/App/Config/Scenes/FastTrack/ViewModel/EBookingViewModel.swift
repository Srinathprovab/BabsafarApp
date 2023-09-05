//
//  EBookingViewModel.swift
//  BabSafar
//
//  Created by FCI on 05/09/23.
//

import Foundation



protocol EBookingViewModelDelegate : BaseViewModelProtocol {
    func bookingDetails(response : EBookingModel)
}

class EBookingViewModel {
    
    var view: EBookingViewModelDelegate!
    init(_ view: EBookingViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_EXPLORE_BOOKING_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
          self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.efastrack_booking , parameters: parms, resultType: EBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                    self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.bookingDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
}
