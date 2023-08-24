//
//  FasttrackViewModel.swift
//  BabSafar
//
//  Created by FCI on 24/08/23.
//

import Foundation


protocol FasttrackViewModelDelegate : BaseViewModelProtocol {
    func fasttrackList(response : FasttrackModel)
}

class FasttrackViewModel {
    
    var view: FasttrackViewModelDelegate!
    init(_ view: FasttrackViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_FASTTRACK_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_pre_fastrack_search , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: FasttrackModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.fasttrackList(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
}
