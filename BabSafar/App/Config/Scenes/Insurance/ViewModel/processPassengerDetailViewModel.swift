//
//  processPassengerDetailViewModel.swift
//  BabSafar
//
//  Created by FCI on 29/08/23.
//

import Foundation



protocol processPassengerDetailViewModelDelegate : BaseViewModelProtocol {
    func processPassengerDetails(response : processPassengerDetailModel)
    
}

class processPassengerDetailViewModel {
    
    var view: processPassengerDetailViewModelDelegate!
    init(_ view: processPassengerDetailViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_PROCESS_PASSENGER_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
          self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.process_passenger_detail, parameters: parms, resultType: processPassengerDetailModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.processPassengerDetails(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
    
    
}
