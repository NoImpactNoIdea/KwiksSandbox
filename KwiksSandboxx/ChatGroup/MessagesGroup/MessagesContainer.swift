//
//  ChatContainer.swift
//  KwiksProject Alpha
//
//  Created by KWIKS on 2/23/23.
//

import UIKit

class MessagesContainer: UIViewController {
    
    lazy var messageHeader : MessagesHeader = {
        
        let ch = MessagesHeader()
        ch.messagesContainer = self
        
       return ch
    }()
    
    lazy var messagesTable : MessagesTable = {
        
        let ct = MessagesTable(frame: .zero, style: .plain)
        ct.messagesContainer = self
        
        return ct
     }()
    
    var archiveHeaderLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "These chats stay archived when new messages are received. Tap to change"
        hfl.textColor = UIColor.chatTextGrey
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeRegular, size: 12)
        hfl.numberOfLines = -1
        hfl.alpha = 0.0
        
        return hfl
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.addViews()
      
    }
    
    @objc func addViews() {
        
        self.view.addSubview(self.messageHeader)
        self.view.addSubview(self.messagesTable)
        self.view.addSubview(self.archiveHeaderLabel)

        self.messageHeader.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.messageHeader.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.messageHeader.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.messageHeader.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        self.messagesTable.topAnchor.constraint(equalTo: self.messageHeader.bottomAnchor, constant: -60).isActive = true
        self.messagesTable.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.messagesTable.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.messagesTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        self.archiveHeaderLabel.topAnchor.constraint(equalTo: self.messagesTable.topAnchor, constant: 20).isActive = true
        self.archiveHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.archiveHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.archiveHeaderLabel.sizeToFit()
        
    }
    
    //on the messages controller, if a user swipes left and taps the three dots
    @objc func handleThreeDotMenu() {
        
        self.messagesTable.setEditing(false, animated: true) //closes the trash/pin/ellipsis slider in the tableview
        
        let alertSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertSheet.view.tintColor = UIColor .black
        
        let actionOne = UIAlertAction(title: "Add to family", style: .default) { res in
            print("Add to family selected")
        }
        let actionTwo = UIAlertAction(title: "Archive", style: .default) { res in
            print("Archive selected")
        }
        let actionThree = UIAlertAction(title: "Mute", style: .default) { res in
            print("Mute selected")
        }
        let actionFour = UIAlertAction(title: "Block", style: .default) { res in
            print("Block selected")
        }
        let actionFive = UIAlertAction(title: "Cancel", style: .destructive) { res in
            print("Block selected")
        }
        
        alertSheet.addAction(actionOne)
        alertSheet.addAction(actionTwo)
        alertSheet.addAction(actionThree)
        alertSheet.addAction(actionFour)
        alertSheet.addAction(actionFive)

        self.present(alertSheet, animated: true)
    }
    
    @objc func handleBackButton() {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true) //i suppose this could be presented also, need a decision
        } else {
            self.dismiss(animated: true)
        }
    }
}

