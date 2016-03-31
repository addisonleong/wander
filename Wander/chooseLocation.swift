//
//  chooseLocation.swift
//  Wander
//
//  Created by Addison Leong on 2/13/16.
//  Copyright © 2016 Dinocat. All rights reserved.
//

import Foundation
import UIKit

class chooseLocation: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var location: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBottomLineToTextField(self.location)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func addBottomLineToTextField(textField : UITextField) {
        let border = CALayer()
        let borderWidth = CGFloat(2.0)
        border.borderColor = UIColor(red: 0, green: 110/255, blue: 99/255, alpha: 1).CGColor
        border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height)
        border.borderWidth = borderWidth
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    
    @IBAction func nextPage(sender: AnyObject) {
        if (location.text == "") {
            return
        }
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mainRequest["location"] = location.text
        performSegueWithIdentifier("toTripLength", sender: self)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        let alert = UIAlertController(title: "Wait!", message: "Are you sure you want to cancel?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: { action in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { action in
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.mainRequest.removeAll()
            alert.dismissViewControllerAnimated(true, completion: nil)
            self.performSegueWithIdentifier("toHome", sender: self)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}