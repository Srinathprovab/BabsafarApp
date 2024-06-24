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
    @IBOutlet weak var hotelNamelbl: UILabel!
    @IBOutlet weak var locNamelbl: UILabel!
    //  @IBOutlet weak var autoScrollImagesCV: UICollectionView!
    
    
    var itemCount = Int()
    var autoScrollTimer: Timer?
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // stopAutoScroll()
    }
    
    
    override func updateUI() {
        
      
        hotelImg.sd_setImage(with: URL(string: cellInfo?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
            if let error = error {
                // Handle error loading image
                print("Error loading image: \(error.localizedDescription)")
                // Check if the error is due to a 404 Not Found response
                if (error as NSError).code == NSURLErrorBadServerResponse {
                    // Set placeholder image for 404 error
                    self.hotelImg.image = UIImage(named: "noimage")
                } else {
                    // Set placeholder image for other errors
                    self.hotelImg.image = UIImage(named: "noimage")
                }
            }
        })
        
        
        hotelNamelbl.text = cellInfo?.title ?? ""
        locNamelbl.text = cellInfo?.subTitle ?? ""
        
        itemCount = images.count
        //  startAutoScroll()
        
        //  autoScrollImagesCV.reloadData()
        imagesCV.reloadData()
    }
    
    func setupUI() {
        contentView.backgroundColor = HexColor("#E6E8E7")
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: UIColor.lightGray.withAlphaComponent(0.4), cornerRadius: 10)
        
      
        hotelImg.layer.cornerRadius = 8
        hotelImg.clipsToBounds = true
        hotelImg.contentMode = .scaleToFill
        
        setupCV()
        // setupSCrollImagesCV()
    }
    
    
    
    //    func setupSCrollImagesCV() {
    //        let nib = UINib(nibName: "HotelImagesCVCell", bundle: nil)
    //        autoScrollImagesCV.register(nib, forCellWithReuseIdentifier: "cell1")
    //        autoScrollImagesCV.delegate = self
    //        autoScrollImagesCV.dataSource = self
    //        let layout = UICollectionViewFlowLayout()
    //        layout.itemSize = CGSize(width: 200, height: 180)
    //        layout.scrollDirection = .horizontal
    //        layout.minimumInteritemSpacing = 6
    //        layout.minimumLineSpacing = 6
    //        // layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    //        autoScrollImagesCV.collectionViewLayout = layout
    //        autoScrollImagesCV.backgroundColor = .clear
    //        autoScrollImagesCV.layer.cornerRadius = 4
    //        autoScrollImagesCV.clipsToBounds = true
    //        autoScrollImagesCV.showsHorizontalScrollIndicator = false
    //
    //    }
    
    
    
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
        imagesCV.bounces = false
        
    }
    
}



extension HotelImagesTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HotelImagesCVCell {
            
            cell.hotelImg.sd_setImage(with: URL(string: images[indexPath.row].img ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                if let error = error {
                    // Handle error loading image
                    print("Error loading image: \(error.localizedDescription)")
                    // Check if the error is due to a 404 Not Found response
                    if (error as NSError).code == NSURLErrorBadServerResponse {
                        // Set placeholder image for 404 error
                        self.hotelImg.image = UIImage(named: "noimage")
                    } else {
                        // Set placeholder image for other errors
                        self.hotelImg.image = UIImage(named: "noimage")
                    }
                }
            })
            
            commonCell = cell
        }
        
        return commonCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.hotelImg.sd_setImage(with: URL(string: images[indexPath.row].img ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        
    }
    
}



//extension HotelImagesTVCell {
//
//
//    // MARK: - Auto Scrolling
//
//    func startAutoScroll() {
//        autoScrollTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
//    }
//
//    func stopAutoScroll() {
//        autoScrollTimer?.invalidate()
//        autoScrollTimer = nil
//    }
//
//    @objc func scrollToNextItem() {
//
//
//        guard itemCount > 0 else {
//            return // No items in the collection view
//        }
//
//        let currentIndexPaths = autoScrollImagesCV.indexPathsForVisibleItems.sorted()
//        let lastIndexPath = currentIndexPaths.last ?? IndexPath(item: 0, section: 0)
//
//        var nextIndexPath: IndexPath
//
//        if lastIndexPath.item == itemCount - 1 {
//            nextIndexPath = IndexPath(item: 0, section: lastIndexPath.section)
//        } else {
//            nextIndexPath = IndexPath(item: lastIndexPath.item + 1, section: lastIndexPath.section)
//        }
//        
//        if nextIndexPath.item >= itemCount {
//            nextIndexPath = IndexPath(item: 0, section: nextIndexPath.section) // Adjust the index path if it exceeds the bounds
//        }
//
//        autoScrollImagesCV.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
//    }
//
//
//}
