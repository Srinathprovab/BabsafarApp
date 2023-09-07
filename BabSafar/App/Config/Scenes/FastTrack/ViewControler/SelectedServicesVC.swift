//
//  SelectedServicesVC.swift
//  BabSafar
//
//  Created by FCI on 24/08/23.
//

import UIKit

class SelectedServicesVC: BaseTableVC {
    
    
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var addArrivalView: BorderedView!
    @IBOutlet weak var addArrivallbl: UILabel!
    
    
    
    var tablerow = [TableRow]()
    var airportName = String()
    var terminal = String()
    var logoImg = String()
    var serviceType = String()
    static var newInstance: SelectedServicesVC? {
        let storyboard = UIStoryboard(name: Storyboard.FastTrack.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectedServicesVC
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
        if callapibool == true {
            setupTV()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        commonTableView.registerTVCells(["SelectedServicesTVCell"])
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        commonTableView.isScrollEnabled = false
        
    }
    
    func setHeight(){
        if quickServiceA.count == 1 {
            addArrivalView.isHidden = false
            tvHeight.constant = 255
        }else {
            addArrivalView.isHidden = true
            tvHeight.constant = CGFloat(255 * quickServiceA.count)
        }
    }
    
    
    func setupTV() {
        tablerow.removeAll()
        setHeight()
        
        quickServiceA.forEach { i in
            
            if i.serviceType == "dep" {
                serviceType = "arrival"
                addArrivallbl.text = "Add Arrival Service"
                tablerow.append(TableRow(title:i.airportname,
                                         subTitle: i.title,
                                         key: "hideprice",
                                         image: i.logoimg,
                                         cellType:.SelectedServicesTVCell))
            }else {
                serviceType = "dep"
                addArrivallbl.text = "Add Departure Service"
                tablerow.append(TableRow(title:i.airportname,
                                         subTitle: i.title,
                                         key: "hideprice",
                                         image: i.logoimg,
                                         cellType:.SelectedServicesTVCell))
            }
            
            
        }
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    override func didTapOnCancelCardBtnAction(cell: SelectedServicesTVCell) {
        // Assuming you have the index of the QuickService you want to remove, for example, 'indexToRemove'
        
        let index = commonTableView.indexPath(for: cell)
        let indexToRemove = index?.row ?? 0
        
        if indexToRemove >= 0 && indexToRemove < quickServiceA.count {
            quickServiceA.remove(at: indexToRemove)
        }
        
        if quickServiceA.count > 0 {
            DispatchQueue.main.async {
                self.setupTV()
            }
        }else {
            NotificationCenter.default.post(name: NSNotification.Name("closeService"), object: serviceType)
            dismiss(animated: true)
        }
        
        
    }
    
    
    
    
    @IBAction func closeBtnAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("closeService"), object: serviceType)
        dismiss(animated: true)
    }
    
    
    //MARK: - didTapOnAddArrivalServiceBtnAction
    
    @IBAction func didTapOnAddArrivalServiceBtnAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("addservice"), object: serviceType)
        dismiss(animated: false)
    }
    
    
    //MARK: - didTapOnCheckOutBtnAction
    
    @IBAction func didTapOnCheckOutBtnAction(_ sender: Any) {
        gotoFBookingDetailsVC()
    }
    
    
    func gotoFBookingDetailsVC(){
        callapibool = true
        guard let vc = FBookingDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
}


extension SelectedServicesVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(closefrombookingdetails), name: Notification.Name("closefrombookingdetails"), object: nil)

    }
    
  
    
    @objc func closefrombookingdetails() {
        
        DispatchQueue.main.async {[self] in
            setupTV()
        }
    }
    
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            setupTV()
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
