//
//  ViewController+MFSDKServicesCall.swift
//  MFSDKDemo-Swift
//
//  Created by Elsayed Hussein on 8/29/19.
//  Copyright © 2019 Elsayed Hussein. All rights reserved.
//

import MFSDK




extension PaymentGatewayVC {
    
    func initiatePayment() {
        let request = generateInitiatePaymentModel()
        startLoading()
        MFPaymentRequest.shared.initiatePayment(request: request, apiLanguage: .english, completion: { [weak self] (result) in
            self?.stopLoading()
            switch result {
            case .success(let initiatePaymentResponse):
                self?.paymentMethods = initiatePaymentResponse.paymentMethods
                self?.collectionView.reloadData()
            case .failure(let failError):
                self?.showFailError(failError)
            }
        })
    }
    
    func executePayment(paymentMethodId: Int) {
        let request = getExecutePaymentRequest(paymentMethodId: paymentMethodId)
        startLoading()
        MFPaymentRequest.shared.executePayment(request: request, apiLanguage: .arabic) { [weak self] response, invoiceId  in
            self?.stopLoading()
            
            
            switch response {
            case .success(let executePaymentResponse):
                
                // Print the entire response object
                do {
                    let encoder = JSONEncoder()
                    // encoder.outputFormatting = .prettyPrinted // If you want the JSON to be formatted nicely
                    let jsonData = try encoder.encode(executePaymentResponse)
                    
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        // Now you have the JSON string representation of the response
                        print(jsonString)
                        self?.paymentResponse = jsonString
                        
                    }
                } catch {
                    print("Error encoding JSON: \(error)")
                }
                
                
                self?.showSuccess(executePaymentResponse.invoiceStatus ?? "")
                self?.callUpdatePaymentAPI(status: executePaymentResponse.invoiceStatus ?? "")
                
            case .failure(let failError):
                self?.showFailError(failError)
            }
        }
    }
    
    
    
    func callUpdatePaymentAPI(status:String) {
        
        self.payload.removeAll()
        if let selectedTap = defaults.object(forKey: UserDefaultsKeys.dashboardTapSelected) as? String ,selectedTap == "Flights"{
            
        }else {
            
            
            
        }
        
        
        if let selectedTap = defaults.object(forKey: UserDefaultsKeys.dashboardTapSelected) as? String {
            if selectedTap == "Flights" {
                payload["app_ref"] = tmpFlightPreBookingId
                payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
                payload["pg_req"] = self.paymentResponse
                payload["InvoiceStatus"] = status
                
                self.vm?.CALL_UPDATE_PAYMENT_API(dictParam: payload, endpoint: "updatePayment")
            } else if selectedTap == "Hotels" {
                payload["pg_status"] = "Succss"
                payload["product"] = "VHCID1420613748"
                payload["search_id"] = hotelSearchId
                payload["book_id"] = tmpFlightPreBookingId
                payload["pg_req"] = paymentResponse
               
                self.vm?.CALL_UPDATE_PAYMENT_API(dictParam: payload, endpoint: "success")
            } else {
                payload["InvoiceStatus"] = "Paid"
                payload["search_id"] = searchid
                payload["app_ref"] = tmpFlightPreBookingId
                payload["pg_req"] = paymentResponse
               
                
                self.vm?.CALL_UPDATE_PAYMENT_INSURENCE_API(dictParam: payload, endpoint: "updatePayment_insurance")
            }
        } else {
            // Handle the case where 'selectedTap' is not found in UserDefaults
        }
        
        
    }
    
    
    func updatePaymentSucess(response: updatePaymentFlightModel) {
        
        
        
        if let selectedTap = defaults.object(forKey: UserDefaultsKeys.dashboardTapSelected) as? String {
            if selectedTap == "Flights" {
                gotoBookingSucessVC(url: response.data ?? "")
            } else if selectedTap == "Hotels" {
                callSecureBookingAPI(urlStr: response.data ?? "")
            }
        } else {
            // Handle the case where 'selectedTap' is not found in UserDefaults
        }
        
        
    }
    
    
    func insurenceUpdatePaymentSucess(response: updateInsurenceModel) {
        gotoBookingSucessVC(url: response.url ?? "")
    }
    
    
    
    func gotoBookingSucessVC(url:String) {
        guard let vc = BookingSucessVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.voucherUrl = url
        present(vc, animated: true)
    }
    
    
    
    func callSecureBookingAPI(urlStr:String) {
        BASE_URL = ""
        vm?.CALL_SECURE_BOOKING_API(dictParam: [:], url: urlStr)
    }
    
    
    func sucerBookingSucess(response: secureBooingModel) {
        BASE_URL = BASE_URL1
        
        if response.status == 1 {
            gotoBookingSucessVC(url: response.url ?? "")
        }else {
            
        }
        
    }
    
    
}




