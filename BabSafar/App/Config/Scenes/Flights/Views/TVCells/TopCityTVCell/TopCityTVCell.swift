//
//  TopCityTVCell.swift
//  BabSafar
//
//  Created by MA673 on 19/07/22.
//

import UIKit

protocol TopCityTVCellDelegate {
    func viewAllBtnAction(cell:TopCityTVCell)
}

class TopCityTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var viewAllHolderView: UIView!
    @IBOutlet weak var viewAlllbl: UILabel!
    @IBOutlet weak var rightArrowImg: UIImageView!
    @IBOutlet weak var citysCV: UICollectionView!
    
    var delegate:TopCityTVCellDelegate?
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
        titlelbl.text = cellInfo?.title
    }
    
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.LatoSemibold(size: 18)
        
        
        viewAlllbl.text = "view all"
        viewAlllbl.textColor = .AppTabSelectColor
        viewAlllbl.font = UIFont.LatoRegular(size: 16)
        viewAllHolderView.backgroundColor = .WhiteColor
        rightArrowImg.image = UIImage(named: "rightArrow")
        
        setupCV()
        
    }
    
    func setupCV() {
        let nib = UINib(nibName: "TopCityCVCell", bundle: nil)
        citysCV.register(nib, forCellWithReuseIdentifier: "cell")
        citysCV.delegate = self
        citysCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 115, height: 125)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        citysCV.collectionViewLayout = layout
        citysCV.backgroundColor = .clear
        citysCV.layer.cornerRadius = 4
        citysCV.clipsToBounds = true
        citysCV.showsHorizontalScrollIndicator = false
    }
    
    
    @IBAction func viewAllBtnAction(_ sender: Any) {
        delegate?.viewAllBtnAction(cell: self)
    }
    
}


extension TopCityTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TopCityCVCell {
            cell.cityImage.image = UIImage(named: "city")
            cell.cityNamelbl.text = "Egypt"
            commonCell = cell
        }
        return commonCell
    }
    
}

