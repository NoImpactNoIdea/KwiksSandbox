//
//  ImageMainCell.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/10/23.
//


import Foundation
import UIKit

class ImageMainCell : UICollectionViewCell {
    
    var chatCollection : ChatCollection?
 
    let profilePhoto : UIButton = {
        
        let dcl = UIButton()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = UIColor.profilePhotoBackgroundColor
        dcl.contentMode = .scaleAspectFill
        dcl.layer.masksToBounds = true
        
        return dcl
    }()
    
    let imageBubble : UIView = {
        
        let cb = UIView()
        cb.translatesAutoresizingMaskIntoConstraints = false
        cb.backgroundColor = UIColor.kwiksGreen
        cb.isUserInteractionEnabled = false
        cb.layer.masksToBounds = true
        cb.layer.cornerRadius = 15

        return cb
    }()
    
    let timeLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .right
        thl.text = "09:27 am"
        thl.font = UIFont(name: FontKit().segoeSemiBold, size: 10)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = UIColor.timeChatGrey
        thl.backgroundColor = .clear
        
        return thl
        
    }()
    
    let framedImage : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = UIColor.profilePhotoBackgroundColor
        dcl.contentMode = .scaleAspectFill
        dcl.layer.masksToBounds = true
        dcl.clipsToBounds = true
        dcl.layer.masksToBounds = true
        dcl.layer.cornerRadius = 12
     
        return dcl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.addViews()
        
        let image = UIImage(named: "stock_photo_woman")?.withRenderingMode(.alwaysOriginal)
        self.framedImage.image = image
    }
    
    func addViews() {
        
        self.addSubview(self.profilePhoto)
        self.addSubview(self.imageBubble)
        self.addSubview(self.timeLabel)
        self.addSubview(self.framedImage)

        //this is the base line here
        self.timeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 75).isActive = true
        self.timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        self.timeLabel.sizeToFit()
        
        self.profilePhoto.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.profilePhoto.bottomAnchor.constraint(equalTo: self.timeLabel.topAnchor, constant: -5).isActive = true
        self.profilePhoto.heightAnchor.constraint(equalToConstant: 25).isActive = true
        self.profilePhoto.widthAnchor.constraint(equalToConstant: 25).isActive = true
        self.profilePhoto.layer.cornerRadius = 15
       
        self.imageBubble.leftAnchor.constraint(equalTo: self.profilePhoto.rightAnchor, constant: 20).isActive = true
        self.imageBubble.widthAnchor.constraint(equalToConstant: 158).isActive = true
        self.imageBubble.bottomAnchor.constraint(equalTo: self.profilePhoto.bottomAnchor, constant: 3).isActive = true
        self.imageBubble.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        self.framedImage.topAnchor.constraint(equalTo: self.imageBubble.topAnchor, constant: 4).isActive = true
        self.framedImage.leftAnchor.constraint(equalTo: self.imageBubble.leftAnchor, constant: 4).isActive = true
        self.framedImage.bottomAnchor.constraint(equalTo: self.imageBubble.bottomAnchor, constant: -4).isActive = true
        self.framedImage.rightAnchor.constraint(equalTo: self.imageBubble.rightAnchor, constant: -4).isActive = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageBubble.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        self.framedImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

