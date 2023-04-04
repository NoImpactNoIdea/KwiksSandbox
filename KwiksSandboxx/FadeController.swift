//
//  FadeController.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 3/19/23.
//

import Foundation
import UIKit

class FadingController : UIViewController {
    
    lazy var kwiksFadingCollection : KwiksFadingCollection = {
        let layout = FadingLayout(scrollDirection: .vertical)
        let kfc = KwiksFadingCollection(frame: .zero, collectionViewLayout: layout)
        kfc.fadingController = self
       return kfc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.addViews()
    }
    
    func addViews() {
        
        self.view.addSubview(self.kwiksFadingCollection)
        self.kwiksFadingCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.kwiksFadingCollection.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.kwiksFadingCollection.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.kwiksFadingCollection.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true

//        self.kwiksFadingCollection.heightAnchor.constraint(equalToConstant: self.view.frame.height / 2.5).isActive = true
        
    }
}
