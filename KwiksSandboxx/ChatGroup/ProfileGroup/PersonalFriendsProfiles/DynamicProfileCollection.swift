//
//  DynamicProfileCollection.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/12/23.
//

import Foundation
import UIKit
import SDWebImage

class DynamicProfileCollection : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate, PinterestLayoutThreeSquareDelegate {
   
    private let dynamicProfileID = "dynamicProfileID"
    
    var dynamicUserProfile : DynamicUserProfile?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = UIColor .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.dataSource = self
        self.delegate = self
        
        self.isPrefetchingEnabled = false
        self.keyboardDismissMode = UIScrollView.KeyboardDismissMode.interactive
        self.alwaysBounceVertical = true
        self.alwaysBounceHorizontal = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.allowsMultipleSelection = true
        self.canCancelContentTouches = false
        self.contentInsetAdjustmentBehavior = .never
        self.delaysContentTouches = true
        self.contentInset = UIEdgeInsets(top: 615, left: 0, bottom: 35, right: 0)
        
        self.register(DynamicFeeder.self, forCellWithReuseIdentifier: self.dynamicProfileID)
        
        //MARK: - PINTEREST STYLE LAYOUT ATTRIBUTE
        if let layout = self.collectionViewLayout as? PinterestLayoutThreeSquare {
            layout.delegate = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dynamicProfile = self.dynamicUserProfile {
            return dynamicProfile.dynamicImages.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return screenWidth / 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if let dynamicProfile = self.dynamicUserProfile {
            let cell = self.dequeueReusableCell(withReuseIdentifier: self.dynamicProfileID, for: indexPath) as! DynamicFeeder
            cell.dynamicProfileCollection = self
            
            let dataSource = dynamicProfile.dynamicImages
            
            if dataSource.count > 0 {
                
                let feeder = dataSource[indexPath.item] //get the first image in the loop
                cell.imageContainer.loadImageGeneralUse(feeder) { isComplete in
                    print("image loaded")
                }
            }
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DynamicFeeder : UICollectionViewCell {
    
    var dynamicProfileCollection : DynamicProfileCollection?
    
    lazy var imageContainer : UIImageView = {
        
        let cv = UIImageView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor (white: 0.8, alpha: 0.4)
        cv.layer.cornerRadius = 10
        cv.clipsToBounds = true
        cv.layer.masksToBounds = true
        cv.layer.borderWidth = 1
        cv.layer.borderColor = UIColor .black.withAlphaComponent(0.1).cgColor
        cv.contentMode = .scaleAspectFill

        return cv
    }()
    
    var viewCountLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = UIColor .white
        hfl.textAlignment = .right
        hfl.font = UIFont(name: FontKit().segoeSemiBold, size: 12)
        
        return hfl
    }()
    
    let playIcon : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.contentMode = .scaleAspectFill
        dcl.isUserInteractionEnabled = false
        dcl.clipsToBounds = true
        let image = UIImage(named: "play_icon_white")?.withRenderingMode(.alwaysOriginal)
        dcl.image = image
        return dcl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor .white
        self.addViews()
        self.dummyValues()
        
    }
    
    func dummyValues() {
        self.viewCountLabel.text = "24k"
    }
    
    func addViews() {
        
        self.addSubview(self.imageContainer)
        self.addSubview(self.viewCountLabel)
        self.addSubview(self.playIcon)

        self.imageContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        self.imageContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.imageContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.imageContainer.widthAnchor.constraint(equalToConstant: screenWidth / 3.6).isActive = true
        
        self.viewCountLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -13).isActive = true
        self.viewCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        self.viewCountLabel.sizeToFit()
        
        self.playIcon.rightAnchor.constraint(equalTo: self.viewCountLabel.leftAnchor, constant: -3).isActive = true
        self.playIcon.centerYAnchor.constraint(equalTo: self.viewCountLabel.centerYAnchor, constant: 1.5).isActive = true
        self.playIcon.sizeToFit()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
