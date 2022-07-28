//
//  AddTravellerDetailsVC.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit

class AddTravellerDetailsVC: BaseTableVC {
    
    
    @IBOutlet weak var navBar: NavBar!
    
    static var newInstance: AddTravellerDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AddTravellerDetailsVC
        return vc
    }
    var tablerow = [TableRow]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupTV()
    }
    
    
    func setupUI() {
        navBar.titlelbl.text = "Traveller Details"
        navBar.backBtn.addTarget(self, action: #selector(didTapOnBackButton(_:)), for: .touchUpInside)
    }
    
    func setupTV() {
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["TextfieldTVCell","DropDownTVCell","LabelTVCell","EmptyTVCell","SelectGenderTVCell"])
        tablerow.removeAll()
        
        tablerow.append(TableRow(key:"gender",cellType:.SelectGenderTVCell))
        tablerow.append(TableRow(title:"Frist Name",subTitle: "Frist Name",key: "email",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Last Name",subTitle: "Last Name",key: "email",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Nationality",subTitle: "Nationality",image: "downarrow",cellType:.DropDownTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Travel document*",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Frist Name",subTitle: "Frist Name",key: "email",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Last Name",subTitle: "Last Name",key: "email",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Nationality",subTitle: "Nationality",image: "downarrow",cellType:.DropDownTVCell))
        tablerow.append(TableRow(height:15,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Nationality",subTitle: "Nationality",image: "downarrow",cellType:.DropDownTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tablerow.append(TableRow(key:"save",cellType:.SelectGenderTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))

        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackButton(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    override func didTapOnDropDownBtn(cell:DropDownTVCell){
        print("didTapOnDropDownBtn")
    }
    
    
    
    override func didSelectMaleRadioBtn(cell: SelectGenderTVCell) {
        cell.maleRadioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal)
        cell.femaleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
    }
    
    override func didSelectOnFemaleBtn(cell: SelectGenderTVCell) {
        cell.maleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        cell.femaleRadioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    override func didTapOnSaveBtn(cell: SelectGenderTVCell) {
        print("didTapOnSaveBtn")
    }
    
    
    
    
}
