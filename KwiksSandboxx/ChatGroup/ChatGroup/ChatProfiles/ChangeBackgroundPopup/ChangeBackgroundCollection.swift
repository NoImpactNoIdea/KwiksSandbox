//
//  ChangeBackgroundCollection.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/11/23.
//


import Foundation
import UIKit
import SDWebImage

class ChangeBackgroundCollection : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate, PinterestLayoutFourSquareDelegate {
   
    private let changeBackgroundID = "changeBackgroundID"
    
    var changeBackgroundPopup : ChangeBackgroundPopup?
    
    var indexpathArray = [IndexPath]()
    
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
        
        self.register(ChangeBackgroundFeeder.self, forCellWithReuseIdentifier: self.changeBackgroundID)
        
        //MARK: - PINTEREST STYLE LAYOUT ATTRIBUTE
        if let layout = self.collectionViewLayout as? PinterestLayoutFourSquare {
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
        return screenWidth / 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if let changeBackground = self.changeBackgroundPopup {
            let cell = self.dequeueReusableCell(withReuseIdentifier: self.changeBackgroundID, for: indexPath) as! ChangeBackgroundFeeder
            cell.changeBackgroundCollection = self
            
            let dataSource = changeBackground.changeBackgroundPhotoArray
            
            if dataSource.count > 0 {
                
                if self.indexpathArray.contains(indexPath) {
                    cell.containerView.layer.borderWidth = 4
                } else {
                    cell.containerView.layer.borderWidth = 0
                }
                
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
    
    @objc func handleCellSelection(sender:UIButton) {

        let selectedButtonCell = sender.superview as! UICollectionViewCell
        guard let indexPath = self.indexPath(for: selectedButtonCell) else {return}
        
        UIDevice.vibrateLight()
        self.indexpathArray.removeAll()
        self.indexpathArray.append(indexPath)

        DispatchQueue.main.async {
            self.reloadData()
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
        cv.layer.borderWidth = 0
        cv.layer.borderColor = UIColor.kwiksGreen.cgColor
        
        return cv
    }()
    
    lazy var dummyButton : UIButton = {
        
        let db = UIButton(type: .system)
        db.translatesAutoresizingMaskIntoConstraints = false
        db.backgroundColor = .clear
        db.addTarget(self, action: #selector(self.handleBackgroundSelection(sender:)), for: .touchUpInside)
        
        return db
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor .white
        self.contentView.isUserInteractionEnabled = false
        self.addViews()
    }
    
    func addViews() {
        
        self.addSubview(self.containerView)
        self.addSubview(self.dummyButton)

        self.containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        self.containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.containerView.widthAnchor.constraint(equalToConstant: screenWidth / 5).isActive = true
        
        self.dummyButton.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        self.dummyButton.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
        self.dummyButton.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true
        self.dummyButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true

    }
    
    @objc func handleBackgroundSelection(sender: UIButton) {
        self.changeBackgroundCollection?.handleCellSelection(sender:sender)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
