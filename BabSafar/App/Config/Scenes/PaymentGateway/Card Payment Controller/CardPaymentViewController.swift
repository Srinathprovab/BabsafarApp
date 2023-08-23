//
//  CardPaymentViewController.swift
//  MFSDKDemo-Swift
//
//  Created by Elsayed Hussein on 10/18/21.
//  Copyright © 2021 Elsayed Hussein. All rights reserved.
//

import UIKit
import MFSDK

class CardPaymentViewController: UIViewController {
    // MARK: - Variables
    
    // MARK: - Outlets
    @IBOutlet weak var paymentCardView: MFPaymentCardView!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorStatusLabel: UILabel!
    @IBOutlet weak var resultTextView: UITextView!
    
    // MARK: - lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get default configure
        let configure = MFCardConfigureBuilder.default
//        // but you can create yours
//        // set placeholders
        configure.setPlaceholder(MFCardPlaceholder(cardHolderNamePlaceholder: "Name", cardNumberPlaceholder: "Number", expiryDatePlaceholder: "MM / YY", cvvPlaceholder: "CVV"))
//        //set labels
        configure.setLabel(MFCardLabel(cardHolderNameLabel: "Card holder name", cardNumberLabel: "Card number", expiryDateLabel: "MM / YY", cvvLabel: "CVV", showLabels: true))
//        // set theme
        let theme = MFCardTheme(inputColor: .black, labelColor: .black, errorColor: .red)
    
        // to make direction rtl or ltr
        theme.language = .arabic
        configure.setTheme(theme)
//
//
//        // set labels and texts font size
        configure.setFontSize(15)
//
//        // set border width
        configure.setBorderWidth(1)
//
//        // set border radius for input fields
        configure.setBorderRadius(8)
        configure.setCardInput(MFCardInput(inputHeight: 32, inputMargin: 15))
        configure.setFontFamily(.arial)
        
        configure.setBoxShadow(MFBoxShadow(hOffset: 0, vOffset: 0, blur: 0, spread: 0, color: .gray))

//          create the new configure and assigned to payment card view
        paymentCardView.configure = configure.build()
        
        // initiate session
        let request = MFInitiateSessionRequest(customerIdentifier: "asd")
        MFPaymentRequest.shared.initiateSession(request: request, apiLanguage: .english) { [weak self] response in
            switch response {
            case .success(let session):
                    self?.paymentCardView.load(initiateSession: session)
            case .failure(let error):
                print("#initiate session", error.localizedDescription)
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func payDidTapped(_ sender: UIButton) {
        executeInAppPayment()
    }
    
    // MARK: - Methods
    fileprivate func executeInAppPayment() {
        let request = getExecuteRequestForCardPayment()
        startCardViewLoading()
        paymentCardView.pay(request, .english) { [weak self] response, invoiceId  in
            self?.stopCardViewLoading()
            switch response {
            case .success(let executePaymentResponse):
                if let invoiceStatus = executePaymentResponse.invoiceStatus {
                    self?.showSuccess(invoiceStatus)
                }
            case .failure(let failError):
                self?.showFailError(failError)
            }
        }
    }
    private func getExecuteRequestForCardPayment() -> MFExecutePaymentRequest {
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
        request.displayCurrencyIso = .uAE_AED
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
    
}

extension CardPaymentViewController {
    func startCardViewLoading() {
        errorStatusLabel.text = "Status:"
        resultTextView.text = "Result:"
        payButton.setTitle("", for: .normal)
        activityIndicator.startAnimating()
    }
    func stopCardViewLoading() {
        payButton.setTitle("Pay", for: .normal)
        activityIndicator.stopAnimating()
    }
    func showSuccess(_ message: String) {
        errorStatusLabel.text = "Succes"
        resultTextView.text = "result: \(message)"
    }
    
    func showFailError(_ error: MFFailResponse) {
        errorStatusLabel.text = "Response Code: \(error.statusCode)"
        resultTextView.text = "Error: \(error.errorDescription)"
    }
}
