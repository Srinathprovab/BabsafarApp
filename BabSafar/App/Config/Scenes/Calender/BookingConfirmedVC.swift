//
//  BookingConfirmedVC.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit
import FreshchatSDK

class BookingConfirmedVC: BaseTableVC, VocherDetailsViewModelDelegate, HotelVoucherViewModelDelegate {
    
    
    
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    
    var lastContentOffset: CGFloat = 0
    var viewModel:VocherDetailsViewModel?
    var hotelViewmodel:HotelVoucherViewModel?
    var urlString = String()
    var tablerow = [TableRow]()
   
    var hItinerary_details = [HItinerary_details]()
    var Customerdetails = [Customer_details]()
    var hCustomerdetails = [HCustomer_details]()
    var hbookingDetails = [HBooking_details]()
    var bookingsource = String()
    var bookingStatus = String()
    var hotelimg = ""
    var hotel_check_in = ""
    var hotel_check_out = ""
    var hotel_name = ""
    var hotel_address = ""
    var total_rooms = ""
    var adult_count = ""
    var vocherpdf = ""
    var bookingitinerarydetails = [Booking_itinerary_details]()

    
    
    static var newInstance: BookingConfirmedVC? {
        let storyboard = UIStoryboard(name: Storyboard.Calender.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingConfirmedVC
        return vc
    }
    
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
        
        
        if screenHeight < 835 {
            navHeight.constant = 90
        }
        
        
        if callapibool == true {
            callAPI()
        }
        
    }
    
    
    func callAPI() {
        BASE_URL = ""
        if let selectedTap = defaults.object(forKey: UserDefaultsKeys.dashboardTapSelected) as? String {
            if selectedTap == "Flights" {
                callGetFlightVoucherAPI()
            } else if selectedTap == "Hotels" {
                callGetHotelVoucherAPI()
            } else {
                // Handle other cases
            }
        } else {
            // Handle the case where 'selectedTap' is not found in UserDefaults
        }

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewModel = VocherDetailsViewModel(self)
        hotelViewmodel = HotelVoucherViewModel(self)
    }
    
    func setupUI() {
        navBar.titlelbl.text = "Booking Confirmed"
        navBar.backBtn.addTarget(self, action: #selector(didTapOnBackButton(_:)), for: .touchUpInside)
        setupTV()
        commonTableView.registerTVCells(["BookingConfirmedTVCell",
                                         "EmptyTVCell",
                                         "LabelTVCell",
                                         "ButtonTVCell",
                                         "BCFlightDetailsTVCell",
                                         "BookedTravelDetailsTVCell",
                                         "VoucherHotelDetailsTVCell"])
        
    }
    
    
    
    @objc func didTapOnBackButton(_ sender:UIButton) {
        BASE_URL = BASE_URL1
        guard let vc = DashBoaardTabbarVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        callapibool = true
        present(vc, animated: true)
    }
    
    
    override func btnAction(cell: ButtonTVCell) {
        
        if let selectedTap = defaults.object(forKey: UserDefaultsKeys.dashboardTapSelected) as? String ,selectedTap == "Flights"{
            vocherpdf = "https://provabdevelopment.com/pro_new/mobile/index.php/voucher/flight/\(bookingRefrence)/\(bookingsource)/\(bookingStatus)/show_pdf"
            
        }else {
            vocherpdf = "https://provabdevelopment.com/pro_new/mobile/index.php/voucher/hotel/\(bookingRefrence)/\(bookingsource)/\(bookingStatus)/show_pdf"
        }
        
        downloadAndSavePDF(showpdfurl: vocherpdf)
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.gotoAboutUsVC(title: "Vocher Details", url: self.vocherpdf)
        }
        
    }
    
    
    func gotoAboutUsVC(title:String,url:String) {
        callapibool = false
        guard let vc = AboutUsVC.newInstance.self else {return}
        vc.urlString = url
        vc.titleString = title
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
}


//MARK: - Flight Voucher Deatails
extension BookingConfirmedVC {
    func callGetFlightVoucherAPI() {
        viewModel?.Call_Get_voucher_Details_API(dictParam: [:], url: urlString)
    }
    
    
    
