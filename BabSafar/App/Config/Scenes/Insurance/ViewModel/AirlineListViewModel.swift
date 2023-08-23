//
//  AirlineListViewModel.swift
//  BabSafar
//
//  Created by FCI on 23/08/23.
//

import Foundation



protocol AirlineListViewModelDelegate : BaseViewModelProtocol {
    func airlineList(response : [AirlineListModel])
    
}

class AirlineListViewModel {
    
    var view: AirlineListViewModelDelegate!
    init(_ view: AirlineListViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_AIRLINE_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.insurance_get_airline_list, parameters: parms, resultType: [AirlineListModel].self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.airlineList(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
    
    
}
