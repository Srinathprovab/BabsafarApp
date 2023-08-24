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
