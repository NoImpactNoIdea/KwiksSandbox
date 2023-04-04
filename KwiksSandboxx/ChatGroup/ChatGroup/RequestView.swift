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
    
    var bottomContainer : UIView = {
        
        let bc = UIView()
        bc.translatesAutoresizingMaskIntoConstraints = false
        bc.backgroundColor = UIColor.requestGrey
        bc.layer.cornerRadius = 30
        
       return bc
    }()
    
    var threeButtonStack : UIStackView = {
        
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.alignment = .center
        sv.spacing = 12
        sv.contentMode = .scaleAspectFit
        sv.layer.zPosition = 50
        
        return sv
    }()
    
    lazy var acceptButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Accept", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: FontKit().segoeRegular, size: 14)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = UIColor .black
        cbf.backgroundColor = UIColor.kwiksGreen
        cbf.tintColor = UIColor .black
        cbf.layer.cornerRadius = 9
        cbf.tag = 1
        cbf.addTarget(self, action: #selector(self.handleAcceptButtons(sender:)), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var blockButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Block", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: FontKit().segoeRegular, size: 14)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = UIColor .black
        cbf.backgroundColor = UIColor.blockRed
        cbf.tintColor = UIColor .black
        cbf.layer.cornerRadius = 9
        cbf.tag = 2
        cbf.addTarget(self, action: #selector(self.handleAcceptButtons(sender:)), for: .touchUpInside)

        return cbf
        
    }()
    
    lazy var deleteButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Delete", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: FontKit().segoeRegular, size: 14)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = UIColor .black
        cbf.backgroundColor = UIColor.deleteGrey
        cbf.tintColor = UIColor .black
        cbf.layer.cornerRadius = 9
        cbf.tag = 3
        cbf.addTarget(self, action: #selector(self.handleAcceptButtons(sender:)), for: .touchUpInside)

        return cbf
        
    }()
    
    var requestDescription : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "If you accept, they will also be able to call you and see info like your activity status and when you’ve read message"
        hfl.textColor = UIColor.chatTextGrey
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeRegular, size: 12)
        hfl.numberOfLines = -1
        
        return hfl
    }()
    
    var headerLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = UIColor.headerBlack
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeRegular, size: 16)
        hfl.numberOfLines = -1
        
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
    
    lazy var viewProfileButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("View Profile", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: FontKit().segoeRegular, size: 14)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = UIColor .black
        cbf.backgroundColor = UIColor.kwiksGreen
        cbf.tintColor = UIColor.differentShadeBlack
        cbf.tag = 1
        cbf.addTarget(self, action: #selector(self.handleAcceptButtons(sender:)), for: .touchUpInside)
        
        return cbf
        
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
        self.headerLabel.text = "Accept message request from Caleb Klein?"
        self.statsLabel.text = "200 Videos   1.6M followers"
        self.headerLabel.colorFontString(text: "Accept message request from Caleb Klein?", coloredText: "Caleb Klein?", color: .black, fontName: FontKit().segoeBold, fontSize: 16)
    }
  
    func addViews() {
        
        self.addSubview(self.profilePhoto)
        self.addSubview(self.nameLabel)
        self.addSubview(self.bottomContainer)
        
        self.threeButtonStack.addArrangedSubview(self.acceptButton)
        self.threeButtonStack.addArrangedSubview(self.blockButton)
        self.threeButtonStack.addArrangedSubview(self.deleteButton)
        self.bottomContainer.addSubview(self.threeButtonStack)
        
        self.addSubview(self.requestDescription)
        self.addSubview(self.headerLabel)
        self.addSubview(self.statsLabel)
        self.addSubview(self.viewProfileButton)


        self.profilePhoto.topAnchor.constraint(equalTo: self.topAnchor, constant: 63).isActive = true
        self.profilePhoto.widthAnchor.constraint(equalToConstant: 70).isActive = true
        self.profilePhoto.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.profilePhoto.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.profilePhoto.layer.cornerRadius = 35
        
        self.nameLabel.topAnchor.constraint(equalTo: self.profilePhoto.bottomAnchor, constant: 10).isActive = true
        self.nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.nameLabel.sizeToFit()
        
        self.bottomContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.bottomContainer.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.bottomContainer.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.bottomContainer.heightAnchor.constraint(equalToConstant: 261).isActive = true
        
        self.threeButtonStack.bottomAnchor.constraint(equalTo: self.bottomContainer.bottomAnchor, constant: -60).isActive = true
        self.threeButtonStack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.threeButtonStack.widthAnchor.constraint(equalToConstant: 270).isActive = true
        self.threeButtonStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.acceptButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.acceptButton.widthAnchor.constraint(equalToConstant: 78).isActive = true
        
        self.blockButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.blockButton.widthAnchor.constraint(equalToConstant: 78).isActive = true
        
        self.deleteButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.deleteButton.widthAnchor.constraint(equalToConstant: 78).isActive = true
        
        self.requestDescription.bottomAnchor.constraint(equalTo: self.threeButtonStack.topAnchor, constant: -37).isActive = true
        self.requestDescription.leftAnchor.constraint(equalTo: self.bottomContainer.leftAnchor, constant: 30).isActive = true
        self.requestDescription.rightAnchor.constraint(equalTo: self.bottomContainer.rightAnchor, constant: -30).isActive = true
        self.requestDescription.sizeToFit()
        
        self.headerLabel.bottomAnchor.constraint(equalTo: self.requestDescription.topAnchor, constant: -20).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.bottomContainer.leftAnchor, constant: 40).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.bottomContainer.rightAnchor, constant: -40).isActive = true
        self.headerLabel.sizeToFit()
        
        self.statsLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 10).isActive = true
        self.statsLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.statsLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.statsLabel.sizeToFit()
        
        self.viewProfileButton.topAnchor.constraint(equalTo: self.statsLabel.bottomAnchor, constant: 20).isActive = true
        self.viewProfileButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.viewProfileButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.viewProfileButton.widthAnchor.constraint(equalToConstant: 108).isActive = true
        self.viewProfileButton.layer.cornerRadius = 15
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.bottomContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @objc func handleAcceptButtons(sender:UIButton) {
        
        switch sender.tag {
        case 1: print("Accept button was tapped")
        case 2: print("Block button was tapped")
        case 3: print("Delete button was tapped")
        default: print("nah")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
