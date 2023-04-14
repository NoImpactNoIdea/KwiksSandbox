//
//  IndividualProfile.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/11/23.
//

import Foundation
import UIKit

class IndividualProfileChatController : UIViewController {
    
    var photoArray = [String]()

    lazy var individualCollection : IndividualCollection = {
        
        let layout = PinterestLayoutFourSquare()
        let pmcv = IndividualCollection(frame: .zero, collectionViewLayout: layout)
        pmcv.individualProfileChatController = self
        
       return pmcv
    }()
    
    lazy var changeBackgroundPopup : ChangeBackgroundPopup = {
        
        let cbpu = ChangeBackgroundPopup()
        cbpu.individualProfileChatController = self
        
       return cbpu
    }()
    
    lazy var backButton : UIButton = {
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        let image = UIImage(named: S().backIcon)?.withRenderingMode(.alwaysOriginal)
        cbf.setImage(image, for: UIControl.State.normal)
        cbf.tintColor = UIColor.fontBrown
        cbf.addTarget(self, action: #selector(self.handleBackButton), for: .touchUpInside)
        return cbf
        
    }()
    
    let backgroundImageView : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .white
        dcl.contentMode = .scaleAspectFit
        dcl.isUserInteractionEnabled = false
        dcl.clipsToBounds = true
        let image = UIImage(named: "wave_backing_graphic")?.withRenderingMode(.alwaysOriginal)
        dcl.image = image
        return dcl
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
        hfl.font = UIFont(name: FontKit().segoeSemiBold, size: 24)
        hfl.isUserInteractionEnabled = true
        hfl.numberOfLines = 1
        
        return hfl
    }()
    
    var buttonStack : UIStackView = {
        
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
    
    lazy var profileIcon : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        let image = UIImage(named: "person_icon_green")?.withRenderingMode(.alwaysOriginal)
        cbf.setImage(image, for: UIControl.State.normal)
        cbf.backgroundColor = UIColor.buttonGreyChat
        cbf.layer.masksToBounds = true
        cbf.addTarget(self, action: #selector(self.handleProfileButton(sender:)), for: .touchUpInside)
        
        return cbf
        
    }()
   
    lazy var magIcon : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        let image = UIImage(named: "mag_icon_green")?.withRenderingMode(.alwaysOriginal)
        cbf.setImage(image, for: UIControl.State.normal)
        cbf.backgroundColor = UIColor.buttonGreyChat
        cbf.layer.masksToBounds = true
        
        return cbf
        
    }()
    
    lazy var moreIcon : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        let image = UIImage(named: "ellipsis_chat_green")?.withRenderingMode(.alwaysOriginal)
        cbf.setImage(image, for: UIControl.State.normal)
        cbf.backgroundColor = UIColor.buttonGreyChat
        cbf.layer.masksToBounds = true
        
