//
//  GetAirlineListViewModel.swift
//  BabSafar
//
//  Created by Admin on 25/06/24.
//

import Foundation
protocol GetAirlineListViewModelDelegate : BaseViewModelProtocol {
    func getAirlineList(response : AirlinelistModel)
}

class GetAirlineListViewModel {

    var view: GetAirlineListViewModelDelegate!
    init(_ view: GetAirlineListViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_AIRLINE_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

      //  self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: "general/\(ApiEndpoints.get_airlines_list)" , parameters: parms, resultType: AirlinelistModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
            //    self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.getAirlineList(response: response)
                } else {
                    // Show alert
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    

}
