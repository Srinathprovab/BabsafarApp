//
//  HotelVoucherViewModel.swift
//  BabSafar
//
//  Created by FCI on 29/08/23.
//

import Foundation



protocol HotelVoucherViewModelDelegate : BaseViewModelProtocol {
    func hotelDetails(response : HotelVoucherModel)
}

class HotelVoucherViewModel {
    
    var view: HotelVoucherViewModelDelegate!
    init(_ view: HotelVoucherViewModelDelegate) {
        self.view = view
    }
    
    //MARK: - CALL_HOTEL_DETAILS_API
    func CALL_HOTEL_VOUCHER_DETAILS_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url, parameters: parms as NSDictionary, resultType: HotelVoucherModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelDetails(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
}
