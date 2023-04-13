//
//  DynamicUserProfile.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/12/23.
//

import Foundation
import UIKit

class DynamicUserProfile : UIViewController, UIScrollViewDelegate {
    
    //trajectory entry for state machine
    enum DynamicState {
        case personal
        case follower
        case random
    }
    
    var dynamicImages = [String]()
    
    //reference to state
    var dynamicState = DynamicState.personal
    
    lazy var dynamicHeader : DynamicHeader = {
       
        let dpc = DynamicHeader()
        dpc.dynamicUserProfile = self
        
        return dpc
    }()

    lazy var dynamicProfileCollection : DynamicProfileCollection = {
       
        let layout = PinterestLayoutThreeSquare()
        let dpc = DynamicProfileCollection(frame: .zero, collectionViewLayout: layout)
        dpc.dynamicUserProfile = self
        
        return dpc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor .white
        self.addViews()
        self.fillDummyValues()
        
    }
    
    //MARK: - DUMMY DATA AND DECISION ENUM
    func fillDummyValues() {
        
        var image = UIImage()
       
        //set the UI here depending on the trajectory whether personal, following or follower
        switch self.dynamicState {
        case .personal: image = UIImage(named: "settings_icon_personal_no_shadow")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
            self.dynamicHeader.changeImageButton.isHidden = false
            self.dynamicHeader.editProfileButton.isHidden = false
            self.dynamicHeader.messageFriendButton.isHidden = true
            self.dynamicHeader.removeFriendButton.isHidden = true
            self.dynamicHeader.followButton.isHidden = true
            self.dynamicHeader.customThreeSelector.isHidden = false
            self.dynamicHeader.customTwoSelector.isHidden = true
            
        case .follower: image = UIImage(named: "ellipsis_circle_dots")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
            self.dynamicHeader.changeImageButton.isHidden = true
            self.dynamicHeader.editProfileButton.isHidden = true
            self.dynamicHeader.messageFriendButton.isHidden = false
            self.dynamicHeader.removeFriendButton.isHidden = false
            self.dynamicHeader.followButton.isHidden = true
            self.dynamicHeader.customThreeSelector.isHidden = true
            self.dynamicHeader.customTwoSelector.isHidden = false
            
        case .random: image = UIImage(named: "ellipsis_circle_dots")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
            self.dynamicHeader.changeImageButton.isHidden = true
            self.dynamicHeader.editProfileButton.isHidden = true
            self.dynamicHeader.messageFriendButton.isHidden = true
            self.dynamicHeader.removeFriendButton.isHidden = true
            self.dynamicHeader.followButton.isHidden = false
            self.dynamicHeader.customThreeSelector.isHidden = true
            self.dynamicHeader.customTwoSelector.isHidden = false
        }
        
        self.dynamicHeader.settingsIcon.setImage(image, for: .normal)

        ///dummy data
        self.dynamicImages = globalPhotoArray

        //replace me with real data
        self.dynamicHeader.nameLabel.text = "Charlie Arcodia"
        self.dynamicHeader.handleLabel.text = "@v3rnalequinox"
        self.dynamicHeader.followingCountLabel.text = "450"
        self.dynamicHeader.followersCountLabel.text = "1123"
        self.dynamicHeader.likesCountLabel.text = "14.8K"
        self.dynamicHeader.oneLineBioLabel.text = "Bringing a little more wander into the world, 15 seconds at a time"

        self.dynamicHeader.profilePhoto.loadImageGeneralUse("\(S().womanOne)") { isComplete in
            print("Profile photo loaded")
        }
    }
    
    func addViews() {

        self.view.addSubview(self.dynamicProfileCollection)
        self.dynamicProfileCollection.addSubview(self.dynamicHeader)

        //pushing the collection out slightly to match the figma
        self.dynamicProfileCollection.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.dynamicProfileCollection.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        self.dynamicProfileCollection.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        self.dynamicProfileCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.dynamicHeader.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.dynamicHeader.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.dynamicHeader.bottomAnchor.constraint(equalTo: self.dynamicProfileCollection.topAnchor, constant : -17).isActive = true
        self.dynamicHeader.heightAnchor.constraint(equalToConstant: 600).isActive = true

    }
   
    @objc func handleRopRightIconTap() {
        switch self.dynamicState {
            case .personal: print("take the user to the settings?")
            case .follower: self.handleAlert()
            case .random: self.handleAlert()
        }
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
        
        switch self.dynamicState {
            case .personal: print("Post selection from personal")
            case .follower: print("Post selection from follower")
            case .random: print("Post selection from random")
        }
    }
    @objc func handlePrivateSelection() {
        switch self.dynamicState {
            case .personal: print("Private selection from personal")
            default: print("not possible")
        }
    }
    @objc func handleLikedSelection() {
        switch self.dynamicState {
            case .personal: print("Liked selection from personal")
            case .follower: print("Liked selection from follower")
            case .random: print("Liked selection from random")
        }
    }
    @objc func handleRemoveFriendButton(sender:UIButton) {
        print(#function)
    }
    @objc func handleMessageFriendButton(sender:UIButton) {
        print(#function)
    }
    
    @objc func handleFollowButton(sender:UIButton) {
        print(#function)
    }
}

extension DynamicUserProfile {
    
    func handleAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actionOne = UIAlertAction(title: "Block", style: .default) { res in
            print("block") //handle blocking
        }
        let actionTwo = UIAlertAction(title: "Flag", style: .default) { res in
            print("flagging") //handle blocking
        }
        let actionThree = UIAlertAction(title: "Cancel", style: .destructive) { res in
            print("cancelled") //handle blocking
        }
        alertController.addAction(actionOne)
        alertController.addAction(actionTwo)
        alertController.addAction(actionThree)

        self.present(alertController, animated: true)
    }
}

