//
//  AlertDisplayer.swift
//  AlertDisplayer
//  
//  Created by Juan Carlos Estevez on 5/28/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation
import UIKit

protocol AlertDisplayerDelegate: class {
    func setExitImage() -> UIImage?
    func setUpButtons()
    
    func setFont(to label: UILabel)
    func setBoldFont(to label: UILabel)
    func alertDisplayerDidLoad()
    func didPressOk()
    func didPressCancel()
}

extension AlertDisplayerDelegate{
    func setExitImage() -> UIImage?{
        return nil
    }
}

@available(iOS 10.3, *)
class AlertDisplayer: UIView{
    
    public var mainColor: UIColor = UIColor.white
    
    public var decorations: UIColor = UIColor(red:0.24, green:0.84, blue:0.44, alpha:1)
    
    public var exitImage: UIImage?
    
    public var width: CGFloat = 350.0
    
    public var height: CGFloat = 210.0
    
    public var buttonHeight: CGFloat = 60.0
    
    public var cornerRadius: CGFloat = 25.0
    
    public var contentView: UIView!
    public var alertView: UIView!
    public var shadowView: UIView!
    public var buttonStack: UIStackView!
    public var mainStack: UIStackView!
    public var topView: UIView!
    
    public lazy var leftButton: UIButton! = {
        let button = UIButton()
        button.addTarget(self, action: #selector(self.didSelectLeft), for: .touchUpInside)
        return button
    }()
    
    public lazy var rightButton: UIButton! = {
        let button = UIButton()
        button.addTarget(self, action: #selector(self.didSelectRight), for: .touchUpInside)
        return button
    }()
    
    public var boldLabel: UILabel!
    public var normalLabel: UILabel!
    public var normalLabelForUserInterface: UILabel!
    public var imageView: UIImageView!
    
    weak var delegate: AlertDisplayerDelegate!
    
    private var heightConstraint: NSLayoutConstraint!
    private var widthConstraint: NSLayoutConstraint!
    private var topBorder: UIView!
    private var leftBorder: UIView!
    private var rightBorder: UIView!
    
    private var constraintsToAdd: [NSLayoutConstraint] = [NSLayoutConstraint]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
        
    }
    
    private func commonInit(){
        self.contentView = UIView()
        self.alertView = UIView()
        self.shadowView = UIView()
        self.topView = UIView()
        self.boldLabel = UILabel()
        self.normalLabel = UILabel()
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        self.buttonStack = UIStackView(arrangedSubviews: [self.leftButton, self.rightButton])
        self.buttonStack.axis = NSLayoutConstraint.Axis.horizontal
        self.buttonStack.distribution = .fillEqually
        self.buttonStack.alignment = .fill
        self.buttonStack.spacing = 0
        self.buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        self.mainStack = UIStackView(arrangedSubviews: [self.topView, self.buttonStack])
        self.mainStack.axis = NSLayoutConstraint.Axis.vertical
        self.mainStack.spacing = 0
        self.mainStack.translatesAutoresizingMaskIntoConstraints = false
        self.mainStack.layer.cornerRadius = self.cornerRadius
        
        self.shadowView.translatesAutoresizingMaskIntoConstraints = false
        self.shadowView.backgroundColor = .whiteClear
        self.shadowView.addSubview(self.alertView)
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.shadowView)
        
        self.widthConstraint = self.shadowView.widthAnchor.constraint(equalToConstant: self.width)
        self.heightConstraint = self.shadowView.heightAnchor.constraint(equalToConstant: self.height)
        
        self.alertView.backgroundColor = self.mainColor
        self.alertView.layer.cornerRadius = self.cornerRadius
        self.alertView.translatesAutoresizingMaskIntoConstraints = false
        self.alertView.addSubview(self.mainStack)
        
        self.topView.backgroundColor = .whiteClear
        self.topView.translatesAutoresizingMaskIntoConstraints = false
        self.topView.addSubview(self.boldLabel)
        self.topView.addSubview(self.normalLabel)
        
        self.boldLabel.translatesAutoresizingMaskIntoConstraints = false
        self.boldLabel.textAlignment = .center
        self.boldLabel.font = UIFont.systemFont(ofSize: 19.5, weight: .bold)
        
        self.normalLabel.translatesAutoresizingMaskIntoConstraints = false
        self.normalLabel.textAlignment = .center
        self.normalLabel.font = UIFont.systemFont(ofSize: 15)
        
        self.setUpBorders()
        self.setUpButtons("No", "Si")
        
        self.setUpSpace(for: self.boldLabel, "Este es el titulo Bold")
        self.setUpSpace(for: self.normalLabel, "Este es el titulo normal")
        
        self.rightButton.backgroundColor = .whiteClear
        self.rightButton.setTitleColor(self.decorations, for: .normal)
        
        self.leftButton.backgroundColor = .whiteClear
        self.leftButton.setTitleColor(self.decorations, for: .normal)
        
        self.setUpConstraints()
        
        self.addSubview(self.contentView)
        self.bringSubview(toFront: self.contentView)
        self.contentView.bringSubview(toFront: self.shadowView)
    }
    
