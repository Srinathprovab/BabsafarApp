//
//  MultiCityTVCell.swift
//  BabSafar
//
//  Created by MA673 on 28/07/22.
//

import UIKit

protocol MultiCityTVCellDelegate {
    func addEconomyBtnAction(cell: MultiCityTVCell)
    func didTapOnairlineBtnAction(cell: MultiCityTVCell)
    func didTapOntimeReturnJourneyBtnAction(cell: MultiCityTVCell)
    func didTapOntimeOutwardJourneyBtnAction(cell: MultiCityTVCell)
    func didTapOnFromCityBtn(cell: MultiCityTVCell)
    func didTapOnToCityBtn(cell: MultiCityTVCell)
    func didTapOnDateBtn(cell: MultiCityTVCell)
    func addTraverllersBtnAction(cell: MultiCityTVCell)
    func addClassBtnAction(cell: MultiCityTVCell)
}


class MultiCityTVCell: TableViewCell,ButtonCVCellDelegate,MultiCityCVCellDelegate {
   
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var multiCityTripCV: UICollectionView!
    @IBOutlet weak var cvHeight: NSLayoutConstraint!
    @IBOutlet weak var economyView: UIView!
    @IBOutlet weak var economylbl: UILabel!
    @IBOutlet weak var economyValuelbl: UILabel!
    @IBOutlet weak var dropdownImg: UIImageView!
    @IBOutlet weak var optionView: UIView!
    @IBOutlet weak var optionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var timeOutwardJourneyView: UIView!
    @IBOutlet weak var timeOutwardJourneylbl: UILabel!
    @IBOutlet weak var timeOutJourneyValuelbl: UILabel!
    @IBOutlet weak var timeReturnJourneyView: UIView!
    @IBOutlet weak var timeReturnJourneylbl: UILabel!
    @IBOutlet weak var timeReturnJourneyValuelbl: UILabel!
    @IBOutlet weak var airlineView: UIView!
    @IBOutlet weak var airlinelbl: UILabel!
    @IBOutlet weak var airlineValuelbl: UILabel!
    @IBOutlet weak var moresearchBtn: UIButton!
    @IBOutlet weak var addTraverllersView: UIView!
    @IBOutlet weak var addTraverllerslbl: UILabel!
    @IBOutlet weak var addTraverllersValuelbl: UILabel!
    @IBOutlet weak var addTraverllersBtn: UIButton!
    @IBOutlet weak var addClassView: UIView!
    @IBOutlet weak var addClasslbl: UILabel!
    @IBOutlet weak var addClassValuelbl: UILabel!
    @IBOutlet weak var addClassBtn: UIButton!
    
    
    //    @IBOutlet weak var multiCityTripTV: UITableView!
    //    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    
    var delegate:MultiCityTVCellDelegate?
    var moreoptionBool = true
    var count = 0
    var city = String()
    var city1 = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        addTraverllersValuelbl.text = defaults.string(forKey: UserDefaultsKeys.mtravellerDetails) ?? "Add Details"
        addClassValuelbl.text = defaults.string(forKey: UserDefaultsKeys.mselectClass) ?? "Add Details"
        updateheight()
        
        
    }
    
    
    func setupUI() {
        
        holderView.backgroundColor = .clear
        //  setupViews(v: holderView, radius: 5, color: .clear)
        contentView.backgroundColor = .clear
        
        optionView.backgroundColor = .WhiteColor
        optionView.isHidden = true
        optionViewHeight.constant = 0
        
        
        //  setupViews(v: economyView, radius: 4, color: .AppHolderViewColor)
        setupLabels(lbl: economylbl, text: "Travellers &  class", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: economyValuelbl, text: "\(defaults.string(forKey: UserDefaultsKeys.mtravellerDetails) ?? "ADD Travellers & Class")", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        dropdownImg.image = UIImage(named: "downarrow")
        setupViews(v: timeOutwardJourneyView, radius: 4, color: .WhiteColor)
        setupViews(v: timeReturnJourneyView, radius: 4, color: .WhiteColor)
        setupViews(v: airlineView, radius: 4, color: .WhiteColor)
        
        setupLabels(lbl: timeOutwardJourneylbl, text: "Time Of Outward Journey", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: timeOutJourneyValuelbl, text: "All Times", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: timeReturnJourneylbl, text: "Time Of Return Journey", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: timeReturnJourneyValuelbl, text: "All Times", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: airlinelbl, text: "Airline", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: airlineValuelbl, text: "Airline", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        moresearchBtn.setTitle("+ More search options", for: .normal)
        
        setupViews(v: addTraverllersView, radius: 4, color: .WhiteColor)
        setupViews(v: addClassView, radius: 4, color: .WhiteColor)
        setuplabels(lbl: addTraverllerslbl, text: "Add Travellers", textcolor: .AppLabelColor, font: .LatoLight(size: 14), align: .left)
        setuplabels(lbl: addClasslbl, text: "Add Class", textcolor: .AppLabelColor, font: .LatoLight(size: 14), align: .left)
        
        setuplabels(lbl: addTraverllersValuelbl, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16), align: .left)
        setuplabels(lbl: addClassValuelbl, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16), align: .left)
        
        addTraverllersBtn.setTitle("", for: .normal)
        addClassBtn.setTitle("", for: .normal)
        dropdownImg.isHidden = true
        economyValuelbl.isHidden = true
           setupCV()
       // multiCityTripCV.isHidden = true
        //  setupTV()
    }
    
    func setupCV() {
        let nib = UINib(nibName: "MultiCityCVCell", bundle: nil)
        multiCityTripCV.register(nib, forCellWithReuseIdentifier: "cell")
        let nib1 = UINib(nibName: "ButtonCVCell", bundle: nil)
        multiCityTripCV.register(nib1, forCellWithReuseIdentifier: "cell1")
        multiCityTripCV.delegate = self
        multiCityTripCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 50, height: 60)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        multiCityTripCV.collectionViewLayout = layout
        multiCityTripCV.backgroundColor = .clear
        multiCityTripCV.layer.cornerRadius = 4
        multiCityTripCV.clipsToBounds = true
        multiCityTripCV.showsHorizontalScrollIndicator = false
        
    }
    
    //    func setupTV() {
    //        multiCityTripTV.register(UINib(nibName: "MultiCityFromTVCell", bundle: nil), forCellReuseIdentifier: "cell2")
    //        multiCityTripTV.delegate = self
    //        multiCityTripTV.dataSource = self
    //        multiCityTripTV.separatorStyle = .none
    //        multiCityTripTV.tableFooterView = UIView()
    //        multiCityTripTV.isScrollEnabled = false
    //        multiCityTripTV.allowsMultipleSelection = true
    //    }
    
    
    func updateheight() {
       
        if fromCityNameArray.count == 5 {
            cvHeight.constant = CGFloat(80 * (fromCityNameArray.count))
        }else {
            cvHeight.constant = CGFloat(80 * (fromCityNameArray.count + 1))
        }
        
        multiCityTripCV.reloadData()
    }
    
    //    func updateheight() {
    //        tvHeight.constant = CGFloat(90 * (fromCityNameArray.count))
    //        if fromCityNameArray.count == 5 {
    //            tvHeight.constant = CGFloat(90 * (fromCityNameArray.count))
    //        }
    //        multiCityTripTV.reloadData()
    //    }
    
    
    
    func didTapOnAddCityBtn(cell: ButtonCVCell) {
        count += 1
        
        if fromCityNameArray.count == 5 {
            multiCityTripCV.deleteItems(at: [IndexPath(item: 5, section: 0)])
            multiCityTripCV.reloadData()
            
            //                multiCityTripTV.deleteRows(at: [IndexPath(item: 5, section: 0)], with: .automatic)
            //                multiCityTripTV.reloadData()
            
        }else {
            
            fromCityNameArray.append("Origen")
            fromCityShortNameArray.append("Origen")
            toCityNameArray.append("Destination")
            toCityShortNameArray.append("Destination")
            depatureDatesArray.append(" Date")
            fromlocidArray.append("")
            tolocidArray.append("")
            fromCityArray.append("")
            toCityArray.append("")
            
            DispatchQueue.main.async {[self] in
                updateheight()
                NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
            }
            
        }
        
    }
    
    
    func didtapOnSwapCityBtn(cell: MultiCityCVCell) {
        city = cell.fromCityname.text ?? ""
        city1 = cell.toCityNamelbl.text ?? ""
        cell.fromCityname.text = city1
        cell.toCityNamelbl.text = city
    }
    
    func didTapOnDeleteMultiCityTrip(cell: MultiCityCVCell) {
        
        fromCityNameArray.remove(at: cell.cancelBtn.tag)
        fromCityShortNameArray.remove(at: cell.cancelBtn.tag)
        toCityNameArray.remove(at: cell.cancelBtn.tag)
        toCityShortNameArray.remove(at: cell.cancelBtn.tag)
        
        //---------------
        
        depatureDatesArray.remove(at: cell.cancelBtn.tag)
        fromlocidArray.remove(at: cell.cancelBtn.tag)
        tolocidArray.remove(at: cell.cancelBtn.tag)
        fromCityArray.remove(at: cell.cancelBtn.tag)
        toCityArray.remove(at: cell.cancelBtn.tag)
        
        addmulticityCount -= 1
        //---------------
        
        multiCityTripCV.deleteItems(at: [IndexPath(item: cell.cancelBtn.tag, section: 0)])
        DispatchQueue.main.async {[self] in
            
            if fromCityNameArray.count < 5 {
                if let cell = multiCityTripCV.cellForItem(at: IndexPath(item: (fromCityNameArray.count), section: 0)) as? ButtonCVCell {
                    cell.isHidden = false
                    cell.holderViewHeight.constant = 60
                }
            }
        }
        
        
        updateheight()
        NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.7
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    @IBAction func addEconomyBtnAction(_ sender: Any) {
        delegate?.addEconomyBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnmoreOptionsBtn(_ sender: Any) {
        
        if moreoptionBool == true {
            optionView.isHidden = false
            optionViewHeight.constant = 200
            moresearchBtn.setTitle("- Advanced Search Options", for: .normal)
            // moresearchBtn.setImage( UIImage(systemName: "minus")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppTabSelectColor), for: .normal)
            
            moreoptionBool = false
        }else {
            optionView.isHidden = true
            optionViewHeight.constant = 0
            moresearchBtn.setTitle("+ More search options", for: .normal)
            //moresearchBtn.setImage( UIImage(systemName: "plus")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppTabSelectColor), for: .normal)
            
            moreoptionBool = true
        }
        NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
    }
    
    
    func didTapOnFromCityBtn(cell: MultiCityCVCell) {
        print(cell.fromCityBtn.tag)
        defaults.set(cell.fromCityBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnFromCityBtn(cell: self)
    }
    
    func didTapOnToCityBtn(cell: MultiCityCVCell) {
        print(cell.toCityBtn.tag)
        defaults.set(cell.fromCityBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnToCityBtn(cell: self)
    }
    
    func didTapOnDateBtn(cell: MultiCityCVCell) {
        print(cell.dateBtn.tag)
        defaults.set(cell.fromCityBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnDateBtn(cell: self)
    }
    
    
    @IBAction func didTapOntimeOutwardJourneyBtnAction(_ sender: Any) {
        delegate?.didTapOntimeOutwardJourneyBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOntimeReturnJourneyBtnAction(_ sender: Any) {
        delegate?.didTapOntimeReturnJourneyBtnAction(cell: self)
    }
    
    @IBAction func didTapOnairlineBtnAction(_ sender: Any) {
        delegate?.didTapOnairlineBtnAction(cell: self)
    }
    
    
    
    @IBAction func addTraverllersBtnAction(_ sender: Any) {
        delegate?.addTraverllersBtnAction(cell: self)
    }
    
    
    
    @IBAction func addClassBtnAction(_ sender: Any) {
        delegate?.addClassBtnAction(cell: self)
    }
    
    
    
    func didtapOnSwapCityBtn(cell: MultiCityFromTVCell) {
        city = cell.fromCityname.text ?? ""
        city1 = cell.toCityNamelbl.text ?? ""
        cell.fromCityname.text = city1
        cell.toCityNamelbl.text = city
    }
    
    
    
    
    func didTapOnDeleteMultiCityTrip(cell: MultiCityFromTVCell) {
        
        
        
        fromCityNameArray.remove(at: cell.cancelBtn.tag)
        fromCityShortNameArray.remove(at: cell.cancelBtn.tag)
        toCityNameArray.remove(at: cell.cancelBtn.tag)
        toCityShortNameArray.remove(at: cell.cancelBtn.tag)
        
        //---------------
        
        depatureDatesArray.remove(at: cell.cancelBtn.tag)
        fromlocidArray.remove(at: cell.cancelBtn.tag)
        tolocidArray.remove(at: cell.cancelBtn.tag)
        fromCityArray.remove(at: cell.cancelBtn.tag)
        toCityArray.remove(at: cell.cancelBtn.tag)
        
        //---------------
        
        
        
        // multiCityTripTV.deleteRows(at: [IndexPath(item: cell.cancelBtn.tag, section: 0)], with: .automatic)
        if fromCityNameArray.count < 5 {
            
        }
        
        
        updateheight()
        NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
    }
    
    func didTapOnFromCityBtn(cell: MultiCityFromTVCell) {
        defaults.set(cell.fromCityBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnFromCityBtn(cell: self)
    }
    
    func didTapOnToCityBtn(cell: MultiCityFromTVCell) {
        defaults.set(cell.fromCityBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnToCityBtn(cell: self)
    }
    
    func didTapOnDateBtn(cell: MultiCityFromTVCell) {
        defaults.set(cell.fromCityBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnDateBtn(cell: self)
    }
    
}


extension MultiCityTVCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fromCityNameArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        if indexPath.row == fromCityNameArray.count {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? ButtonCVCell {
                cell.delegate = self
                if fromCityNameArray.count == 5 {
                    cell.isHidden = true
                    cell.holderViewHeight.constant = 0
                }
                commonCell = cell
            }
        }else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MultiCityCVCell {
                
                cell.delegate = self
                
                
                cell.cancelBtn.tag = indexPath.row
                cell.fromCityBtn.tag = indexPath.row
                cell.toCityBtn.tag = indexPath.row
                cell.dateBtn.tag = indexPath.row
                
                cell.fromCityname.text = fromCityShortNameArray[indexPath.row]
                cell.toCityNamelbl.text = toCityShortNameArray[indexPath.row]
                cell.datelbl.text = depatureDatesArray[indexPath.row]
                
                
                //                cell.fromTF.text = fromCityNameArray[indexPath.row]
                //                cell.toTF.text = toCityNameArray[indexPath.row]
                //                cell.datelbl.text = depatureDatesArray[indexPath.row]
                
                if indexPath.row == 0 && indexPath.row == 1{
                    cell.cancelBtnView.isHidden = true
                }
                
                if indexPath.row != 0 && indexPath.row != 1{
                    cell.cancelBtnView.isHidden = false
                }
                
                commonCell = cell
            }
        }
        
        return commonCell
    }
    
}





extension MultiCityTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fromCityNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? MultiCityFromTVCell {
            
            
            //      cell.delegate = self
            
            
            cell.cancelBtn.tag = indexPath.row
            cell.fromCityBtn.tag = indexPath.row
            cell.toCityBtn.tag = indexPath.row
            cell.dateBtn.tag = indexPath.row
            
            cell.fromCityname.text = fromCityShortNameArray[indexPath.row]
            cell.toCityNamelbl.text = toCityShortNameArray[indexPath.row]
            cell.datelbl.text = depatureDatesArray[indexPath.row]
            
//            cell.fromTF.text = fromCityShortNameArray[indexPath.row]
//            cell.toTF.text = toCityShortNameArray[indexPath.row]
//            cell.datelbl.text = depatureDatesArray[indexPath.row]
            
            if indexPath.row == 0 {
                cell.cancelBtnView.isHidden = true
                
            }
            if indexPath.row != 0 {
                cell.cancelBtnView.isHidden = false
            }
            
            c = cell
        }
        
        return c
    }
    
}




