//
//  MessageCell.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/10/23.
//

import Foundation
import UIKit

class ChatMainCell : UICollectionViewCell {
    
    var chatCollection : ChatCollection?
 
    let profilePhoto : UIButton = {
        
        let dcl = UIButton()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = UIColor.profilePhotoBackgroundColor
        dcl.contentMode = .scaleAspectFill
        dcl.layer.masksToBounds = true
        
        return dcl
    }()
    
    let chatBubble : UIView = {
        
        let cb = UIView()
        cb.translatesAutoresizingMaskIntoConstraints = false
        cb.backgroundColor = UIColor.deleteGrey
        cb.isUserInteractionEnabled = false
        cb.layer.masksToBounds = true
        cb.layer.cornerRadius = 8

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
    
    let messageLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = ""
        thl.font = UIFont(name: FontKit().segoeRegular, size: 12)
        thl.numberOfLines = -1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = .black
        thl.backgroundColor = .clear
        
        return thl
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addViews()
    }
    
    func addViews() {
        
        self.addSubview(self.profilePhoto)
        self.addSubview(self.chatBubble)
        self.addSubview(self.timeLabel)
        self.addSubview(self.messageLabel)
        
        //this is the base line here
        self.timeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 75).isActive = true
        self.timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        self.timeLabel.sizeToFit()
        
        self.profilePhoto.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.profilePhoto.bottomAnchor.constraint(equalTo: self.timeLabel.topAnchor, constant: -5).isActive = true
        self.profilePhoto.heightAnchor.constraint(equalToConstant: 25).isActive = true
        self.profilePhoto.widthAnchor.constraint(equalToConstant: 25).isActive = true
        self.profilePhoto.layer.cornerRadius = 25/2
       
        self.chatBubble.leftAnchor.constraint(equalTo: self.profilePhoto.rightAnchor, constant: 20).isActive = true
        self.chatBubble.topAnchor.constraint(equalTo: self.profilePhoto.topAnchor, constant: -3).isActive = true
        self.chatBubble.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.chatBubble.bottomAnchor.constraint(equalTo: self.profilePhoto.bottomAnchor, constant: 3).isActive = true
        
        self.messageLabel.topAnchor.constraint(equalTo: self.chatBubble.topAnchor, constant: 8).isActive = true
        self.messageLabel.leftAnchor.constraint(equalTo: self.chatBubble.leftAnchor, constant: 14).isActive = true
        self.messageLabel.bottomAnchor.constraint(equalTo: self.chatBubble.bottomAnchor, constant: -8).isActive = true
        self.messageLabel.rightAnchor.constraint(equalTo: self.chatBubble.rightAnchor, constant: -10).isActive = true
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.chatBubble.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

