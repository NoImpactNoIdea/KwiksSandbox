//
//  ChatCollection.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/3/23.
//

import Foundation
import UIKit

class ChatCollection : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    private let chatID = "chatID"
    private let audioID = "audioID"
    private let imageID = "imageID"

    var chatMain : ChatMain?,
        counter : Int = 0

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
        self.layer.cornerRadius = 40
        self.clipsToBounds = true
        self.contentInset = UIEdgeInsets(top: 210, left: 0, bottom: 0, right: 0)
        
        self.register(ChatMainCell.self, forCellWithReuseIdentifier: self.chatID)
        self.register(AudioMainCell.self, forCellWithReuseIdentifier: self.audioID)
        self.register(ImageMainCell.self, forCellWithReuseIdentifier: self.imageID)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let chatMain = self.chatMain {
            return chatMain.chatDataSource.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        if let chatMain = self.chatMain {
            let dataSource = chatMain.chatDataSource
            
            if dataSource.count > 0 {
                let typeEnum = dataSource[indexPath.item].typeEnum
                
                switch typeEnum {
                    case .image: return CGSize(width: self.frame.width, height: 270)
                    case .message:  return CGSize(width: self.frame.width, height: 50)
                    case .audio :  return CGSize(width: self.frame.width, height: 50)
                }
                
            } else {
                return CGSize(width: self.frame.width, height: 0)
            }
        } else {
            return CGSize(width: self.frame.width, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let chatMain = self.chatMain {
            
            let dataSource = chatMain.chatDataSource
            if dataSource.count > 0 {
                
                let typeEnum = chatMain.chatDataSource[indexPath.item].typeEnum
                
                    switch typeEnum {
                        case .image: return self.configureImageCell(indexPath: indexPath)
                        case .audio: return self.configureAudioCell(indexPath: indexPath)
                        case .message: return self.configureMessageCell(indexPath: indexPath)
                    }
                
            } else {
                return UICollectionViewCell()
            }
        } else {
            return UICollectionViewCell()
        }
    }
    
    func configureMessageCell(indexPath : IndexPath) -> UICollectionViewCell {
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.chatID, for: indexPath) as! ChatMainCell
        cell.chatCollection = self

        if let chatMain = self.chatMain {
            let feeder = chatMain.chatDataSource[indexPath.item]

            //owners message
            if let ownersMessage = feeder.message {
                print("owners message: \(ownersMessage)")
                cell.messageLabel.text = ownersMessage
            }

            //owners profile photo
            if let ownersProfilePhoto = feeder.ownersProfilePhoto {
                let imageView = UIImageView()
                imageView.loadImageGeneralUse(ownersProfilePhoto) { isComplete in
                    if imageView.image != nil {
                        cell.profilePhoto.setBackgroundImage(imageView.image!, for: .normal)
                    }
                }
            }

            //owners time stamp
            let ownersTimeStamp = feeder.timeStamp //not optional because it is hardcoded in the model for testing
                print("ownersTimeStamp: \(ownersTimeStamp)")

        }
        return cell
    }
    
    func configureAudioCell(indexPath : IndexPath) -> UICollectionViewCell {
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.audioID, for: indexPath) as! AudioMainCell
        cell.chatCollection = self

        if let chatMain = self.chatMain {
            let feeder = chatMain.chatDataSource[indexPath.item]

            //owners profile photo
            if let ownersProfilePhoto = feeder.ownersProfilePhoto {
                let imageView = UIImageView()
                imageView.loadImageGeneralUse(ownersProfilePhoto) { isComplete in
                    if imageView.image != nil {
                        cell.profilePhoto.setBackgroundImage(imageView.image!, for: .normal)
                    }
                }
            }

            //owners time stamp
            let ownersTimeStamp = feeder.timeStamp //not optional because it is hardcoded in the model for testing
                print("ownersTimeStamp: \(ownersTimeStamp)")
            }
        
            //pass the audio clip/url here on todo
            
        return cell
    }
    
    func configureImageCell(indexPath : IndexPath) -> UICollectionViewCell {
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.imageID, for: indexPath) as! ImageMainCell
        cell.chatCollection = self

        if let chatMain = self.chatMain {
            let feeder = chatMain.chatDataSource[indexPath.item]

            //owners profile photo
            if let ownersProfilePhoto = feeder.ownersProfilePhoto {
                let imageView = UIImageView()
                imageView.loadImageGeneralUse(ownersProfilePhoto) { isComplete in
                    if imageView.image != nil {
                        cell.profilePhoto.setBackgroundImage(imageView.image!, for: .normal)
                    }
                }
            }
            
            
            
            //owners time stamp
            let ownersTimeStamp = feeder.timeStamp //not optional because it is hardcoded in the model for testing
                print("ownersTimeStamp: \(ownersTimeStamp)")
            }
        
            //pass the audio clip/url here on todo
            
        return cell
    }
    
    func bottomOffset() -> CGPoint {
        
        self.counter += 1
        return CGPoint(x: 0, y: max(-self.contentInset.top, self.contentSize.height - (self.bounds.size.height - self.contentInset.bottom)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