extension PaymentGatewayVC {
    func executeDirectPayment(paymentMethodId: Int) {
        let request = getExecutePaymentRequest(paymentMethodId: paymentMethodId)
        let card = getCardInfo()
        startLoading()
        MFPaymentRequest.shared.executeDirectPayment(request: request, cardInfo: card, apiLanguage: .english) { [weak self] (response, invoiceId) in
            self?.stopLoading()
            switch response {
            case .success(let directPaymentResponse):
                if let cardInfoResponse = directPaymentResponse.cardInfoResponse, let card = cardInfoResponse.cardInfo {
                    // self?.resultTextView.text = "Status: with card number: \(card.number ?? "")"
                }
                if let invoiceId = invoiceId {
                    //  self?.errorCodeLabel.text = "Success with invoice id \(invoiceId)"
                } else {
                    // self?.errorCodeLabel.text = "Success"
                }
            case .failure(let failError):
                // self?.resultTextView.text = "Error: \(failError.errorDescription)"
                if let invoiceId = invoiceId {
                    // self?.errorCodeLabel.text = "Fail: \(failError.statusCode) with invoice id \(invoiceId)"
                } else {
                    // self?.errorCodeLabel.text = "Fail: \(failError.statusCode)"
                }
            }
        }
    }
    func executeApplePayPayment(paymentMethodId: Int) {
        let request = getExecutePaymentRequest(paymentMethodId: paymentMethodId)
        startLoading()
        if #available(iOS 13.0, *) {
            MFPaymentRequest.shared.executeApplePayPayment(request: request, apiLanguage: .arabic) { [weak self] (response, invoiceId) in
                self?.stopLoading()
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
        
    }
    
    
    
    
    
    //    func sendPayment() {
    //        let request = getSendPaymentRequest()
    //        startSendPaymentLoading()
    //        MFPaymentRequest.shared.sendPayment(request: request, apiLanguage: .arabic) { [weak self] (result) in
    //            self?.stopSendPaymentLoading()
    //            switch result {
    //            case .success(let sendPaymentResponse):
    //                if let invoiceURL = sendPaymentResponse.invoiceURL {
    //                    self?.errorCodeLabel.text = "Success"
    //                    self?.resultTextView.text = "result: send this link to your customers \(invoiceURL)"
    //                }
    //            case .failure(let failError):
    //                self?.showFailError(failError)
    //            }
    //
    //        }
    //    }
}

extension PaymentGatewayVC {
    private func generateInitiatePaymentModel() -> MFInitiatePaymentRequest {
        // you can create initiate payment request with invoice value and currency
        
        let request = MFInitiatePaymentRequest(invoiceAmount: Decimal(invoiceValue), currencyIso: .kuwait_KWD)
        return request
        
        //        let request = MFInitiatePaymentRequest()
        //        return request
    }
    private func getCardInfo() -> MFCardInfo {
        let cardNumber = cardNumberTextField.text ?? ""
        let cardExpiryMonth = monthTextField.text ?? ""
        let cardExpiryYear = yearTextField.text ?? ""
        let cardSecureCode = secureCodeTextField.text ?? ""
        let cardHolderName = cardHolderNameTextField.text ?? ""
        
        
        let card = MFCardInfo(cardNumber: cardNumber, cardExpiryMonth: cardExpiryMonth, cardExpiryYear: cardExpiryYear, cardHolderName: cardHolderName, cardSecurityCode: cardSecureCode, saveToken: false)
        //        card.bypass = false // default is true
        return card
    }
    
    
    
