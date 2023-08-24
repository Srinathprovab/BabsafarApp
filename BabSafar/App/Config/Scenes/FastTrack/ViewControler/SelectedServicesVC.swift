//
//  SelectedServicesVC.swift
//  BabSafar
//
//  Created by FCI on 24/08/23.
//

import UIKit

class SelectedServicesVC: BaseTableVC {
    
    
    var tablerow = [TableRow]()
    var airportName = String()
    var terminal = String()
    var logoImg = String()
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
        commonTableView.isScrollEnabled = false
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
    }
    
    
    func setupTV() {
        tablerow.removeAll()
        tablerow.append(TableRow(title:airportName,
                                 subTitle: terminal,
                                 key: "hide",
                                 image: logoImg,
                                 cellType:.SelectedServicesTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - didTapOnChangeSelectionBtnAction SelectedServicesTVCell
    override func didTapOnChangeSelectionBtnAction(cell: SelectedServicesTVCell) {
        dismiss(animated: false)
    }
    
    //MARK: - didTapOnAddArrivalServiceBtnAction SelectedServicesTVCell
    override func didTapOnAddArrivalServiceBtnAction(cell: SelectedServicesTVCell) {
        print("didTapOnAddArrivalServiceBtnAction")
    }
    
    //MARK: - didTapOnCheckOutBtnAction SelectedServicesTVCell
    override func didTapOnCheckOutBtnAction(cell: SelectedServicesTVCell) {
        print("didTapOnCheckOutBtnAction")
    }
    
    @IBAction func closeBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}


extension SelectedServicesVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
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
