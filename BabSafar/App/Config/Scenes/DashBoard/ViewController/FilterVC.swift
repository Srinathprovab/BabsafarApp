//
//  FilterVC.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit

class FilterVC: BaseTableVC{
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var filterButtonsView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var sortbyBtnView: UIView!
    @IBOutlet weak var sortbyUL: UIView!
    @IBOutlet weak var filterUL: UIView!
    @IBOutlet weak var sortBylbl: UILabel!
    @IBOutlet weak var sortbyBtn: UIButton!
    @IBOutlet weak var filtersBtnView: UIView!
    @IBOutlet weak var filterslbl: UILabel!
    @IBOutlet weak var filtersBtn: UIButton!
    
    
    var refundableTypeArray = ["Refundable ","Non Refundable"]
    var luggageArray = ["Cabin Baggage ","Checked Baggage "]
    var airlinesArray = ["Egypt Air (MS)","Emirates Airlines (EK)","Gulf Air (GF)"]
    var classArray = ["Economy","Permium Economy","Bussiness","First Class"]
    var tablerow = [TableRow]()
    var filterKey = String()
    static var newInstance: FilterVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FilterVC
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupSortByTVCells()
    }
    
    
    func setupUI() {
        
        self.view.backgroundColor = .black.withAlphaComponent(0.3)
        setupViews(v: holderView, radius: 10, color: .WhiteColor)
        holderView.layer.borderColor = UIColor.WhiteColor.cgColor
        setupViews(v: filterButtonsView, radius: 0, color: .WhiteColor)
        filterButtonsView.addBottomBorderWithColor(color: .AppBorderColor, width: 1)
        setupViews(v: sortbyBtnView, radius: 0, color: .WhiteColor)
        setupViews(v: filtersBtnView, radius: 0, color: .WhiteColor)
        setupViews(v: sortbyUL, radius: 0, color: .AppTabSelectColor)
        setupViews(v: filterUL, radius: 0, color: .WhiteColor)
        setupLabels(lbl: sortBylbl, text: "Sort By", textcolor: .AppLabelColor, font: .LatoRegular(size: 18))
        setupLabels(lbl: filterslbl, text: "Filters", textcolor: .SubTitleColor, font: .LatoRegular(size: 18))
        closeBtn.setTitle("", for: .normal)
        sortbyBtn.setTitle("", for: .normal)
        filtersBtn.setTitle("", for: .normal)
        
        commonTableView.registerTVCells(["CheckBoxTVCell","EmptyTVCell","SortbyTVCell","ButtonTVCell","DoubleSliderTVCell"])
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.WhiteColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    func setupFilterTVCells() {
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.DoubleSliderTVCell))

        tablerow.append(TableRow(title:"Refundable Type",data: refundableTypeArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Luggage",data: luggageArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Airlines",data: airlinesArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Class",data: classArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Apply",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func setupSortByTVCells() {
        commonTableView.isScrollEnabled = false
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Price",key: "reset",cellType:.SortbyTVCell))
        tablerow.append(TableRow(title:"Star",key: "no",cellType:.SortbyTVCell))
        tablerow.append(TableRow(title:"Arrival Time",key: "no",cellType:.SortbyTVCell))
        tablerow.append(TableRow(title:"Duration",key: "no",cellType:.SortbyTVCell))
        tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Done",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    override func didTapOnLowtoHighBtn(cell: SortbyTVCell) {
        cell.lowtoHighlbl.textColor = .WhiteColor
        cell.lowtoHighView.backgroundColor = .AppCalenderDateSelectColor
        cell.hightoLowhlbl.textColor = .AppLabelColor
        cell.hightoLowView.backgroundColor = .WhiteColor
    }
    
    override func didTapOnHightoLowBtn(cell: SortbyTVCell) {
        cell.lowtoHighlbl.textColor = .AppLabelColor
        cell.lowtoHighView.backgroundColor = .WhiteColor
        cell.hightoLowhlbl.textColor = .WhiteColor
        cell.hightoLowView.backgroundColor = .AppCalenderDateSelectColor
    }
    
    override func didTapOnResetSortbyBtn(cell:SortbyTVCell){
        if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
            resetSortBy(cell: cell1)
        }
        if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
            resetSortBy(cell: cell2)
        }
        if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
            resetSortBy(cell: cell3)
        }
        if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
            resetSortBy(cell: cell4)
        }
        
    }
    
    func resetSortBy(cell:SortbyTVCell) {
        
        cell.lowtoHighlbl.textColor = .AppLabelColor
        cell.lowtoHighView.backgroundColor = .WhiteColor
        cell.hightoLowhlbl.textColor = .AppLabelColor
        cell.hightoLowView.backgroundColor = .WhiteColor
    }
    
    
    override func btnAction(cell: ButtonTVCell) {
        if filterKey == "filter" {
            print(filterKey)
        }else {
            print(filterKey)
        }
    }
    
    @IBAction func didTapOnCloseBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    

    @IBAction func didTapOnSortByBtn(_ sender: Any) {
        filterKey = "sortby"
        sortBylbl.textColor = .AppTabSelectColor
        sortbyUL.backgroundColor = .AppTabSelectColor
        filterslbl.textColor = .SubTitleColor
        filterUL.backgroundColor = .WhiteColor
        setupSortByTVCells()
    }
    
    @IBAction func didTapOnFiltersBtn(_ sender: Any) {
        filterKey = "filter"
        sortBylbl.textColor = .SubTitleColor
        sortbyUL.backgroundColor = .WhiteColor
        filterslbl.textColor = .AppTabSelectColor
        filterUL.backgroundColor = .AppTabSelectColor
        setupFilterTVCells()
    }
}