    func configureWith(_ delegate: AlertDisplayerDelegate){
        self.delegate = delegate
        self.delegate?.setUpButtons()
        self.delegate?.setBoldFont(to: self.boldLabel)
        self.delegate?.setFont(to: self.normalLabel)
        self.delegate?.alertDisplayerDidLoad()
        
        self.exitImage = self.delegate?.setExitImage()
        
        if(self.exitImage != nil){
            self.imageView = UIImageView(image: self.exitImage!)
            self.imageView.clipsToBounds = true
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.imageView.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.didSelectLeft))
            tap.cancelsTouchesInView = true
            
            self.imageView.addGestureRecognizer(tap)
            self.constraintsToAdd.append(self.imageView.widthAnchor.constraint(equalToConstant: 50))
            self.constraintsToAdd.append(self.imageView.heightAnchor.constraint(equalToConstant: 50))
            
            self.shadowView.addSubview(self.imageView)
            self.shadowView.bringSubview(toFront: self.imageView)
            
            self.constraintsToAdd.append(self.imageView.centerYAnchor.constraint(equalTo: self.shadowView.topAnchor, constant: 5.0))
            self.constraintsToAdd.append(self.imageView.centerXAnchor.constraint(equalTo: self.shadowView.trailingAnchor, constant: -5.0))
        }
        
        NSLayoutConstraint.activate(self.constraintsToAdd)
    }
    
    @objc func didSelectLeft(){
        print("didPressCancel")
        delegate?.didPressCancel()
    }
    
    @objc func didSelectRight(){
        print("didPressOk")
        delegate?.didPressOk()
    }
    
    func setUpButtons(_ first: String!, _ second: String? = nil){
        
        if(second == nil){
            self.leftButton.isHidden = true
            self.rightButton.setTitle(first, for: .normal)
            
            self.rightBorder.backgroundColor = .whiteClear
            self.leftBorder.backgroundColor = .whiteClear
            
            self.rightButton.constraints.forEach { (constraint) in
                if constraint.firstAttribute == .height{
                    constraint.constant = self.buttonStack.frame.width
                }
            }
            
        }else{
            self.leftButton.isHidden = false
            self.rightButton.setTitle(second, for: .normal)
            self.leftButton.setTitle(first, for: .normal)
            
            self.rightBorder.backgroundColor = self.decorations
            self.leftBorder.backgroundColor = self.decorations
            
            self.rightButton.constraints.forEach { (constraint) in
                if constraint.firstAttribute == .height{
                    constraint.constant = self.buttonStack.frame.width / 2
                }
            }
            
            self.leftButton.constraints.forEach { (constraint) in
                if constraint.firstAttribute == .height{
                    constraint.constant = self.buttonStack.frame.width / 2
                }
            }
        }
        
    }
    
    
    private func setUpSpace(for label: UILabel, _ text: String = ""){
        label.text = text
        
        let size = CGSize(width: label.frame.width, height: .infinity)
        let estimatedSize = label.sizeThatFits(size)
        
        label.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height + 5.0
            }
        }
    }
}

