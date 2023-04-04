//
//  ChatMain.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/3/23.
//

import Foundation
import UIKit

class ChatMain : UIViewController {
    
    lazy var chatHeader : ChatHeader = {
        
        let ch = ChatHeader()
        ch.chatMain = self
        
        return ch
    }()
    
    lazy var chatCollection : ChatCollection = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cm = ChatCollection(frame: .zero, collectionViewLayout: layout)
        cm.chatMain = self
        
       return cm
    }()
    
    lazy var requestView : RequestView = {
        
        let ch = RequestView()
        ch.chatMain = self
        
        return ch
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor .white
        self.addViews()
        
    }
    
    func addViews() {
        
        self.view.addSubview(self.chatHeader)
        self.view.addSubview(self.chatCollection)
        self.view.addSubview(self.requestView)

        self.chatHeader.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.chatHeader.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.chatHeader.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.chatHeader.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        self.chatCollection.topAnchor.constraint(equalTo: self.chatHeader.bottomAnchor, constant: -105).isActive = true
        self.chatCollection.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.chatCollection.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.chatCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        self.requestView.topAnchor.constraint(equalTo: self.chatCollection.topAnchor).isActive = true
        self.requestView.leftAnchor.constraint(equalTo: self.chatCollection.leftAnchor).isActive = true
        self.requestView.rightAnchor.constraint(equalTo: self.chatCollection.rightAnchor).isActive = true
        self.requestView.bottomAnchor.constraint(equalTo: self.chatCollection.bottomAnchor).isActive = true
        
    }
    
    @objc func handleBackButton() {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true) //i suppose this could be presented also, need a decision
        } else {
            self.dismiss(animated: true)
        }
    }
}