        return cbf
        
    }()
    
    var profileLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Profile"
        hfl.textColor = UIColor.kwiksMatteBlack
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeSemiBold, size: 14)
        
        return hfl
    }()
    
    var searchLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Search"
        hfl.textColor = UIColor.kwiksMatteBlack
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeSemiBold, size: 14)
        
        return hfl
    }()
    
    var moreLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "More"
        hfl.textColor = UIColor.kwiksMatteBlack
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeSemiBold, size: 14)
        
        return hfl
    }()
    
    let infoBar : UIView = {
        
        let ld = UIView()
        ld.translatesAutoresizingMaskIntoConstraints = false
        ld.backgroundColor = .clear
        
        return ld
    }()
    
    var mediaLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "More"
        hfl.textColor = UIColor.anotherMatteBlack
        hfl.textAlignment = .left
        hfl.font = UIFont(name: FontKit().segoeRegular, size: 18)
        
        return hfl
    }()
    
    var seeAllLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "See All"
        hfl.textColor = UIColor.anotherMatteBlack
        hfl.textAlignment = .right
        hfl.font = UIFont(name: FontKit().segoeRegular, size: 14)
        
        return hfl
    }()
    
    lazy var dummySeeAllButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.addTarget(self, action: #selector(self.handleSeeAllButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    let changeBackgroundCell : UIView = {
        
        let ld = UIView()
        ld.translatesAutoresizingMaskIntoConstraints = false
        ld.backgroundColor = .clear
        
        return ld
    }()
    
    let muteNotificationsCell : UIView = {
        
        let ld = UIView()
        ld.translatesAutoresizingMaskIntoConstraints = false
        ld.backgroundColor = .clear
        
        return ld
    }()
    
    var changeBackgroundLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Change Background"
        hfl.textColor = UIColor.anotherMatteBlack
        hfl.textAlignment = .left
        hfl.font = UIFont(name: FontKit().segoeRegular, size: 18)
        
        return hfl
    }()
    
    var muteNotificationLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Mute Notifications"
        hfl.textColor = UIColor.anotherMatteBlack
        hfl.textAlignment = .left
        hfl.font = UIFont(name: FontKit().segoeRegular, size: 18)
        
        return hfl
    }()
    
    lazy var forwardIcon : UIButton = {
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        let image = UIImage(named: S().backIcon)?.withRenderingMode(.alwaysOriginal)
        cbf.setImage(image, for: UIControl.State.normal)
        cbf.tintColor = UIColor.fontBrown
        return cbf
        
    }()
    
    lazy var notificationToggle : UISwitch = {
        
        let bs = UISwitch()
        bs.translatesAutoresizingMaskIntoConstraints = false
        bs.tintColor = UIColor .lightGray
        bs.thumbTintColor = UIColor .white
        bs.onTintColor = UIColor.kwiksGreen
        bs.setOn(true, animated: false)
        bs.isUserInteractionEnabled = true
        bs.isOn = false
        bs.addTarget(self, action: #selector(self.handleToggle(sender:)), for: .touchUpInside)
        return bs
        
    }()
    
    lazy var dummyChangeBackgroundButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.addTarget(self, action: #selector(self.handlePresentPopup), for: .touchUpInside)
        return cbf
        
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor .white
        self.addViews()
        self.notificationToggle.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)

        self.runDummyValues()
        
        let gest = UITapGestureRecognizer(target: self, action: #selector(self.handleSeeAllButton))
        self.individualCollection.addGestureRecognizer(gest)
    }
    
    func runDummyValues() {
        
        self.photoArray = globalPhotoArray
        self.nameLabel.text = "Charlie Arcodia"
        self.profilePhoto.loadImageGeneralUse("\(S().manThree)") { isComplete in
            print("Profile photo loaded")
        }
        
        DispatchQueue.main.async {
            self.individualCollection.reloadData()
        }
    }
    
    func addViews() {
        
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.backgroundImageView)
        self.view.addSubview(self.profilePhoto)
        self.view.addSubview(self.nameLabel)
        
        self.buttonStack.addArrangedSubview(self.profileIcon)
        self.buttonStack.addArrangedSubview(self.magIcon)
        self.buttonStack.addArrangedSubview(self.moreIcon)
        
        self.view.addSubview(self.profileLabel)
        self.view.addSubview(self.searchLabel)
        self.view.addSubview(self.moreLabel)

        self.view.addSubview(self.buttonStack)
        self.view.addSubview(self.infoBar)
        self.infoBar.addSubview(self.seeAllLabel)
        self.infoBar.addSubview(self.mediaLabel)
        self.view.addSubview(self.dummySeeAllButton)
        self.view.addSubview(self.individualCollection)
        
        self.view.addSubview(self.changeBackgroundCell)
        self.view.addSubview(self.muteNotificationsCell)
        
        self.view.addSubview(self.changeBackgroundLabel)
        self.view.addSubview(self.muteNotificationLabel)
        
        self.view.addSubview(self.forwardIcon)
        self.view.addSubview(self.notificationToggle)
        self.view.addSubview(self.dummyChangeBackgroundButton)
        
        self.view.addSubview(self.changeBackgroundPopup)

        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        self.backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.backgroundImageView.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 25).isActive = true
        self.backgroundImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.backgroundImageView.heightAnchor.constraint(equalToConstant: 192.5).isActive = true
        self.backgroundImageView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        
        self.profilePhoto.topAnchor.constraint(equalTo: self.backgroundImageView.topAnchor, constant: -20).isActive = true
        self.profilePhoto.widthAnchor.constraint(equalToConstant: 146).isActive = true
        self.profilePhoto.heightAnchor.constraint(equalToConstant: 146).isActive = true
        self.profilePhoto.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.profilePhoto.layer.cornerRadius = 73
        
        self.nameLabel.topAnchor.constraint(equalTo: self.profilePhoto.bottomAnchor, constant: 25).isActive = true
        self.nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.nameLabel.sizeToFit()
        
        self.buttonStack.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 30).isActive = true
        self.buttonStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.buttonStack.widthAnchor.constraint(equalToConstant: 210).isActive = true
        self.buttonStack.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.profileIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.profileIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.profileIcon.layer.cornerRadius = 25
        
        self.magIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.magIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.magIcon.layer.cornerRadius = 25
        
        self.moreIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.moreIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.moreIcon.layer.cornerRadius = 25
        
        self.profileLabel.centerXAnchor.constraint(equalTo: self.profileIcon.centerXAnchor).isActive = true
        self.profileLabel.topAnchor.constraint(equalTo: self.profileIcon.bottomAnchor, constant: 8).isActive = true
        self.profileLabel.sizeToFit()
        
        self.searchLabel.centerXAnchor.constraint(equalTo: self.magIcon.centerXAnchor).isActive = true
        self.searchLabel.topAnchor.constraint(equalTo: self.magIcon.bottomAnchor, constant: 8).isActive = true
        self.searchLabel.sizeToFit()

        self.moreLabel.centerXAnchor.constraint(equalTo: self.moreIcon.centerXAnchor).isActive = true
        self.moreLabel.topAnchor.constraint(equalTo: self.moreIcon.bottomAnchor, constant: 8).isActive = true
        self.moreLabel.sizeToFit()
        
        self.infoBar.topAnchor.constraint(equalTo: self.buttonStack.bottomAnchor, constant: 40).isActive = true
        self.infoBar.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 31).isActive = true
        self.infoBar.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -31).isActive = true
        self.infoBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.mediaLabel.leftAnchor.constraint(equalTo: self.infoBar.leftAnchor).isActive = true
        self.mediaLabel.centerYAnchor.constraint(equalTo: self.infoBar.centerYAnchor).isActive = true
        self.mediaLabel.sizeToFit()
        
        self.seeAllLabel.rightAnchor.constraint(equalTo: self.infoBar.rightAnchor).isActive = true
        self.seeAllLabel.centerYAnchor.constraint(equalTo: self.infoBar.centerYAnchor).isActive = true
        self.seeAllLabel.sizeToFit()
        
        self.dummySeeAllButton.centerYAnchor.constraint(equalTo: self.seeAllLabel.centerYAnchor).isActive = true
        self.dummySeeAllButton.centerXAnchor.constraint(equalTo: self.seeAllLabel.centerXAnchor).isActive = true
        self.dummySeeAllButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.dummySeeAllButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.individualCollection.topAnchor.constraint(equalTo: self.infoBar.bottomAnchor, constant: 14).isActive = true
        self.individualCollection.leftAnchor.constraint(equalTo: self.infoBar.leftAnchor, constant: -10).isActive = true
        self.individualCollection.rightAnchor.constraint(equalTo: self.infoBar.rightAnchor, constant: 10).isActive = true
        self.individualCollection.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
         self.muteNotificationsCell.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60).isActive = true
         self.muteNotificationsCell.leftAnchor.constraint(equalTo: self.infoBar.leftAnchor).isActive = true
         self.muteNotificationsCell.rightAnchor.constraint(equalTo: self.infoBar.rightAnchor).isActive = true
         self.muteNotificationsCell.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.changeBackgroundCell.bottomAnchor.constraint(equalTo: self.muteNotificationsCell.topAnchor, constant: -15).isActive = true
        self.changeBackgroundCell.leftAnchor.constraint(equalTo: self.infoBar.leftAnchor).isActive = true
        self.changeBackgroundCell.rightAnchor.constraint(equalTo: self.infoBar.rightAnchor).isActive = true
        self.changeBackgroundCell.heightAnchor.constraint(equalToConstant: 30).isActive = true
