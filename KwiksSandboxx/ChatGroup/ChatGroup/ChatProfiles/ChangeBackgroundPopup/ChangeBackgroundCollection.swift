//
//  ChangeBackgroundCollection.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/11/23.
//


import Foundation
import UIKit
import SDWebImage

class ChangeBackgroundCollection : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate, PinterestLayoutDelegatePastMatches {
   
    private let changeBackgroundID = "changeBackgroundID"
    
    var changeBackgroundPopup : ChangeBackgroundPopup?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = UIColor .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.dataSource = self
        self.delegate = self
        
        self.isPrefetchingEnabled = false
        self.keyboardDismissMode = UIScrollView.KeyboardDismissMode.interactive
        self.alwaysBounceVertical = false
        self.alwaysBounceHorizontal = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.allowsMultipleSelection = true
        self.canCancelContentTouches = false
        self.contentInsetAdjustmentBehavior = .never
        self.delaysContentTouches = true
        self.isUserInteractionEnabled = false
        
        self.register(ChangeBackgroundFeeder.self, forCellWithReuseIdentifier: self.changeBackgroundID)
        
        //MARK: - PINTEREST STYLE LAYOUT ATTRIBUTE
        if let layout = self.collectionViewLayout as? PinterestLayoutPastMatches {
            layout.delegate = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let changeBackground = self.changeBackgroundPopup {
            return changeBackground.changeBackgroundPhotoArray.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if let changeBackground = self.changeBackgroundPopup {
            let cell = self.dequeueReusableCell(withReuseIdentifier: self.changeBackgroundID, for: indexPath) as! ChangeBackgroundFeeder
            cell.changeBackgroundCollection = self
            
            let dataSource = changeBackground.changeBackgroundPhotoArray
            
            if dataSource.count > 0 {
                
                let feeder = dataSource[indexPath.item] //get the first image in the loop
//                cell.containerView.loadImageGeneralUse(feeder) { isComplete in
//                    print("image loaded")
//                }
                
                //you will load dynamically, this is just for testing
                cell.containerView.image = UIImage(named: feeder)?.withRenderingMode(.alwaysOriginal)
                
                
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

class ChangeBackgroundFeeder : UICollectionViewCell {
    
    var changeBackgroundCollection : ChangeBackgroundCollection?
    
    lazy var containerView : UIImageView = {
        
        let cv = UIImageView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor (white: 0.8, alpha: 0.4)
        cv.layer.cornerRadius = 10
        cv.clipsToBounds = true
        cv.layer.masksToBounds = true
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor .white
        self.addViews()
        
    }
    
    func addViews() {
        
        self.addSubview(self.containerView)
        
        self.containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        self.containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.containerView.widthAnchor.constraint(equalToConstant: 84).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
