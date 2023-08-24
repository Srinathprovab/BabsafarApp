//
//  FastrackAirlineListViewModel.swift
//  BabSafar
//
//  Created by FCI on 24/08/23.
//

import Foundation



protocol FastrackAirlineListViewModelDelegate : BaseViewModelProtocol {
    func airlineList(response : [FastrackAirlineListModel])
}

class FastrackAirlineListViewModel {
    
    var view: FastrackAirlineListViewModelDelegate!
    init(_ view: FastrackAirlineListViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_AIRLINE_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.get_fasttrack_airport_code_list , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: [FastrackAirlineListModel].self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //    self.view?.hideLoader()
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
