//
//  ViewController.swift
//  AlertDisplayer
//
//  Created by JCTec on 06/30/2019.
//  Copyright (c) 2019 JCTec. All rights reserved.
//

import UIKit
//import AlertDisplayer

class ViewController: UIViewController {
    
    @IBOutlet weak var alertDisplayer: AlertDisplayer!
    
    var text: String! = "This is the normal label"
    var titleText: String! = "This is the title label"
    var leftText: String! = "No"
    var rightText: String? = "Yes"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        self.alertDisplayer.configureWith(self)
        
        self.view.bringSubview(toFront: self.alertDisplayer)
        // Do any additional setup after loading the view.
    }
    
}

extension ViewController: AlertDisplayerDelegate{
    
    func setUpButtons() {
        self.alertDisplayer.setUpButtons("Aceptar")
    }
    
    //Optional Method to set UIImage
    /*func setExitImage() -> UIImage? {
        return nil
    }*/
    
    func setFont(to label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 15)
    }
    
    func setBoldFont(to label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    func alertDisplayerDidLoad() {
        //Aditional Setup
        
        self.alertDisplayer.normalLabel.text = text
        self.alertDisplayer.boldLabel.text = titleText
        
        if(self.rightText != nil){
            self.alertDisplayer.setUpButtons(self.leftText, self.rightText)
        }else{
            self.alertDisplayer.setUpButtons(self.leftText)
        }
    }
    
    func didPressOk() {
        print("didPressOkDelegate")
        self.dismiss(animated: true, completion: nil)
    }
    
    func didPressCancel() {
        print("didPressCancelDelegate")
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

