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
    
    var nameArray = ["1","2"]
    var delegate:MultiCityTVCellDelegate?
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
        
    }
    
    func setupUI() {
        
        optionView.backgroundColor = .WhiteColor
        optionView.isHidden = true
        optionViewHeight.constant = 0
        holderView.backgroundColor = .WhiteColor
        setupViews(v: economyView, radius: 4, color: .AppHolderViewColor)
        setupLabels(lbl: economylbl, text: "Travellers &  class", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: economyValuelbl, text: "1 Adult, Economy", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        dropdownImg.image = UIImage(named: "downarrow")
        setupViews(v: timeOutwardJourneyView, radius: 4, color: .AppHolderViewColor)
        setupViews(v: timeReturnJourneyView, radius: 4, color: .AppHolderViewColor)
        setupViews(v: airlineView, radius: 4, color: .AppHolderViewColor)
        
        setupLabels(lbl: timeOutwardJourneylbl, text: "Time Of Outward Journey", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: timeOutJourneyValuelbl, text: "All Times", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: timeReturnJourneylbl, text: "Time Of Return Journey", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: timeReturnJourneyValuelbl, text: "All Times", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: airlinelbl, text: "Airline", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: airlineValuelbl, text: "Airline", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        
        setupCV()
    }
    
    func setupCV() {
        let nib = UINib(nibName: "MultiCityCVCell", bundle: nil)
        multiCityTripCV.register(nib, forCellWithReuseIdentifier: "cell")
        let nib1 = UINib(nibName: "ButtonCVCell", bundle: nil)
        multiCityTripCV.register(nib1, forCellWithReuseIdentifier: "cell1")
        multiCityTripCV.delegate = self
        multiCityTripCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 380, height: 60)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        // layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        multiCityTripCV.collectionViewLayout = layout
        multiCityTripCV.backgroundColor = .clear
        multiCityTripCV.layer.cornerRadius = 4
        multiCityTripCV.clipsToBounds = true
        multiCityTripCV.showsHorizontalScrollIndicator = false
        
        updateheight()
        
    }
    
    func updateheight() {
        cvHeight.constant = CGFloat(80 * (nameArray.count + 1))
    }
    
    
    var count = 0
    func didTapOnAddCityBtn(cell: ButtonCVCell) {
        count += 1
        self.nameArray.append(String(count))
        updateheight()
        self.multiCityTripCV.reloadData()
        NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
        
    }
    
    var city = String()
    var city1 = String()
    func didtapOnSwapCityBtn(cell: MultiCityCVCell) {
        city = cell.fromCityname.text ?? ""
        city1 = cell.toCityNamelbl.text ?? ""
        cell.fromCityname.text = city1
        cell.toCityNamelbl.text = city
    }
    
    func didTapOnDeleteMultiCityTrip(cell: MultiCityCVCell) {
        print("didTapOnDeleteMultiCityTrip")
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
    
    
    var moreoptionBool = true
    @IBAction func didTapOnmoreOptionsBtn(_ sender: Any) {
        
        if moreoptionBool == true {
            optionView.isHidden = false
            optionViewHeight.constant = 200
            moresearchBtn.setTitle("Advanced Search Options", for: .normal)
            moresearchBtn.setImage( UIImage(systemName: "minus")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppTabSelectColor), for: .normal)
            
            moreoptionBool = false
        }else {
            optionView.isHidden = true
            optionViewHeight.constant = 0
            moresearchBtn.setTitle("More search options", for: .normal)
            moresearchBtn.setImage( UIImage(systemName: "plus")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppTabSelectColor), for: .normal)
            
            moreoptionBool = true
        }
        NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
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
    
}


extension MultiCityTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        if indexPath.row == nameArray.count {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? ButtonCVCell {
                cell.delegate = self
                commonCell = cell
            }
        }else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MultiCityCVCell {
                cell.delegate = self
                commonCell = cell
            }
        }
        
        return commonCell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: 380, height: 60)
        
    }
    
}
