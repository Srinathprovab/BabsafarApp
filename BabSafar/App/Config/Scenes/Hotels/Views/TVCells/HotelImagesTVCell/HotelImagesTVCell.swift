//
//  HotelImagesTVCell.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit

class HotelImagesTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var hotelImg: UIImageView!
    @IBOutlet weak var imagesCV: UICollectionView!
    
    
    var hotelImagesArray = [String]()
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
        self.hotelImagesArray = cellInfo?.data as? [String] ?? []
        self.hotelImg.image = UIImage(named: "city")
    }
    
    func setupUI() {
        contentView.backgroundColor = .AppBorderColor
        setupViews(v: holderView, radius: 10, color: .WhiteColor)
        hotelImg.layer.cornerRadius = 8
        hotelImg.clipsToBounds = true
        hotelImg.contentMode = .scaleToFill
        
        setupCV()
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    func setupCV() {
        let nib = UINib(nibName: "HotelImagesCVCell", bundle: nil)
        imagesCV.register(nib, forCellWithReuseIdentifier: "cell")
        imagesCV.delegate = self
        imagesCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height: 70)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        // layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        imagesCV.collectionViewLayout = layout
        imagesCV.backgroundColor = .clear
        imagesCV.layer.cornerRadius = 4
        imagesCV.clipsToBounds = true
        imagesCV.showsHorizontalScrollIndicator = false
        
        
    }
    
}



extension HotelImagesTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotelImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HotelImagesCVCell {
            cell.hotelImg.image = UIImage(named: hotelImagesArray[indexPath.row])
            commonCell = cell
        }
        return commonCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.hotelImg.image = UIImage(named: hotelImagesArray[indexPath.row])
    }
    
}



