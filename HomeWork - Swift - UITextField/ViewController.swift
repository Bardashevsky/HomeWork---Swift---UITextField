//
//  ViewController.swift
//  HomeWork - Swift - UITextField
//
//  Created by Oleksandr Bardashevskyi on 11/6/18.
//  Copyright © 2018 Oleksandr Bardashevskyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Outlets:
    @IBOutlet var enterOutletsFields: [UITextField]!
    @IBOutlet var infoLabels: [UILabel]!
    @IBOutlet var staticColectionLabel: [UILabel]!
    
    @IBOutlet var clearAllButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Download color and parametrs labels
        for i in 0..<self.infoLabels.count {
            self.enterOutletsFields[i].layer.masksToBounds = true
            self.enterOutletsFields[i].layer.cornerRadius = self.enterOutletsFields[i].bounds.height/5
            self.enterOutletsFields[i].layer.borderWidth = 1
            
            self.infoLabels[i].layer.masksToBounds = true
            self.infoLabels[i].layer.cornerRadius = self.infoLabels[i].bounds.height/5
            self.infoLabels[i].layer.borderWidth = 1
            self.infoLabels[i].textColor = randomColor()
            self.infoLabels[i].layer.borderColor = self.infoLabels[i].textColor.cgColor
            self.infoLabels[i].text = ""
            
            self.staticColectionLabel[i].layer.masksToBounds = true
            self.staticColectionLabel[i].layer.cornerRadius = self.staticColectionLabel[i].bounds.height/5
            self.staticColectionLabel[i].layer.borderWidth = 1
        }
        
        self.clearAllButton.layer.borderWidth = 1
        self.clearAllButton.layer.cornerRadius = 15
        self.clearAllButton.layer.borderColor = UIColor.lightGray.cgColor
        
        self.enterOutletsFields[0].becomeFirstResponder()
    }
    //MARK: - Actions:
    @IBAction func clearAllAction(_ sender: UIButton) {
        for i in self.infoLabels {
            i.text = ""
        }
        for i in self.enterOutletsFields {
            i.text = ""
        }
    }
    //MARK: - Functions:
    func randomColor() -> UIColor {
        let r = CGFloat(arc4random()%256) / CGFloat(255) + 0.4
        let g = CGFloat(arc4random()%256) / CGFloat(255) + 0.4
        let b = CGFloat(arc4random()%256) / CGFloat(255) + 0.4
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
}

//MARK: - UITextFieldDelegate:

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var count = 0
        for i in self.enterOutletsFields {
            count += 1
            switch i {
            case let enter where enter.isEqual(textField):
                return count < self.enterOutletsFields.count ? self.enterOutletsFields[count].becomeFirstResponder() : i.resignFirstResponder()
            default: break
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        for i in 0..<self.enterOutletsFields.count {
            self.infoLabels[i].text! = ""
            for j in self.enterOutletsFields[i].text! {
                if self.enterOutletsFields[i].text!.count <= 20 {
                    switch j {
                    case "a", "o", "i", "e", "u", "A", "O", "I", "E", "U":
                        self.infoLabels[i].text! += String(j)
                    case "b"..."z", "B"..."Z":
                        self.infoLabels[i].text! += String(j)
                    case "0"..."9":
                        self.infoLabels[i].text! += String(j)
                    case ".":
                        if self.infoLabels[i] == self.infoLabels[6] {
                            if !self.infoLabels[i].text!.contains(".") {
                                self.infoLabels[i].text! += String(j)
                            }
                        }
                    case "@":
                        if self.infoLabels[i] == self.infoLabels[6] {
                            if !self.infoLabels[i].text!.contains("@") {
                                self.infoLabels[i].text! += String(j)
                            }
                        }
                    default: break
                    }
                } else {
                    self.infoLabels[i].text! = "Error: 20 symbols max!"
                }
            }
        }
    }
}
