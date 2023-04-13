//
//  DynamicHeader.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/13/23.
//

import Foundation
import UIKit

class DynamicHeader : UIView {
    
    var dynamicUserProfile : DynamicUserProfile?
    
    lazy var backButton : UIButton = {
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        let image = UIImage(named: S().longBackIcon)?.withRenderingMode(.alwaysOriginal)
        cbf.setImage(image, for: UIControl.State.normal)
        cbf.tintColor = UIColor.fontBrown
        cbf.addTarget(self, action: #selector(self.handleBackButton), for: .touchUpInside)
        return cbf
    }()
    
    var headerLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Profile"
        hfl.textColor = UIColor.kwiksMatteBlack
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeSemiBold, size: 20)
        hfl.isUserInteractionEnabled = false

        return hfl
    }()
    
    lazy var settingsIcon : UIButton = {
        
        let sii = UIButton(type: .system)
        sii.contentMode = .scaleAspectFit
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.isUserInteractionEnabled = true
        sii.imageView?.contentMode = .scaleAspectFit
        sii.clipsToBounds = false
        sii.layer.masksToBounds = false
        sii.layer.shadowColor = UIColor .black.withAlphaComponent(0.05).cgColor
        sii.layer.shadowOpacity = 1.0
        sii.layer.shadowOffset = CGSize(width: 0, height: 7)
        sii.layer.shadowRadius = 10
        sii.layer.shouldRasterize = false
        sii.addTarget(self, action: #selector(self.handleSettingsIcon), for: UIControl.Event.touchUpInside)

        return sii
        
    }()
  
    lazy var profilePhoto : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = UIColor (white: 0.8, alpha: 0.4)
        dcl.contentMode = .scaleAspectFill
        dcl.clipsToBounds = true
        dcl.layer.borderColor = UIColor.kwiksGreen.cgColor
        dcl.layer.borderWidth = 4.0
        dcl.isUserInteractionEnabled = false

        return dcl
    }()
    
    var nameLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = UIColor.black
        hfl.textAlignment = .left
        hfl.font = UIFont(name: FontKit().segoeBold, size: 20)
        hfl.numberOfLines = 1
        hfl.isUserInteractionEnabled = false

        return hfl
    }()
    
    var handleLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = UIColor.chatTextGrey
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeRegular, size: 14)
        hfl.numberOfLines = 1
        hfl.isUserInteractionEnabled = false

        return hfl
    }()
    
    lazy var changeImageButton : UIButton = {
        
        let sii = UIButton(type: .system)
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.contentMode = .scaleAspectFit
        sii.isUserInteractionEnabled = true
        let image = UIImage(named: "photo_selection_icon")?.withRenderingMode(.alwaysOriginal)
        sii.setImage(image, for: UIControl.State.normal)
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.isUserInteractionEnabled = true
        sii.imageView?.contentMode = .scaleAspectFit
        sii.addTarget(self, action: #selector(self.handleChangeImage(sender:)), for: UIControl.Event.touchUpInside)
        
        return sii
        
    }()
  
    var alternateButtonContainer : UIView = {
        
        let abc = UIView()
        abc.translatesAutoresizingMaskIntoConstraints = false
        abc.backgroundColor = UIColor .clear
        abc.isUserInteractionEnabled = false
        
        return abc
        
    }()
   
    lazy var editProfileButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Edit Profile", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: FontKit().segoeSemiBold, size: 13)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = UIColor .white
        cbf.backgroundColor = UIColor.chatTextGrey
        cbf.tintColor = UIColor .white
        cbf.layer.cornerRadius = 5
        cbf.addTarget(self, action: #selector(self.handleEditProfileButton(sender:)), for: .touchUpInside)
        
        return cbf
        
    }()
   
    lazy var messageFriendButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Message", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: FontKit().segoeSemiBold, size: 13)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = UIColor .white
        cbf.backgroundColor = UIColor.chatTextGrey.withAlphaComponent(0.1)
        cbf.tintColor = UIColor .chatTextGrey
        cbf.layer.cornerRadius = 5
        cbf.addTarget(self, action: #selector(self.handleMessageFriendButton(sender:)), for: .touchUpInside)
        
        return cbf
        
    }()
   
    lazy var removeFriendButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "friend_delete_removal")?.withRenderingMode(.alwaysOriginal)
        cbf.setImage(image, for: .normal)
        cbf.backgroundColor = UIColor.chatTextGrey.withAlphaComponent(0.1)
        cbf.tintColor = UIColor .chatTextGrey
        cbf.layer.cornerRadius = 5
        cbf.addTarget(self, action: #selector(self.handleRemoveFriendButton(sender:)), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var followButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Follow", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: FontKit().segoeSemiBold, size: 13)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = UIColor .white
        cbf.backgroundColor = UIColor.kwiksGreen
        cbf.tintColor = UIColor .black
        cbf.layer.cornerRadius = 5
        cbf.addTarget(self, action: #selector(self.handleFollowButton(sender:)), for: .touchUpInside)
        
        return cbf
        
    }()
    
    var statsStack : UIStackView = {
        
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.alignment = .center
        sv.spacing = 12
        sv.contentMode = .scaleAspectFit
        sv.layer.zPosition = 50
        sv.isUserInteractionEnabled = false
        
        return sv
    }()
    
    var followingLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = UIColor.chatTextGrey
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeRegular, size: 14)
        hfl.numberOfLines = 1
        hfl.text = "Following"
        
        return hfl
    }()
    
    var followersLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = UIColor.chatTextGrey
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeRegular, size: 14)
        hfl.numberOfLines = 1
        hfl.text = "Followers"

        return hfl
    }()
    
    var likesLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = UIColor.chatTextGrey
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeRegular, size: 14)
        hfl.numberOfLines = 1
        hfl.text = "Likes"

        return hfl
    }()
    
    var followingCountLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = UIColor.black
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeBold, size: 25)
        hfl.numberOfLines = 1

        return hfl
    }()
    
    var followersCountLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = UIColor.black
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeBold, size: 25)
        hfl.numberOfLines = 1

        return hfl
    }()
    
    var likesCountLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = UIColor.black
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeBold, size: 25)
        hfl.numberOfLines = 1

        return hfl
    }()
    
    var oneLineBioLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = UIColor.chatTextGrey
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeRegular, size: 14)
        hfl.numberOfLines = 3

        return hfl
    }()
    
    lazy var customThreeSelector : CustomThreeSelector = {
        
        let cts = CustomThreeSelector()
        cts.dynamicUserProfile = self
        cts.isHidden = true
        
       return cts
    }()
    
    lazy var customTwoSelector : CustomTwoSelector = {
        
        let cts = CustomTwoSelector()
        cts.dynamicUserProfile = self
        cts.isHidden = true

       return cts
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addViews()
        
    }
   
    func addViews() {
        
        self.addSubview(self.backButton)
        self.addSubview(self.settingsIcon)
        self.addSubview(self.headerLabel)
        self.addSubview(self.profilePhoto)
        self.addSubview(self.nameLabel)
        self.addSubview(self.changeImageButton)
        self.addSubview(self.handleLabel)
        self.addSubview(self.editProfileButton)
        self.addSubview(self.messageFriendButton)
        self.addSubview(self.removeFriendButton)
        self.addSubview(self.followButton)

        self.statsStack.addArrangedSubview(self.followingCountLabel)
        self.statsStack.addArrangedSubview(self.followersCountLabel)
        self.statsStack.addArrangedSubview(self.likesCountLabel)

        self.addSubview(self.statsStack)
        
        self.addSubview(self.followingLabel)
        self.addSubview(self.followersLabel)
        self.addSubview(self.likesLabel)
        self.addSubview(self.oneLineBioLabel)
        self.addSubview(self.customThreeSelector)
        self.addSubview(self.customTwoSelector)
        self.addSubview(self.alternateButtonContainer)
        
         self.backButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
         self.backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
         self.backButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
         self.backButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
         
         self.settingsIcon.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor, constant: 0).isActive = true
         self.settingsIcon.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
         self.settingsIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
         self.settingsIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
         
         self.headerLabel.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor).isActive = true
         self.headerLabel.leftAnchor.constraint(equalTo: self.backButton.rightAnchor, constant: 20).isActive = true
         self.headerLabel.rightAnchor.constraint(equalTo: self.settingsIcon.leftAnchor, constant: -20).isActive = true
         self.headerLabel.sizeToFit()
         
         self.profilePhoto.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 43).isActive = true
         self.profilePhoto.widthAnchor.constraint(equalToConstant: 150).isActive = true
         self.profilePhoto.heightAnchor.constraint(equalToConstant: 150).isActive = true
         self.profilePhoto.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
         self.profilePhoto.layer.cornerRadius = 150/2.0
         
         self.nameLabel.topAnchor.constraint(equalTo: self.profilePhoto.bottomAnchor, constant: 10).isActive = true
         self.nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
         self.nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
         self.nameLabel.sizeToFit()
         
         self.handleLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 5).isActive = true
         self.handleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
         self.handleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
         self.handleLabel.sizeToFit()
         
         self.changeImageButton.centerXAnchor.constraint(equalTo: self.profilePhoto.rightAnchor, constant: -25).isActive = true
         self.changeImageButton.centerYAnchor.constraint(equalTo: self.profilePhoto.bottomAnchor, constant: -25).isActive = true
         self.changeImageButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
         self.changeImageButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
         self.changeImageButton.layer.cornerRadius = 20
         
         self.alternateButtonContainer.topAnchor.constraint(equalTo: self.handleLabel.bottomAnchor, constant: 14).isActive = true
         self.alternateButtonContainer.heightAnchor.constraint(equalToConstant: 40).isActive = true
         self.alternateButtonContainer.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
         self.alternateButtonContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
         
         self.editProfileButton.centerYAnchor.constraint(equalTo: self.alternateButtonContainer.centerYAnchor, constant: 0).isActive = true
         self.editProfileButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
         self.editProfileButton.widthAnchor.constraint(equalToConstant: 135).isActive = true
         self.editProfileButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
         
         self.followButton.centerYAnchor.constraint(equalTo: self.alternateButtonContainer.centerYAnchor, constant: 0).isActive = true
         self.followButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
         self.followButton.widthAnchor.constraint(equalToConstant: 135).isActive = true
         self.followButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
         
         self.messageFriendButton.centerYAnchor.constraint(equalTo: self.alternateButtonContainer.centerYAnchor, constant: 0).isActive = true
         self.messageFriendButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
         self.messageFriendButton.widthAnchor.constraint(equalToConstant: 135).isActive = true
         self.messageFriendButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -30).isActive = true
         
         self.removeFriendButton.centerYAnchor.constraint(equalTo: self.messageFriendButton.centerYAnchor).isActive = true
         self.removeFriendButton.leftAnchor.constraint(equalTo: self.messageFriendButton.rightAnchor, constant: 5).isActive = true
         self.removeFriendButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
         self.removeFriendButton.widthAnchor.constraint(equalToConstant: 38).isActive = true
         
         self.statsStack.topAnchor.constraint(equalTo: self.alternateButtonContainer.bottomAnchor, constant: 18).isActive = true
         self.statsStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
         self.statsStack.widthAnchor.constraint(equalToConstant: 250).isActive = true
         self.statsStack.heightAnchor.constraint(equalToConstant: 55).isActive = true
         
         self.followingCountLabel.sizeToFit()
         self.followersCountLabel.sizeToFit()
         self.likesCountLabel.sizeToFit()
         
         self.followingLabel.centerXAnchor.constraint(equalTo: self.followingCountLabel.centerXAnchor).isActive = true
         self.followingLabel.topAnchor.constraint(equalTo: self.followingCountLabel.bottomAnchor, constant: 1).isActive = true
         
         self.followersLabel.centerXAnchor.constraint(equalTo: self.followersCountLabel.centerXAnchor).isActive = true
         self.followersLabel.topAnchor.constraint(equalTo: self.followersCountLabel.bottomAnchor, constant: 1).isActive = true
         
         self.likesLabel.centerXAnchor.constraint(equalTo: self.likesCountLabel.centerXAnchor).isActive = true
         self.likesLabel.topAnchor.constraint(equalTo: self.likesCountLabel.bottomAnchor, constant: 1).isActive = true

         self.oneLineBioLabel.topAnchor.constraint(equalTo: self.statsStack.bottomAnchor, constant: 18).isActive = true
         self.oneLineBioLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
         self.oneLineBioLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
         self.oneLineBioLabel.sizeToFit()
         
         self.customThreeSelector.topAnchor.constraint(equalTo: self.oneLineBioLabel.bottomAnchor, constant: 38).isActive = true
         self.customThreeSelector.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
         self.customThreeSelector.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
         self.customThreeSelector.heightAnchor.constraint(equalToConstant: 44).isActive = true
         
         self.customTwoSelector.topAnchor.constraint(equalTo: self.oneLineBioLabel.bottomAnchor, constant: 38).isActive = true
         self.customTwoSelector.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
         self.customTwoSelector.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
         self.customTwoSelector.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
    }
    
    @objc func handleBackButton() {
        self.dynamicUserProfile?.handleBackButton()
    }
    @objc func handleSettingsIcon() {
        self.dynamicUserProfile?.handleRopRightIconTap()
    }
    
    @objc func handleChangeImage(sender:UIButton) {
        self.dynamicUserProfile?.handleChangeImage(sender: sender)
    }
    
    @objc func handleEditProfileButton(sender:UIButton) {
        self.dynamicUserProfile?.handleEditProfileButton(sender: sender)
    }
    
    @objc func handleMessageFriendButton(sender:UIButton) {
        self.dynamicUserProfile?.handleMessageFriendButton(sender: sender)
    }
    
    @objc func handleRemoveFriendButton(sender:UIButton) {
        self.dynamicUserProfile?.handleRemoveFriendButton(sender: sender)
    }
    @objc func handleFollowButton(sender:UIButton) {
        self.dynamicUserProfile?.handleFollowButton(sender: sender)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
