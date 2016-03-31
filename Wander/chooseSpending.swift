//
//  chooseSpending.swift
//  Wander
//
//  Created by Addison Leong on 2/13/16.
//  Copyright © 2016 Dinocat. All rights reserved.
//

import Foundation
import UIKit

class chooseSpending: UIViewController {
    
    @IBOutlet weak var location: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func one(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mainRequest["spending"] = "1"
        performSegueWithIdentifier("loadDestinations", sender: self)
    }
    
    @IBAction func two(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mainRequest["spending"] = "2"
        performSegueWithIdentifier("loadDestinations", sender: self)
    }
    
    @IBAction func three(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mainRequest["spending"] = "3"
        performSegueWithIdentifier("loadDestinations", sender: self)
    }
    
    @IBAction func four(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mainRequest["spending"] = "4"
        performSegueWithIdentifier("loadDestinations", sender: self)
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