//
//  TopCityTVCell.swift
//  BabSafar
//
//  Created by MA673 on 19/07/22.
//

import UIKit

class TopCityTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var citysCV: UICollectionView!
    
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
        citysCV.reloadData()
        
    }
    
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18), align: .left)
        setupCV()
        
    }
    
    func setupCV() {
        let nib = UINib(nibName: "TopCityCVCell", bundle: nil)
        citysCV.register(nib, forCellWithReuseIdentifier: "cell")
        citysCV.delegate = self
        citysCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 130, height: 160)
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
    
    
    
}


extension TopCityTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if cellInfo?.key == "flights" {
            return topFlightDetails.count
        }else {
            return topHotelDetails.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TopCityCVCell {
            
            if cellInfo?.key == "flights" {
                let data = topFlightDetails[indexPath.row]
                
                cell.cityImage.sd_setImage(with: URL(string: data.topFlightImg ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                cell.cityNamelbl.text = "\(data.from_city_name ?? "") (\(data.from_city_loc ?? ""))"
                
                
            } else {
                
                let data = topHotelDetails[indexPath.row]
                cell.cityImage.sd_setImage(with: URL(string: data.topFlightImg ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                cell.cityNamelbl.text = "\(data.from_city_name ?? "") (\(data.from_city_loc ?? ""))"
                
                
            }
            
            commonCell = cell
        }
        return commonCell
    }
    
}

