//
//  BookingConfirmedVC.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit
import FreshchatSDK

class BookingConfirmedVC: BaseTableVC, VocherDetailsViewModelDelegate {
    
    
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var chatBtnView: UIView!
    
    var lastContentOffset: CGFloat = 0
    var viewModel:VocherDetailsViewModel?
    var urlString = String()
    var tablerow = [TableRow]()
    var booking_itinerary_details = [Booking_itinerary_details]()
    var Customerdetails = [Customer_details]()
    var bookingsource = String()
    var bookingStatus = String()
    
    
    static var newInstance: BookingConfirmedVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingConfirmedVC
        return vc
    }
    
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        callapibool = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        chatBtnView.isHidden = true
        if screenHeight < 835 {
            navHeight.constant = 90
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        
        callAPI()
    }
    
    
    func callAPI() {
        BASE_URL = ""
        viewModel?.Call_Get_voucher_Details_API(dictParam: [:], url: urlString)
    }
    
    func vocherdetails(response: VocherModel) {
        print(" ===== vocherdetails ====== \n \(response)")
        chatBtnView.isHidden = false
        response.data?.booking_details?.forEach({ i in
            bookedDate = i.booked_date ?? ""
            bookingsource = i.booking_source ?? ""
            bookingId = i.booked_by_id ?? ""
            pnrNo = i.pnr ?? ""
            
        })
        
        response.data?.booking_details?.forEach({ j in
            booking_itinerary_details = j.booking_itinerary_details ?? []
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
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    @objc func reloadTV() {
        commonTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewModel = VocherDetailsViewModel(self)
    }
    
    func setupUI() {
        navBar.titlelbl.text = "Booking Confirmed"
        navBar.backBtn.addTarget(self, action: #selector(didTapOnBackButton(_:)), for: .touchUpInside)
        setupTV()
        commonTableView.registerTVCells(["BookingConfirmedTVCell","EmptyTVCell","LabelTVCell","ButtonTVCell","VocherFlightDetailsTVCell","BookedTravelDetailsTVCell"])
        
    }
    
    
    func setupTV() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Booking Confirmed",
                                 subTitle: bookingId,
                                 text: bookedDate,
                                 buttonTitle: bookingRefrence,
                                 tempText: pnrNo,
                                 cellType:.BookingConfirmedTVCell))
        
        tablerow.append(TableRow(title:"Flight details",cellType:.LabelTVCell))
        
        
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                
                RTFlightList?[flightSelectedIndex].forEach({ j in
                    j.flight_details?.summary?.forEach({ i in
                        tablerow.append(TableRow(fromTime:i.origin?.time,
                                                 toTime: i.destination?.time,
                                                 fromCity:"\(i.origin?.loc ?? "")",
                                                 fromDate: i.origin?.date,
                                                 toCity: i.destination?.loc,
                                                 toDate: i.destination?.date,
                                                 noosStops: "\(i.no_of_stops ?? 0)",
                                                 airlineslogo: i.operator_image,
                                                 airlinesname:i.operator_name,
                                                 airlinesCode: "(\(i.operator_code ?? "")\(i.flight_number ?? "")",
                                                 price: totalprice,
                                                 travelTime: i.duration,
                                                 cellType:.VocherFlightDetailsTVCell))
                    })
                })
                
                
            }else if journeyType == "circle"{
                
                RTFlightList?[flightSelectedIndex].forEach({ j in
                    j.flight_details?.summary?.forEach({ i in
                        tablerow.append(TableRow(fromTime:i.origin?.time,
                                                 toTime: i.destination?.time,
                                                 fromCity:"\(i.origin?.loc ?? "")",
                                                 fromDate: i.origin?.date,
                                                 toCity: i.destination?.loc,
                                                 toDate: i.destination?.date,
                                                 noosStops: "\(i.no_of_stops ?? 0)",
                                                 airlineslogo: i.operator_image,
                                                 airlinesname:i.operator_name,
                                                 airlinesCode: "(\(i.operator_code ?? "")\(i.flight_number ?? "")",
                                                 price: totalprice,
                                                 travelTime: i.duration,
                                                 cellType:.VocherFlightDetailsTVCell))
                    })
                })
                
                
                
                
                
            }else {
                
                
            }
        }
        
        
   
        tablerow.append(TableRow(title:"Traveller Details",cellType:.LabelTVCell))
        tablerow.append(TableRow(moreData:Customerdetails,cellType:.BookedTravelDetailsTVCell))
        tablerow.append(TableRow(height:35,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Thank you for booking with bab safar Your attraction voucher has been shared on the confirmed email.",key: "booked",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Download E - Ticket",key:"booked",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:60,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    @objc func didTapOnBackButton(_ sender:UIButton) {
        BASE_URL = BASE_URL1
        guard let vc = DashBoaardTabbarVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.selectedIndex = 0
        present(vc, animated: true)
    }
    
    
    override func btnAction(cell: ButtonTVCell) {
        
        let vocherpdf = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/voucher/flight/\(bookingRefrence)/\(bookingsource)/\(bookingStatus)/show_pdf"
        
        
        DispatchQueue.main.async {
            if let url = URL(string: vocherpdf) {
                UIImageWriteToSavedPhotosAlbum(self.drawPDFfromURL(url: url) ?? UIImage(), nil, nil, nil)
            }
            
            DispatchQueue.main.async {
                self.gotoAboutUsVC(title: "Vocher Details", url: vocherpdf)
            }
        }
        
    }
    
    
    func drawPDFfromURL(url: URL) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else { return nil }
        guard let page = document.page(at: 1) else { return nil }
        
        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)
            
            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            
            ctx.cgContext.drawPDFPage(page)
        }
        
        return img
    }
    
    
    func gotoAboutUsVC(title:String,url:String) {
        guard let vc = AboutUsVC.newInstance.self else {return}
        vc.urlString = url
        vc.titleString = title
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    
    @IBAction func didTapOnShowChatWindow(_ sender: Any) {
        Freshchat.sharedInstance().showConversations(self)
    }
    
    @IBAction func didTapOnMoveScrrenToTopBtn(_ sender: Any) {
        commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        self.hiddenView.isHidden = true
    }
    
    
    
   
    
    
    //MARK: - scrollViewDidScroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if scrollView.contentOffset.y > self.lastContentOffset {
                // scrolling down
                if self.hiddenView.alpha == 1 {
                    UIView.animate(withDuration: 0.3) {
                        self.hiddenView.alpha = 0
                        self.hiddenView.isHidden = true
                    }
                }
            } else if scrollView.contentOffset.y < self.lastContentOffset {
                // scrolling up
                if self.hiddenView.alpha == 0 {
                    UIView.animate(withDuration: 0.3) {
                        self.hiddenView.alpha = 1
                        self.hiddenView.isHidden = false
                    }
                }
            }
            self.lastContentOffset = scrollView.contentOffset.y
        }
    
    
}
