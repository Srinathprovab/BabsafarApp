//
//  HotelBookingConfirmedVC.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit

class AddContactAndGuestDetailsVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    
    
    var tablerow = [TableRow]()
    var checkBool = true
    static var newInstance: AddContactAndGuestDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotels.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AddContactAndGuestDetailsVC
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(addAdultsDetails(notification:)), name: NSNotification.Name("addAdultsDetails"), object: nil)
    }
    
    @objc func addAdultsDetails(notification:NSNotification) {
        commonTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        nav.titlelbl.text = "Booking Confirmed"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        
        commonTableView.backgroundColor = .AppBorderColor
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["TDetailsLoginTVCell","EmptyTVCell","ContactInformationTVCell","AddTravellerTVCell","PriceSummaryTVCell","checkOptionsTVCell","HotelDetailsTVCell"])
        
        setuptv()
        
        
        
    }
    
    
    
    func setuptv() {
        
        tablerow.removeAll()
        
        if defaults.bool(forKey: UserDefaultsKeys.userLoggedIn) == false {
            tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
        }
        tablerow.append(TableRow(title:"Majestic City Retreat Hotel",subTitle: "Bur Dubai, Dubai | 700 m from Al Fahidi Metro Station",text: "26-07-2022",buttonTitle:"1", tempText: "27-07-2022",tempInfo: "1",cellType:.HotelDetailsTVCell))
        
        tablerow.append(TableRow(title:"Guest Details",subTitle: "Total No Of  Guest : 2",key: "hotel",cellType:.AddTravellerTVCell))
        tablerow.append(TableRow(cellType:.ContactInformationTVCell))
        tablerow.append(TableRow(key:"hotel",cellType:.PriceSummaryTVCell))
        tablerow.append(TableRow(title:"i Accept T&C and Privacy Policy",key: "book",cellType:.checkOptionsTVCell))
        
        tablerow.append(TableRow(height:50, bgColor:.AppBorderColor,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
  
    
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    @objc func didTapOnBookNowBtn(_ sender: UIButton) {
        guard let vc = HotelBookingConfirmedVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    override func didTapOnLoginBtn(cell:TDetailsLoginTVCell){
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
        
    }
    
    override func didTapOnAddAdultBtn(cell:AddTravellerTVCell){
        gotoAddTravellerOrGuestVC(str: "hoteladult")
    }
    override func didTapOnAddChildBtn(cell:AddTravellerTVCell){
        gotoAddTravellerOrGuestVC(str: "hotelchild")
    }
    
    override func didTapOnEditAdultBtn(cell:AddTravellerTVCell){
        gotoAddTravellerOrGuestVC(str: "hoteladultedit")
    }
    override func didTapOnEditChildtBtn(cell:AddTravellerTVCell){
        gotoAddTravellerOrGuestVC(str: "hotelchildedit")
    }
    
    func gotoAddTravellerOrGuestVC(str:String) {
        defaults.set(str, forKey: UserDefaultsKeys.addTarvellerDetails)
        guard let vc = AddTravellerDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}

extension AddContactAndGuestDetailsVC {
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5 {
            if let cell = tableView.cellForRow(at: IndexPath(item: 5, section: 0)) as? checkOptionsTVCell {
                if self.checkBool == true {
                    cell.checkImg.image = UIImage(named: "check")
                    self.checkBool = false
                }else {
                    cell.checkImg.image = UIImage(named: "uncheck")
                    self.checkBool = true
                }
                
            }
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let myFooter =  Bundle.main.loadNibNamed("BookNowButtonsTVCell", owner: self, options: nil)?.first as! BookNowButtonsTVCell
        myFooter.bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowBtn(_:)), for: .touchUpInside)
        return myFooter
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
}
