//
//  HotelsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit

protocol HotelsTVCellelegate{
    func didTapOnRefundableBtn(cell: HotelsTVCell)
    func didTapOnLocationBtnAction(cell: HotelsTVCell)

}

class HotelsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var hotelImg: UIImageView!
    @IBOutlet weak var hotelNamelbl: UILabel!
    @IBOutlet weak var ratingsView: UIView!
    @IBOutlet weak var ratingslbl: UILabel!
    @IBOutlet weak var locImg: UIImageView!
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var perNightlbl: UILabel!
    @IBOutlet weak var refundableView: UIView!
    @IBOutlet weak var refundablelbl: UILabel!
    @IBOutlet weak var refundableBtn: UIButton!
    @IBOutlet weak var locBtn: UIButton!
    @IBOutlet weak var facilityCV: UICollectionView!
    
    var bookingsource = String()
    var hotelid = String()
    var searchid = String()
    var lat = String()
    var long = String()
    var facilityArray = [HFacility]()
    var delegate:HotelsTVCellelegate?
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
        hotelNamelbl.text = cellInfo?.title ?? ""
        self.hotelImg.sd_setImage(with: URL(string: cellInfo?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        ratingslbl.text = cellInfo?.subTitle
        locationlbl.text = cellInfo?.buttonTitle
        refundablelbl.text = cellInfo?.headerText
        kwdlbl.text = cellInfo?.text
    }
    
    
    func setupUI() {
        setupViews(v: holderView, radius: 10, color: .WhiteColor)
        setupViews(v: ratingsView, radius: 4, color: HexColor("#2FA804"))
        ratingsView.layer.borderColor = HexColor("#2FA804").cgColor
        setupViews(v: refundableView, radius: 10, color: HexColor("#D4F3D4"))
        ratingsView.layer.borderColor = HexColor("#D4F3D4").cgColor
        
        hotelImg.image = UIImage(named: "city")
        hotelImg.layer.cornerRadius = 8
        hotelImg.clipsToBounds = true
        locImg.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#A3A3A3"))
        
        setuplabels(lbl: hotelNamelbl, text: "Majestic City Retreat Hotel", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .left)
        setuplabels(lbl: ratingslbl, text: "4.1", textcolor: .WhiteColor, font: .LatoMedium(size: 12), align: .center)
        setuplabels(lbl: locationlbl, text: "Bur Dubai, Dubai | 700 m from Al Fahidi Metro Station", textcolor: .SubTitleColor, font: .LatoRegular(size: 12), align: .left)
        setuplabels(lbl: kwdlbl, text: "KWD:150.00", textcolor: .AppTabSelectColor, font: .LatoSemibold(size: 18), align: .right)
        setuplabels(lbl: perNightlbl, text: "per night", textcolor: .SubTitleColor, font: .LatoRegular(size: 12), align: .center)
        setuplabels(lbl: refundablelbl, text: "Refundable", textcolor: HexColor("#2FA804"), font: .LatoRegular(size: 12), align: .center)
        
        refundableBtn.setTitle("", for: .normal)
        locBtn.setTitle("", for: .normal)
        
        setupCV()
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
    }
    
    func setupCV() {
        let nib = UINib(nibName: "FacilityCVCells", bundle: nil)
        facilityCV.register(nib, forCellWithReuseIdentifier: "cell")
        facilityCV.delegate = self
        facilityCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 20, height: 20)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 7
        layout.minimumLineSpacing = 7
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        facilityCV.collectionViewLayout = layout
        facilityCV.showsHorizontalScrollIndicator = false
    }
    
    
    
    
    @IBAction func didTapOnRefundableBtn(_ sender: Any) {
        delegate?.didTapOnRefundableBtn(cell: self)
    }
    
    
    @IBAction func didTapOnLocationBtnAction(_ sender: Any) {
        delegate?.didTapOnLocationBtnAction(cell: self)
    }
    
}


extension HotelsTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return facilityArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FacilityCVCells {
           
            if facilityArray.count != 0 {
                cell.facilityimg.image = UIImage(named: "airlogo")
            }
            commonCell = cell
        }
        return commonCell
    }
    
}
