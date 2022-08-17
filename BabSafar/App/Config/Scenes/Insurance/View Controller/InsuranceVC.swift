//
//  InsuranceVC.swift
//  BabSafar
//
//  Created by MA673 on 29/07/22.
//

import UIKit

class InsuranceVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    
    
    var tablerow = [TableRow]()
    static var newInstance: InsuranceVC? {
        let storyboard = UIStoryboard(name: Storyboard.Insurance.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? InsuranceVC
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        nav.titlelbl.text = "Insurance"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["ButtonTVCell","CommonFromCityTVCell","EmptyTVCell"])
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        commonTableView.layer.borderWidth = 1
        commonTableView.layer.borderColor = UIColor.AppBorderColor.cgColor
        setuptv()
    }
    
    
    func setuptv() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Travelling From",subTitle: "Dubai ",key:"dual1", image: "",cellType:.CommonFromCityTVCell))
        tablerow.append(TableRow(title:"Travelling To",subTitle: "kuwait ",key:"dual1", image: "",cellType:.CommonFromCityTVCell))
        tablerow.append(TableRow(title:"Trip Date",subTitle: "26-07-2022",key:"dual", text:"End Date", tempText: "28-07-2022",cellType:.CommonFromCityTVCell))
        tablerow.append(TableRow(title:"No. Of People",subTitle: "1 Adults ",key:"dual1", image: "downarrow",cellType:.CommonFromCityTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Search Flights",cellType:.ButtonTVCell))

        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    override func viewBtnAction(cell: CommonFromCityTVCell) {
        print(cell.subtitlelbl.text as Any)
    }
    
    override func didTapOnDual1Btn(cell:CommonFromCityTVCell){
        print(cell.dual1lbl2.text)
    }
    override func didTapOnDual2Btn(cell:CommonFromCityTVCell){
        print(cell.dual2lbl2.text)
    }
    
}
