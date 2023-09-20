//
//  InsurenceVoucherViewModel.swift
//  BabSafar
//
//  Created by FCI on 05/09/23.
//

import Foundation


protocol InsurenceVoucherViewModelDelegate : BaseViewModelProtocol {
    func insurencevoucherDetails(response : InsurenceVoucherModel)
    
}

class InsurenceVoucherViewModel {
    
    var view: InsurenceVoucherViewModelDelegate!
    init(_ view: InsurenceVoucherViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_INSURECE_VOUCHER_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
          self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url, parameters: parms, resultType: InsurenceVoucherModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.insurencevoucherDetails(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
