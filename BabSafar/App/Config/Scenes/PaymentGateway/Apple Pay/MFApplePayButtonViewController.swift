//
//  MFApplePayButtonViewController.swift
//  MFSDKDemo-Swift
//
//  Created by Elsayed Hussein on 2/26/22.
//  Copyright © 2022 Elsayed Hussein. All rights reserved.
//

import UIKit
import MFSDK

class MFApplePayButtonViewController: UIViewController {

    @IBOutlet weak var applePayView: MFApplePayButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var errorCodeLabel : UILabel!
    @IBOutlet weak var resultTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let applePayConfigure = MFInApplePayConfigureBuilder.default
        applePayConfigure.setHeight(50)
        applePayConfigure.setBorderRadius(20)
        applePayConfigure.setButtonText("Buy with")
        applePayConfigure.hideLoadingIndicator(true)
        applePayView.configure = applePayConfigure
//        
        setupApplePay()
    }
    
    fileprivate func setupApplePay() {
        activityIndicator.startAnimating()
        let request = MFInitiateSessionRequest(customerIdentifier: "asd")
        MFPaymentRequest.shared.initiateSession(request: request, apiLanguage: .english) { [weak self] response in
            self?.activityIndicator.stopAnimating()
            guard let self = self else { return }
            switch response {
            case .success(let session):
                self.applePayView.load(session, self.getExecuteRequestForCardPayment(), .english, startLoading: {
                    self.activityIndicator.startAnimating()
                }, completion: { response, invoiceId in
                    self.activityIndicator.stopAnimating()
                    switch response {
                    case .success(let executePaymentResponse):
                        if let invoiceStatus = executePaymentResponse.invoiceStatus {
                            self.showSuccess(invoiceStatus)
                        }
                    case .failure(let error):
                        self.showFailError(error)
                    }
                })
            case .failure(let error):
                print("#initiate session", error.localizedDescription)
            }
        }
    }
    func showSuccess(_ message: String) {
        errorCodeLabel.text = "Succes"
        resultTextView.text = "result: \(message)"
    }
    
    func showFailError(_ error: MFFailResponse) {
        errorCodeLabel.text = "responseCode: \(error.statusCode)"
        resultTextView.text = "Error: \(error.errorDescription)"
    }
    
    func getExecuteRequestForCardPayment() -> MFExecutePaymentRequest {
        let invoiceValue = Decimal(string: amountTextField.text ?? "0") ?? 0
        let request = MFExecutePaymentRequest(invoiceValue: invoiceValue)
        //request.userDefinedField = ""
        request.customerEmail = "a@b.com"// must be email
        request.customerMobile = "66556655"
        request.customerCivilId = "12345678902222"
        let address = MFCustomerAddress(block: "ddd", street: "sss", houseBuildingNo: "sss", address: "sss", addressInstructions: "sss")
        request.customerAddress = address
        request.customerName = "Hosny"
        request.customerReference = "Hosny22"
        request.language = .english
        request.mobileCountryCode = MFMobileCountryCodeISO.kuwait.rawValue
        request.displayCurrencyIso = .kuwait_KWD
//        request.supplierCode = 1
//        request.supplierValue = 1
//        request.suppliers.append(MFSupplier(supplierCode: 1, invoiceShare: 1))
        // Uncomment this to add products for your invoice
//         var productList = [MFProduct]()
//        let product = MFProduct(name: "ABC", unitPrice: 1.887, quantity: 1)
//         productList.append(product)
//         request.invoiceItems = productList
        return request
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
