//
//  SpecialDealsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 19/07/22.
//

import UIKit
protocol SpecialDealsTVCellDelegate {
    func didTapFlightsTabBtnAction(cell: SpecialDealsTVCell)
    func didTapHotelsTabBtnAction(cell: SpecialDealsTVCell)
    func viewAllBtnAction(cell: SpecialDealsTVCell)
    func didTapOnPromoCodeBtnAction(cell: SpecialDealsTVCell)
}

class SpecialDealsTVCell: TableViewCell,SpecialDealsCVCellDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titleLblView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dealsHolderView: UIView!
    @IBOutlet weak var flightTabView: UIView!
    @IBOutlet weak var flightlbl: UILabel!
    @IBOutlet weak var hotelsTabView: UIView!
    @IBOutlet weak var hotelslbl: UILabel!
    @IBOutlet weak var viewAllHolderView: UIView!
    @IBOutlet weak var viewAlllbl: UILabel!
    @IBOutlet weak var rightArrowImg: UIImageView!
    @IBOutlet weak var flightViewUL: UIView!
    @IBOutlet weak var hotelViewUL: UIView!
    @IBOutlet weak var bookingHolderView: UIView!

    @IBOutlet weak var specialDealsCV: UICollectionView!
    var delegate: SpecialDealsTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupCV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    
    func setupUI() {
        
        contentView.backgroundColor = .AppBorderColor
        holderView.backgroundColor = .clear
        titleLblView.backgroundColor = .WhiteColor
        dealsHolderView.backgroundColor = .WhiteColor
        
        flightTabView.backgroundColor = .AppTabSelectColor
        flightTabView.layer.cornerRadius = 4
        flightTabView.clipsToBounds = true
        flightTabView.layer.borderWidth = 0.7
        flightTabView.layer.borderColor = UIColor.AppBorderColor.cgColor
        hotelsTabView.backgroundColor = .WhiteColor
        hotelsTabView.layer.cornerRadius = 4
        hotelsTabView.clipsToBounds = true
        hotelsTabView.layer.borderWidth = 0.7
        hotelsTabView.layer.borderColor = UIColor.AppBorderColor.cgColor
        viewAllHolderView.backgroundColor = .WhiteColor
        flightViewUL.backgroundColor = .AppTabSelectColor
        hotelViewUL.backgroundColor = .WhiteColor
        bookingHolderView.backgroundColor = .WhiteColor
        bookingHolderView.layer.cornerRadius = 4
        bookingHolderView.clipsToBounds = true
        bookingHolderView.layer.borderWidth = 1
        bookingHolderView.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        
        
        rightArrowImg.image = UIImage(named: "rightArrow")
        
       
        
        
        titlelbl.text = "Special Deals For You"
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.LatoSemibold(size: 20)
        
        flightlbl.text = "Flights"
        flightlbl.textColor = .WhiteColor
        flightlbl.font = UIFont.LatoRegular(size: 16)
        
        hotelslbl.text = "Hotels"
        hotelslbl.textColor = .AppLabelColor
        hotelslbl.font = UIFont.LatoRegular(size: 16)
        
        
        viewAlllbl.text = "view all"
        viewAlllbl.textColor = .AppTabSelectColor
        viewAlllbl.font = UIFont.LatoRegular(size: 16)
        
        
    }
    
    
    func setupCV() {
        let nib = UINib(nibName: "SpecialDealsCVCell", bundle: nil)
        specialDealsCV.register(nib, forCellWithReuseIdentifier: "cell")
        specialDealsCV.delegate = self
        specialDealsCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 410, height: 199)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        specialDealsCV.collectionViewLayout = layout
        specialDealsCV.backgroundColor = .clear
        specialDealsCV.layer.cornerRadius = 4
        specialDealsCV.clipsToBounds = true
        specialDealsCV.showsHorizontalScrollIndicator = false
    }
    
    
    
    @IBAction func didTapFlightsTabBtnAction(_ sender: Any) {
        delegate?.didTapFlightsTabBtnAction(cell: self)
    }
    
    @IBAction func didTapHotelsTabBtnAction(_ sender: Any) {
        delegate?.didTapHotelsTabBtnAction(cell: self)
    }
    
    @IBAction func viewAllBtnAction(_ sender: Any) {
        delegate?.viewAllBtnAction(cell: self)
    }
    
    func didTapOnPromoCodeBtnAction(cell: SpecialDealsCVCell) {
        delegate?.didTapOnPromoCodeBtnAction(cell: self)
    }

}



extension SpecialDealsTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SpecialDealsCVCell {
            cell.offerImage.image = UIImage(named: "offer")
            cell.bookinglbl.text = "First booking international flight  25% off"
            cell.promocodelbl.text = "promo code: flight 2145"
            commonCell = cell
        }
        return commonCell
    }
    
}