    private func getExecutePaymentRequest(paymentMethodId: Int) -> MFExecutePaymentRequest {
        
        let request = MFExecutePaymentRequest(invoiceValue: Decimal(invoiceValue) , paymentMethod: paymentMethodId)
        //request.userDefinedField = ""
        request.customerEmail = payemail// must be email
        request.customerMobile = paymobile
        request.customerCivilId = "1234567890"
        request.customerName = "name"
        
        let address = MFCustomerAddress(block: "ddd", street: "sss", houseBuildingNo: "sss", address: "sss", addressInstructions: "sss")
        request.customerAddress = address
        request.customerReference = tmpFlightPreBookingId
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
    
    
    
    
    //    func getSendPaymentRequest() -> MFSendPaymentRequest {
    //
    //        let request = MFSendPaymentRequest(invoiceValue: invoiceValue, notificationOption: .link, customerName: "Test")
    //
    //        // send invoice link as sms to specified number
    //        // let request = MFSendPaymentRequest(invoiceValue: invoiceValue, notificationOption: .sms, customerName: "Test")
    //        // request.customerMobile  = "" // required here
    //
    //        // get invoice link
    //        // let request = MFSendPaymentRequest(invoiceValue: invoiceValue, notificationOption: .link, customerName: "Test")
    //
    //        //  send invoice link to email
    //        // let request = MFSendPaymentRequest(invoiceValue: invoiceValue, notificationOption: .email, customerName: "Test")
    //        // request.customerEmail = "" required here
    //
    //
    //
    //        //request.userDefinedField = ""
    //        request.customerEmail = "a@b.com"// must be email
    //        request.customerMobile = "mobile no"//Required
    //        request.customerCivilId = ""
    //        request.mobileCountryIsoCode = MFMobileCountryCodeISO.kuwait.rawValue
    //        request.customerReference = ""
    //        request.language = .english
    //        let address = MFCustomerAddress(block: "ddd", street: "sss", houseBuildingNo: "sss", address: "sss", addressInstructions: "sss")
    //        request.customerAddress = address
    //        request.language = .english
    //        request.displayCurrencyIso = .kuwait_KWD
    //        let date = Date().addingTimeInterval(1000)
    //        request.expiryDate = date
    //        return request
    //    }
    
    
}

// MARK: - Recurring Payment
extension PaymentGatewayVC {
    
    func executeRecurringPayment(paymentMethodId: Int) {
        let request = MFExecutePaymentRequest(invoiceValue: Decimal(invoiceValue) , paymentMethod: paymentMethodId)
        let card = getCardInfo()
        MFPaymentRequest.shared.executeRecurringPayment(request: request, cardInfo: card, recurringType: .custom(intervalDays: 10), iteration: 2, apiLanguage: .english) { (response, invoiceId) in
            switch response {
            case .success(let directPaymentResponse):
                if let cardInfoResponse = directPaymentResponse.cardInfoResponse, let card = cardInfoResponse.cardInfo {
                    print("Status: with card number: \(card.number ?? "")")
                    print("Status: with recurring Id: \(cardInfoResponse.recurringId ?? "")")
                }
                if let invoiceId = invoiceId {
                    print("Success with invoice id \(invoiceId)")
                } else {
                    print("Success")
                }
            case .failure(let failError):
                print("Error: \(failError.errorDescription)")
                if let invoiceId = invoiceId {
                    print("Fail: \(failError.statusCode) with invoice id \(invoiceId)")
                } else {
                    print("Fail: \(failError.statusCode)")
                }
            }
        }
    }
    
    func executeRecurringPayment(recurringId: String) {
        MFPaymentRequest.shared.cancelRecurringPayment(recurringId: recurringId, apiLanguage: .english) { [weak self] (result) in
            switch result {
            case .success(let isCanceled):
                if isCanceled {
                    print("Success")
                }
                
            case .failure(let failError):
                self?.showFailError(failError)
            }
        }
    }
    
}

