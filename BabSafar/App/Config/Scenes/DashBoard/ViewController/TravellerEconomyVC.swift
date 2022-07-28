//
//  TravellerEconomyVC.swift
//  AirportProject
//
//  Created by Codebele 09 on 26/06/22.
//

import UIKit

class TravellerEconomyVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    
    var tableRow = [TableRow]()
    var count = 0
    static var newInstance: TravellerEconomyVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? TravellerEconomyVC
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTV()
    }
    
    func setupTV(){
        
        self.view.backgroundColor = .black.withAlphaComponent(0.3)
        holderView.backgroundColor = .black.withAlphaComponent(0.3)
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["RadioButtonTVCell","TravellerEconomyTVCell","LabelTVCell","EmptyTVCell","ButtonTVCell"])
        tableRow.removeAll()
        
        
        tableRow.append(TableRow(title:"Add Travellers ",key: "showbtn",cellType:.LabelTVCell))
        tableRow.append(TableRow(title:"Adults",subTitle: "From 12 yeras old",cellType:.TravellerEconomyTVCell))
        tableRow.append(TableRow(title:"Children",subTitle: "2 - 11",cellType:.TravellerEconomyTVCell))
        tableRow.append(TableRow(title:"Infants",subTitle: "From 12 yeras old",cellType:.TravellerEconomyTVCell))
        tableRow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tableRow.append(TableRow(title:"Select Class",cellType:.LabelTVCell))
        tableRow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tableRow.append(TableRow(title:"Economy",cellType:.RadioButtonTVCell))
        tableRow.append(TableRow(title:"Premium Economy",cellType:.RadioButtonTVCell))
        tableRow.append(TableRow(title:"First",cellType:.RadioButtonTVCell))
        tableRow.append(TableRow(title:"Business",cellType:.RadioButtonTVCell))
        tableRow.append(TableRow(title:"Done",cellType:.ButtonTVCell))
        tableRow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = tableRow
        commonTableView.reloadData()
        
    }
    
    
    override func didTapOnDecrementButton(cell: TravellerEconomyTVCell) {
        
        if cell.count > 0 {
            cell.count -= 1
            cell.countlbl.text = "\(cell.count)"
        }
        print(cell.count)
    }
    
    override func didTapOnIncrementButton(cell: TravellerEconomyTVCell) {
        if cell.count >= 0 {
            cell.count += 1
            cell.countlbl.text = "\(cell.count)"
        }
        
        print(cell.count)
    }
    
    
    
    override func didTapOnCloseBtn(cell: LabelTVCell) {
        self.dismiss(animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RadioButtonTVCell {
            cell.radioImg.image = UIImage(named: "radioSelected")
            print(cell.titlelbl.text)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RadioButtonTVCell {
            cell.radioImg.image = UIImage(named: "radioUnselected")
        }
    }
    
    
    
    override func btnAction(cell: ButtonTVCell) {
        print("button tap ...")
    }
}


