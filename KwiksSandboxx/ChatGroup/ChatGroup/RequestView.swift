//
//  RequestView.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/3/23.
//

import Foundation
import UIKit

class RequestView : UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 40
        self.addViews()
        
        self.nameLabel.text = "Charlie Arcodia"
        let image = UIImage(named: "stock_photo_man")
        self.profilePhoto.image = image
    }
  
    func addViews() {
        
        self.addSubview(self.profilePhoto)
        self.addSubview(self.nameLabel)
        
        self.profilePhoto.topAnchor.constraint(equalTo: self.topAnchor, constant: 63).isActive = true
        self.profilePhoto.widthAnchor.constraint(equalToConstant: 70).isActive = true
        self.profilePhoto.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.profilePhoto.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.profilePhoto.layer.cornerRadius = 35
        
        self.nameLabel.topAnchor.constraint(equalTo: self.profilePhoto.bottomAnchor, constant: 10).isActive = true
        self.nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.nameLabel.sizeToFit()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