@available(iOS 10.3, *)
extension AlertDisplayer{
    
    private func setUpBorders(){
        self.topBorder = self.buttonStack.addBordersAlert(edges: .top, color: self.decorations, inset: 0.0, thickness: 1.0).first!
        self.leftBorder = self.leftButton.addBordersAlert(edges: .right, color: self.decorations, inset: 0.0, thickness: 0.5).first!
        self.rightBorder = self.rightButton.addBordersAlert(edges: .left, color: self.decorations, inset: 0.0, thickness: 0.5).first!
    }
    
    private func setUpConstraints(){
        self.constraintsToAdd.append(self.contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0))
        self.constraintsToAdd.append(self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0))
        self.constraintsToAdd.append(self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0))
        self.constraintsToAdd.append(self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0))
        
        self.constraintsToAdd.append(self.shadowView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0))
        self.constraintsToAdd.append(self.shadowView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0))
        
        self.constraintsToAdd.append(self.widthConstraint)
        self.constraintsToAdd.append(self.heightConstraint)
        
        self.constraintsToAdd.append(self.alertView.topAnchor.constraint(equalTo: self.shadowView.topAnchor, constant: 0.0))
        self.constraintsToAdd.append(self.alertView.bottomAnchor.constraint(equalTo: self.shadowView.bottomAnchor, constant: 0.0))
        self.constraintsToAdd.append(self.alertView.leadingAnchor.constraint(equalTo: self.shadowView.leadingAnchor, constant: 0.0))
        self.constraintsToAdd.append(self.alertView.trailingAnchor.constraint(equalTo: self.shadowView.trailingAnchor, constant: 0.0))
        
        self.constraintsToAdd.append(self.mainStack.topAnchor.constraint(equalTo: self.alertView.topAnchor, constant: 0.0))
        self.constraintsToAdd.append(self.mainStack.bottomAnchor.constraint(equalTo: self.alertView.bottomAnchor, constant: 0.0))
        self.constraintsToAdd.append(self.mainStack.leadingAnchor.constraint(equalTo: self.alertView.leadingAnchor, constant: 0.0))
        self.constraintsToAdd.append(self.mainStack.trailingAnchor.constraint(equalTo: self.alertView.trailingAnchor, constant: 0.0))
        
        self.constraintsToAdd.append(self.topView.widthAnchor.constraint(equalTo: self.mainStack.widthAnchor, multiplier: 1.0))
        
        self.constraintsToAdd.append(self.buttonStack.heightAnchor.constraint(equalToConstant: 100))
        
        self.constraintsToAdd.append(self.boldLabel.bottomAnchor.constraint(equalTo: self.normalLabel.topAnchor, constant: 5.0))
        self.constraintsToAdd.append(self.boldLabel.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor, constant: 10.0))
        self.constraintsToAdd.append(self.boldLabel.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor, constant: -10.0))
        self.constraintsToAdd.append(self.boldLabel.heightAnchor.constraint(equalToConstant: 50))
        
        self.constraintsToAdd.append(self.normalLabel.centerYAnchor.constraint(equalTo: self.topView.centerYAnchor, constant: 30.0))
        self.constraintsToAdd.append(self.normalLabel.heightAnchor.constraint(equalToConstant: 50))
        self.constraintsToAdd.append(self.normalLabel.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor, constant: 10.0))
        self.constraintsToAdd.append(self.normalLabel.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor, constant: -10.0))
        
        
        self.constraintsToAdd.append(self.leftButton.heightAnchor.constraint(equalToConstant: 50))
        self.constraintsToAdd.append(self.rightButton.heightAnchor.constraint(equalToConstant: 50))
        self.constraintsToAdd.append(self.buttonStack.heightAnchor.constraint(equalToConstant: 50))
        
    }
    
}
