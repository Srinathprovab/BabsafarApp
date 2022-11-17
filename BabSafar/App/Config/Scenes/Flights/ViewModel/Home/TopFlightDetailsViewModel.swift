//
//  TopFlightDetailsViewModel.swift
//  BabSafar
//
//  Created by FCI on 17/11/22.
//

import Foundation

protocol TopFlightDetailsViewModelDelegate : BaseViewModelProtocol {
    func topFlightDetailsImages(response : TopFlightDetailsModel)
}

class TopFlightDetailsViewModel {

    var view: TopFlightDetailsViewModelDelegate!
    init(_ view: TopFlightDetailsViewModelDelegate) {
        self.view = view
    }


    func callTopFlightsHotelsDetailsAPI(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.getTopFlightHotelDestination , parameters: parms, resultType: TopFlightDetailsModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.topFlightDetailsImages(response: response)
                } else {
                    // Show alert
                    NotificationCenter.default.post(name: NSNotification.Name("nointernet"), object: errorMessage)
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    

}
