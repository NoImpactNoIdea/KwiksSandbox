//
//  ChatHeader.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/3/23.
//

import Foundation
import UIKit

class ChatHeader : UIView {
    
    public enum ChatStateMachine {
        case request
        case newChat
    }
    
    var chatStateMachine = ChatStateMachine.request
    
    var chatMain : ChatMain?
    
    lazy var backButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        let image = UIImage(systemName: S().backIcon, withConfiguration: config)
        cbf.setImage(image, for: UIControl.State.normal)
        cbf.tintColor = UIColor.fontBrown
        cbf.addTarget(self, action: #selector(self.handleBackButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var profilePhoto : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = UIColor (white: 0.8, alpha: 0.4)
        dcl.contentMode = .scaleAspectFill
        dcl.isUserInteractionEnabled = false
        dcl.clipsToBounds = true
        dcl.isUserInteractionEnabled = true
        dcl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleProfilePhotoTaps)))
       
        return dcl
    }()
    
    var notificationCircle : UIView = {
        
        let nc = UIView()
        nc.translatesAutoresizingMaskIntoConstraints = false
        nc.backgroundColor = UIColor .kwiksDeepGreen
        nc.layer.masksToBounds = true
        nc.layer.borderWidth = 2
        nc.layer.borderColor = UIColor .white.cgColor
        
        return nc
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
    
    var statusLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = UIColor.white
        hfl.textAlignment = .left
        hfl.font = UIFont(name: FontKit().segoeRegular, size: 15)
        hfl.isUserInteractionEnabled = true
        hfl.numberOfLines = 1
        
        return hfl
    }()
    
    lazy var phoneButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        let image = UIImage(systemName: S().phone, withConfiguration: config)
        cbf.setImage(image, for: UIControl.State.normal)
        cbf.tintColor = UIColor .black
        
        return cbf
        
    }()
    
    lazy var videoButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        let image = UIImage(systemName: S().video, withConfiguration: config)
        cbf.setImage(image, for: UIControl.State.normal)
        cbf.tintColor = UIColor .black
        
        return cbf
        
    }()
    
    lazy var ellipsisButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        let image = UIImage(systemName: S().ellipsis, withConfiguration: config)
        cbf.setImage(image, for: UIControl.State.normal)
        cbf.tintColor = UIColor.iconBrown
        
        return cbf
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.kwiksGreen
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addViews()
        
        //dummy info to delete and dynamically fill
        let stock_image = UIImage(named: "stock_photo_man")?.withRenderingMode(.alwaysOriginal)
        self.statusLabel.text = "Online"
        self.nameLabel.text = "Charlie Arcodia"
        self.profilePhoto.image = stock_image
        
    }
   
    func addViews() {
        
        self.addSubview(self.backButton)
        self.addSubview(self.profilePhoto)
        self.addSubview(self.notificationCircle)
        self.addSubview(self.nameLabel)
        self.addSubview(self.statusLabel)
        self.addSubview(self.ellipsisButton)

        self.backButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        self.backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -30).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.profilePhoto.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor).isActive = true
        self.profilePhoto.leftAnchor.constraint(equalTo: self.backButton.rightAnchor, constant: -5).isActive = true
        self.profilePhoto.heightAnchor.constraint(equalToConstant: 41).isActive = true
        self.profilePhoto.widthAnchor.constraint(equalToConstant: 41).isActive = true
        self.profilePhoto.layer.cornerRadius = 41/2
        
        self.notificationCircle.rightAnchor.constraint(equalTo: self.profilePhoto.rightAnchor, constant: -3.5).isActive = true
        self.notificationCircle.centerYAnchor.constraint(equalTo: self.profilePhoto.topAnchor, constant: 3.5).isActive = true
        self.notificationCircle.heightAnchor.constraint(equalToConstant: 10).isActive = true
        self.notificationCircle.widthAnchor.constraint(equalToConstant: 10).isActive = true
        self.notificationCircle.layer.cornerRadius = 5
        
        self.nameLabel.centerYAnchor.constraint(equalTo: self.profilePhoto.centerYAnchor, constant: -10).isActive = true
        self.nameLabel.leftAnchor.constraint(equalTo: self.profilePhoto.rightAnchor, constant: 10).isActive = true
        self.nameLabel.sizeToFit()
        
        self.statusLabel.centerYAnchor.constraint(equalTo: self.profilePhoto.centerYAnchor, constant: 10).isActive = true
        self.statusLabel.leftAnchor.constraint(equalTo: self.profilePhoto.rightAnchor, constant: 10).isActive = true
        self.statusLabel.sizeToFit()
        
        self.ellipsisButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
        self.ellipsisButton.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor).isActive = true
        self.ellipsisButton.sizeToFit()
        
        self.ellipsisButton.transform = CGAffineTransform(rotationAngle: Double.pi/2)
        
    }
    
    @objc func handleProfilePhotoTaps(sender:UIGestureRecognizer) {
        if let imageView = sender.view as? UIImageView {
            print("IMAGE: \(imageView)")
        }
    }
    
    func notificationStatus(isOnline : Bool) {
        if isOnline {
            self.notificationCircle.backgroundColor = UIColor.kwiksDeepGreen
        } else {
            self.notificationCircle.backgroundColor = UIColor .red
        }
    }
    
    @objc func handleBackButton() {
        self.chatMain?.handleBackButton()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