    func vocherdetails(response: VocherModel) {
        BASE_URL = BASE_URL1
        print(" ===== vocherdetails ====== \n \(response)")
        response.data?.booking_details?.forEach({ i in
            bookedDate = i.booked_date ?? ""
            bookingsource = i.booking_source ?? ""
            bookingId = i.booked_by_id ?? ""
            pnrNo = i.pnr ?? ""
            
        })
        
        response.data?.booking_details?.forEach({ j in
            bookingitinerarydetails = j.booking_itinerary_details ?? []
            Customerdetails = j.customer_details ?? []
            
            
            j.booking_transaction_details?.forEach({ i in
                
                bookingRefrence = i.app_reference ?? ""
                bookingStatus = i.status ?? ""
                
                print("bookedDate    \(bookedDate)")
                print("pnrNo      \(pnrNo)")
                print("bookingRefrence   \(bookingRefrence)")
                print("bookingId    \(bookingId)")
                
                DispatchQueue.main.async {
                    self.setupTV()
                }
                
            })
        })
        
    }
    
    
    func setupTV() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Booking Confirmed",
                                 subTitle: bookingId,
                                 text: bookedDate,
                                 buttonTitle: bookingRefrence,
                                 tempText: pnrNo,
                                 cellType:.BookingConfirmedTVCell))
        
        tablerow.append(TableRow(title:"Flight Details",key: "bc",cellType:.LabelTVCell))
        
        
        tablerow.append(TableRow(moreData: bookingitinerarydetails,cellType:.BCFlightDetailsTVCell))
        
        
        
        tablerow.append(TableRow(title:"Passenger Details",key: "bc",cellType:.LabelTVCell))

        tablerow.append(TableRow(moreData:Customerdetails,cellType:.BookedTravelDetailsTVCell))
        tablerow.append(TableRow(height:35,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Thank you for booking with bab safar Your attraction voucher has been shared on the confirmed email.",key: "booked",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Download E - Ticket",key:"booked",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:60,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
}






//MARK: - Hotel Voucher Deatails
extension BookingConfirmedVC {
    
    func callGetHotelVoucherAPI() {
        hotelViewmodel?.CALL_HOTEL_VOUCHER_DETAILS_API(dictParam: [:], url: urlString)
    }
    
    
    func hotelDetails(response: HotelVoucherModel) {
        BASE_URL = BASE_URL1
        
        hbookingDetails = response.data?.booking_details ?? []
        response.data?.booking_details?.forEach({ i in
            bookedDate = i.voucher_date ?? ""
            bookingsource = i.booking_source ?? ""
            bookingId = i.booking_id ?? ""
            pnrNo = "i.pnr ?? "
            
            hItinerary_details = i.itinerary_details ?? []
            hCustomerdetails = i.customer_details ?? []
            
            hotelimg = i.image ?? ""
            hotel_check_in = i.hotel_check_in ?? ""
            hotel_check_out = i.hotel_check_out ?? ""
            hotel_name = i.hotel_name ?? ""
            hotel_address = i.hotel_location ?? ""
            total_rooms = "\(i.total_rooms ?? 0)"
            adult_count = "\(i.adult_count ?? 0)"
            
        })
        
        hItinerary_details.forEach({ i in
            
            bookingRefrence = i.app_reference ?? ""
            bookingStatus = i.status ?? ""
            
        })
        
        
        DispatchQueue.main.async {
            self.setupHpotelTV()
        }
        
    }
    
    
    func setupHpotelTV() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Booking Confirmed",
                                 subTitle: bookingId,
                                 text: bookedDate,
                                 buttonTitle: bookingRefrence,
                                 tempText: pnrNo,
                                 cellType:.BookingConfirmedTVCell))
        
        tablerow.append(TableRow(title:"Hotel Details",cellType:.LabelTVCell))
        
        hbookingDetails.forEach { i in
            
            tablerow.append(TableRow(title:hotel_name,
                                     subTitle: hotel_address,
                                     text: hotel_check_in,
                                     buttonTitle: adult_count,
                                     image:hotelimg,
                                     tempText: hotel_check_out,
                                     tempInfo: total_rooms,
                                     cellType:.VoucherHotelDetailsTVCell))
            
        }
        
        
        
        
        
        tablerow.append(TableRow(title:"Guest Details",cellType:.LabelTVCell))
        tablerow.append(TableRow(moreData:hCustomerdetails,cellType:.BookedTravelDetailsTVCell))
        tablerow.append(TableRow(height:35,cellType:.EmptyTVCell))
        
        tablerow.append(TableRow(title:"Thank you for booking with bab safar Your attraction voucher has been shared on the confirmed email.",key: "booked",cellType:.LabelTVCell))
        
        tablerow.append(TableRow(title:"Download E - Ticket",key:"booked",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:60,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
}




extension BookingConfirmedVC {
    
    
    
    // Function to download and save the PDF
    func downloadAndSavePDF(showpdfurl:String) {
        let urlString = showpdfurl
        
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Download Error: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Invalid Response: \(response.debugDescription)")
                    return
                }
                
                if let pdfData = data {
                    self.savePdfToDocumentDirectory(pdfData: pdfData, fileName: "\(Date())")
                }
            }
            task.resume()
        } else {
            print("Invalid URL: \(urlString)")
        }
    }
    
    // Function to save PDF data to the app's document directory
    func savePdfToDocumentDirectory(pdfData: Data, fileName: String) {
        do {
            let resourceDocPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
            let pdfName = "Babsafar-\(fileName).pdf"
            let destinationURL = resourceDocPath.appendingPathComponent(pdfName)
            try pdfData.write(to: destinationURL)
            
            
        } catch {
            print("Error saving PDF to Document Directory: \(error)")
        }
    }
    
    
    
}



extension BookingConfirmedVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
    }
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            callAPI()
        }
    }
    
    //MARK: - resultnil
    @objc func resultnil() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    
}