//
//        self.muteNotificationsCell.topAnchor.constraint(equalTo: self.changeBackgroundCell.bottomAnchor, constant: 22).isActive = true
//        self.muteNotificationsCell.leftAnchor.constraint(equalTo: self.infoBar.leftAnchor).isActive = true
//        self.muteNotificationsCell.rightAnchor.constraint(equalTo: self.infoBar.rightAnchor).isActive = true
//        self.muteNotificationsCell.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.changeBackgroundLabel.centerYAnchor.constraint(equalTo: self.changeBackgroundCell.centerYAnchor).isActive = true
        self.changeBackgroundLabel.leftAnchor.constraint(equalTo: self.changeBackgroundCell.leftAnchor).isActive = true
        self.changeBackgroundCell.sizeToFit()
        
        self.muteNotificationLabel.centerYAnchor.constraint(equalTo: self.muteNotificationsCell.centerYAnchor).isActive = true
        self.muteNotificationLabel.leftAnchor.constraint(equalTo: self.muteNotificationsCell.leftAnchor).isActive = true
        self.muteNotificationLabel.sizeToFit()
        
        self.forwardIcon.rightAnchor.constraint(equalTo: self.changeBackgroundCell.rightAnchor, constant: -1).isActive = true
        self.forwardIcon.centerYAnchor.constraint(equalTo: self.changeBackgroundLabel.centerYAnchor).isActive = true
        self.forwardIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true
        self.forwardIcon.widthAnchor.constraint(equalToConstant: 8).isActive = true
        self.forwardIcon.transform = CGAffineTransform(rotationAngle: .pi) //make it a forward arrow, defaults to a back arrow
        
        self.notificationToggle.centerYAnchor.constraint(equalTo: self.muteNotificationLabel.centerYAnchor).isActive = true
        self.notificationToggle.rightAnchor.constraint(equalTo: self.muteNotificationsCell.rightAnchor).isActive = true
        self.notificationToggle.sizeToFit()
        
        self.dummyChangeBackgroundButton.leftAnchor.constraint(equalTo: self.changeBackgroundCell.leftAnchor).isActive = true
        self.dummyChangeBackgroundButton.rightAnchor.constraint(equalTo: self.changeBackgroundCell.rightAnchor).isActive = true
        self.dummyChangeBackgroundButton.bottomAnchor.constraint(equalTo: self.changeBackgroundCell.bottomAnchor).isActive = true
        self.dummyChangeBackgroundButton.topAnchor.constraint(equalTo: self.changeBackgroundCell.topAnchor).isActive = true
        
        self.changeBackgroundPopup.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.changeBackgroundPopup.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.changeBackgroundPopup.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.changeBackgroundPopup.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

    }
    
    @objc func handlePresentPopup() {
        self.changeBackgroundPopup.engagePopup()
    }
    
    //make the https call to enable/disable notifications for this chat for this user
    @objc func handleToggle(sender : UISwitch) {
        
        if sender.isOn {
            print("🟢 Personal notifications on")
        } else {
            print("🟡 personal notifications off")
        }
    }
    
    //push the expanded image view over with the assets from this viewer? or maybe reload? Not sure, up to you
    @objc func handleSeeAllButton(sender:UIButton) {
        let chatMediaViewer = ChatMediaViewer()
        chatMediaViewer.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(chatMediaViewer, animated: true)
    }
    
    
    @objc func handleProfileButton(sender:UIButton) {
        
        let dynamicUserProfile = DynamicUserProfile()
        dynamicUserProfile.navigationController?.navigationBar.isHidden = true
        dynamicUserProfile.dynamicState = .random
        self.navigationController?.pushViewController(dynamicUserProfile, animated: true)
        
        
    }
    
    
    @objc func handleBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
