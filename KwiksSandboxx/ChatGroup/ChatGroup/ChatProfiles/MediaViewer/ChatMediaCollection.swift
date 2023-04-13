//
//  ChatMediaCollection.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/11/23.
//


import Foundation
import UIKit
import SDWebImage

class ChatMediaCollection : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate, PinterestLayoutThreeSquareDelegate {
   
    private let chatMediaCollectionID = "chatMediaCollectionID"
    
    var chatMediaViewer : ChatMediaViewer?
    
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
        
        self.register(ChatMediaFeeder.self, forCellWithReuseIdentifier: self.chatMediaCollectionID)
        
        //MARK: - PINTEREST STYLE LAYOUT ATTRIBUTE
        if let layout = self.collectionViewLayout as? PinterestLayoutThreeSquare {
            layout.delegate = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let chatViewer = self.chatMediaViewer {
            return chatViewer.chatViewerImages.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return screenWidth / 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if let chatViewer = self.chatMediaViewer {
            let cell = self.dequeueReusableCell(withReuseIdentifier: self.chatMediaCollectionID, for: indexPath) as! ChatMediaFeeder
            cell.chatMediaCollection = self
            
            let dataSource = chatViewer.chatViewerImages
            
            if dataSource.count > 0 {
                
                let feeder = dataSource[indexPath.item] //get the first image in the loop
                cell.containerView.loadImageGeneralUse(feeder) { isComplete in
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

class ChatMediaFeeder : UICollectionViewCell {
    
    var chatMediaCollection : ChatMediaCollection?
    
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
        self.containerView.widthAnchor.constraint(equalToConstant: screenWidth / 4).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
