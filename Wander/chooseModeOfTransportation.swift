//
//  chooseModeOfTransportation.swift
//  Wander
//
//  Created by Addison Leong on 2/13/16.
//  Copyright © 2016 Dinocat. All rights reserved.
//

import Foundation
import UIKit

class chooseModeOfTransportation: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func walking(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mainRequest["transportation"] = "walking"
        performSegueWithIdentifier("toSpending", sender: self)
    }
    
    @IBAction func driving(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mainRequest["transportation"] = "driving"
        performSegueWithIdentifier("toSpending", sender: self)
    }
    
    @IBAction func bicycling(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mainRequest["transportation"] = "biking"
        performSegueWithIdentifier("toSpending", sender: self)
    }
    
    @IBAction func train(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mainRequest["transportation"] = "train"
        performSegueWithIdentifier("toSpending", sender: self)
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