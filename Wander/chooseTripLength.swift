//
//  chooseTripLength.swift
//  Wander
//
//  Created by Addison Leong on 2/13/16.
//  Copyright © 2016 Dinocat. All rights reserved.
//

import Foundation
import UIKit

class chooseTripLength: UIViewController {
    
    @IBOutlet weak var tripLengthDisplay: UILabel!
    var tripLength:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mainRequest["tripLength"] = String(tripLength)
    }
    
    @IBAction func decrement(sender: AnyObject) {
        if (tripLength > 1) {
            tripLength--
            tripLengthDisplay.text = String(tripLength)
        }
    }
    
    @IBAction func increment(sender: AnyObject) {
        if (tripLength < 10) {
            tripLength++
            tripLengthDisplay.text = String(tripLength)
        }
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