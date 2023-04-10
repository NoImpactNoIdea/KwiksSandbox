//
//  InteriorHeader.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/10/23.
//

import Foundation
import UIKit

class InteriorHeader : UIView {
    
    var chatMain : ChatMain?
    
    lazy var profilePhoto : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = UIColor (white: 0.8, alpha: 0.4)
        dcl.contentMode = .scaleAspectFill
        dcl.isUserInteractionEnabled = false
        dcl.clipsToBounds = true
       
        return dcl
    }()
    
    var nameLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = UIColor.black
        hfl.textAlignment = .left
        hfl.font = UIFont(name: FontKit().segoeSemiBold, size: 15)
        hfl.isUserInteractionEnabled = true
        hfl.numberOfLines = 1
        
        return hfl
    }()
    
    var statsLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = UIColor.chatTextGrey
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeRegular, size: 12)
        hfl.isUserInteractionEnabled = true
        hfl.numberOfLines = 1
        
        return hfl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addViews()
        
        self.nameLabel.text = "Charlie Arcodia"
        self.profilePhoto.loadImageGeneralUse("\(S().stockPhotoURL)") { isComplete in
            print("stock image loaded")
        }
        self.statsLabel.text = "200 Videos   1.6M followers"
    }
    
    func addViews() {
        
        self.addSubview(self.profilePhoto)
        self.addSubview(self.nameLabel)
        self.addSubview(self.statsLabel)

        self.profilePhoto.topAnchor.constraint(equalTo: self.topAnchor, constant: 53).isActive = true
        self.profilePhoto.widthAnchor.constraint(equalToConstant: 70).isActive = true
        self.profilePhoto.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.profilePhoto.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.profilePhoto.layer.cornerRadius = 35
        
        self.nameLabel.topAnchor.constraint(equalTo: self.profilePhoto.bottomAnchor, constant: 10).isActive = true
        self.nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.nameLabel.sizeToFit()
        
        self.statsLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 10).isActive = true
        self.statsLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.statsLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.statsLabel.sizeToFit()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
