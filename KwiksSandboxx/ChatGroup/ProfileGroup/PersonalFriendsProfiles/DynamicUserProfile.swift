//
//  DynamicUserProfile.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/12/23.
//

import Foundation
import UIKit


class DynamicUserProfile : UIViewController {
    
    //trajectory entry for state machine
    enum DynamicState {
        case personal
        case follower
        case random
    }
    
    //reference to state
    var dynamicState = DynamicState.personal
    
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
        
        return hfl
    }()
    
    lazy var settingsIcon : UIButton = {
        
        let sii = UIButton(type: .system)
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.contentMode = .scaleAspectFit
        sii.isUserInteractionEnabled = true
        let image = UIImage(named: "settings_icon_personal_no_shadow")?.withRenderingMode(.alwaysOriginal)
        sii.setImage(image, for: UIControl.State.normal)
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.isUserInteractionEnabled = true
        sii.imageView?.contentMode = .scaleAspectFit
        sii.addTarget(self, action: #selector(self.handleEllipsisTap(sender:)), for: UIControl.Event.touchUpInside)
        sii.clipsToBounds = false
        sii.layer.masksToBounds = false
        sii.layer.shadowColor = UIColor .black.withAlphaComponent(0.1).cgColor
        sii.layer.shadowOpacity = 1.0
        sii.layer.shadowOffset = CGSize(width: 0, height: 7)
        sii.layer.shadowRadius = 10
        sii.layer.shouldRasterize = false
        return sii
        
    }()
    
    lazy var profilePhoto : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = UIColor (white: 0.8, alpha: 0.4)
        dcl.contentMode = .scaleAspectFill
        dcl.isUserInteractionEnabled = false
        dcl.clipsToBounds = true
        dcl.layer.borderColor = UIColor.kwiksGreen.cgColor
        dcl.layer.borderWidth = 4.0
       
        return dcl
    }()
    
    var nameLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = UIColor.black
        hfl.textAlignment = .left
        hfl.font = UIFont(name: FontKit().segoeBold, size: 20)
        hfl.isUserInteractionEnabled = true
        hfl.numberOfLines = 1
        
        return hfl
    }()
    
    var handleLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = UIColor.chatTextGrey
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeRegular, size: 14)
        hfl.isUserInteractionEnabled = true
        hfl.numberOfLines = 1
        
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
    
    var statsStack : UIStackView = {
        
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
    
    var followingLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = UIColor.chatTextGrey
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeRegular, size: 14)
        hfl.isUserInteractionEnabled = true
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
        hfl.isUserInteractionEnabled = true
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
        hfl.isUserInteractionEnabled = true
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
        hfl.isUserInteractionEnabled = true
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
        hfl.isUserInteractionEnabled = true
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
        hfl.isUserInteractionEnabled = true
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
        hfl.isUserInteractionEnabled = false
        hfl.numberOfLines = 3
        hfl.text = "Bringing a little more wander into the world, 15 seconds at a time"

        return hfl
    }()
    
    lazy var customThreeSelector : CustomThreeSelector = {
        
        let cts = CustomThreeSelector()
        cts.dynamicUserProfile = self
        
       return cts
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor .white
        self.addViews()
        self.fillDummyValues()
        
    }
    
    func fillDummyValues() {
        
        self.nameLabel.text = "Charlie Arcodia"
        self.handleLabel.text = "@v3rnalequinox"
        self.followingCountLabel.text = "450"
        self.followersCountLabel.text = "1123"
        self.likesCountLabel.text = "14.8K"

        self.profilePhoto.loadImageGeneralUse("\(S().stockPhotoURLMusician)") { isComplete in
            print("Profile photo loaded")
        }
    }
    
    func addViews() {
        
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.settingsIcon)
        self.view.addSubview(self.headerLabel)
        self.view.addSubview(self.profilePhoto)
        self.view.addSubview(self.nameLabel)
        self.view.addSubview(self.changeImageButton)
        self.view.addSubview(self.handleLabel)
        self.view.addSubview(self.editProfileButton)
        
        self.statsStack.addArrangedSubview(self.followingCountLabel)
        self.statsStack.addArrangedSubview(self.followersCountLabel)
        self.statsStack.addArrangedSubview(self.likesCountLabel)

        self.view.addSubview(self.statsStack)
        
        self.view.addSubview(self.followingLabel)
        self.view.addSubview(self.followersLabel)
        self.view.addSubview(self.likesLabel)
        self.view.addSubview(self.oneLineBioLabel)
        self.view.addSubview(self.customThreeSelector)

        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        self.backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.settingsIcon.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor, constant: 0).isActive = true
        self.settingsIcon.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true
        self.settingsIcon.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.settingsIcon.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.headerLabel.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.backButton.rightAnchor, constant: 20).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.settingsIcon.leftAnchor, constant: -20).isActive = true
        self.headerLabel.sizeToFit()
        
        self.profilePhoto.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 53).isActive = true
        self.profilePhoto.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.profilePhoto.heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.profilePhoto.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.profilePhoto.layer.cornerRadius = 150/2.0
        
        self.nameLabel.topAnchor.constraint(equalTo: self.profilePhoto.bottomAnchor, constant: 10).isActive = true
        self.nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.nameLabel.sizeToFit()
        
        self.handleLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 5).isActive = true
        self.handleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.handleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.handleLabel.sizeToFit()
        
        self.changeImageButton.centerXAnchor.constraint(equalTo: self.profilePhoto.rightAnchor, constant: -25).isActive = true
        self.changeImageButton.centerYAnchor.constraint(equalTo: self.profilePhoto.bottomAnchor, constant: -25).isActive = true
        self.changeImageButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.changeImageButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.changeImageButton.layer.cornerRadius = 20
        
        self.editProfileButton.topAnchor.constraint(equalTo: self.handleLabel.bottomAnchor, constant: 14).isActive = true
        self.editProfileButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
        self.editProfileButton.widthAnchor.constraint(equalToConstant: 135).isActive = true
        self.editProfileButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.statsStack.topAnchor.constraint(equalTo: self.editProfileButton.bottomAnchor, constant: 18).isActive = true
        self.statsStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
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
        self.oneLineBioLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.oneLineBioLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.oneLineBioLabel.sizeToFit()
        
        self.customThreeSelector.topAnchor.constraint(equalTo: self.oneLineBioLabel.bottomAnchor, constant: 38).isActive = true
        self.customThreeSelector.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.customThreeSelector.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.customThreeSelector.heightAnchor.constraint(equalToConstant: 44).isActive = true

    }
    
    
    @objc func handleEllipsisTap(sender:UIButton) {
        print(#function)
    }
    
    @objc func handleChangeImage(sender:UIButton) {
        print(#function)
    }
    
    @objc func handleEditProfileButton(sender:UIButton) {
        print(#function)
    }
    
    @objc func handleBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //from custom selector
    @objc func handlePostSelection() {
        print(#function)
    }
    @objc func handlePrivateSelection() {
        print(#function)
    }
    @objc func handleLikedSelection() {
        print(#function)
    }
}
