//
//  MyFatoorahPaymentViewController.swift
//  BabSafar
//
//  Created by FCI on 15/07/23.
//

import UIKit
import MFSDK

class MyFatoorahPaymentViewController: UIViewController {
    
    
    static var newInstance: MyFatoorahPaymentViewController? {
        let storyboard = UIStoryboard(name: Storyboard.Payment.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? MyFatoorahPaymentViewController
        return vc
    }
    
    var payload = [String:Any]()
    var amount = String()
    
    override func viewWillAppear(_ animated: Bool) {
        initiatePayment()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
        MFSettings.shared.delegate = self
    }
    
    
    func initiatePayment(){
        // initiatePayment
        let invoiceValue = 5.0
        var selectedPaymentMethod = 1
        let initiatePayment = MFInitiatePaymentRequest(invoiceAmount: Decimal(invoiceValue), currencyIso: .kuwait_KWD)
        MFPaymentRequest.shared.initiatePayment(request: initiatePayment, apiLanguage: .english) {(response) in
            switch response {
            case .success(let initiatePaymentResponse):
                var paymentMethods = initiatePaymentResponse.paymentMethods
                if let paymentMethods = initiatePaymentResponse.paymentMethods, !paymentMethods.isEmpty {
                    selectedPaymentMethod = paymentMethods[0].paymentMethodId
                }
            case .failure(let failError):
                print(failError)
            }
        }
        
        
        // executePayment
        
       // let request = getExecutePaymentRequest(paymentMethodId: selectedPaymentMethod)
        let request = MFExecutePaymentRequest(invoiceValue: Decimal(invoiceValue), paymentMethod: selectedPaymentMethod)
        
        // Uncomment this to add ptoducts for your invoice
        // var productList = [MFProduct]()
        // let product = MFProduct(name: "ABC", unitPrice: 1, quantity: 2)
        // productList.append(product)
        // request.invoiceItems = productList
        
        MFPaymentRequest.shared.executePayment(request: request, apiLanguage: .english) {  (response,invoiceId) in
            switch response {
            case .success(let executePaymentResponse):
                print("invoiceStatus \(executePaymentResponse)")
            case .failure(let failError):
                print(failError)
            }
        }
        
    }
    
    
    private func getExecutePaymentRequest(paymentMethodId: Int) -> MFExecutePaymentRequest {
        let invoiceValue = Decimal(string: amount) ?? 0
        let request = MFExecutePaymentRequest(invoiceValue: invoiceValue , paymentMethod: paymentMethodId)
        //request.userDefinedField = ""
        request.customerEmail = "srinathb88@gmail.com"// must be email
        request.customerMobile = "9611118507"
        request.customerCivilId = "1234567890"
        request.customerName = "Srinath"
        let address = MFCustomerAddress(block: "ddd", street: "sss", houseBuildingNo: "sss", address: "sss", addressInstructions: "sss")
        request.customerAddress = address
        request.customerReference = "Test MyFatoorah Reference"
        request.language = .english
        request.mobileCountryCode = MFMobileCountryCodeISO.kuwait.rawValue
        request.displayCurrencyIso = .kuwait_KWD
        //        request.recurringModel = MFRecurringModel(recurringType: .weekly, iteration: 2)
        //        request.supplierValue = 1
        //        request.supplierCode = 2
        //        request.suppliers.append(MFSupplier(supplierCode: 1, proposedShare: 2, invoiceShare: invoiceValue))
        
        // Uncomment this to add products for your invoice
        //         var productList = [MFProduct]()
        //        let product = MFProduct(name: "ABC", unitPrice: 1.887, quantity: 1)
        //         productList.append(product)
        //         request.invoiceItems = productList
        return request
    }
    
    
}

// conforms ```MFPaymentDelegate```
extension MyFatoorahPaymentViewController: MFPaymentDelegate {
    func didInvoiceCreated(invoiceId: String) {
        print("#\(invoiceId)")
    }
}
