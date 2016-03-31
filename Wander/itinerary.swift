//
//  itinerary.swift
//  Wander
//
//  Created by Addison Leong on 2/14/16.
//  Copyright © 2016 Dinocat. All rights reserved.
//

import Foundation
import UIKit
class itinerary: UITableViewController, UIActionSheetDelegate {
    
    var selected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NSNotificationCenter.defaultCenter().addObserver(self, selector: "handler:", name: "Search", object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
//    func handler(notif: NSNotification) {
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let search = appDelegate.searchSpiel
//        if (autocomplete.contains(search)) {
//            NSNotificationCenter.defaultCenter().postNotificationName("HideAutocomplete", object: nil);
//            return
//        }
//        else {
//            NSNotificationCenter.defaultCenter().postNotificationName("ShowAutocomplete", object: nil);
//        }
//        self.tableView.reloadData()
//    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> itineraryTableCell {
        // getArrayLength()
        let cellIdentifier = "cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? itineraryTableCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("itineraryCell", owner: self, options: nil)[0] as? itineraryTableCell
        }
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        cell!.icon.imageFromUrl(appDelegate.itineraryImages[indexPath.row])
        cell!.time.text = appDelegate.itineraryTimes[indexPath.row]
        cell!.activity.text = appDelegate.itineraryActivities[indexPath.row]
        //appDelegate.itinerary
        return cell!
    }
    
    func getArrayLength() {
        
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let array = appDelegate.itinerary
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let actionSheet = UIActionSheet()
        actionSheet.title = "Get me here"
        actionSheet.delegate = self
        actionSheet.addButtonWithTitle("Cancel")
        actionSheet.addButtonWithTitle("Uber")
        actionSheet.addButtonWithTitle("Google Maps")
        actionSheet.cancelButtonIndex = 0
        selected = indexPath.row
        actionSheet.showInView(self.view)
//        if (noresult == true) {
//            return
//        }
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        appDelegate.searchSpiel = autocomplete[indexPath.row]
//        NSNotificationCenter.defaultCenter().postNotificationName("AutocompleteSearch", object: nil);
    }
    
    func actionSheet(actionSheet: UIActionSheet!, clickedButtonAtIndex buttonIndex: Int)
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        switch buttonIndex{
        case 0:
            break;
        case 1:
            let url = "uber://?action=setPickup&pickup=my_location" + appDelegate.itineraryLocation[selected]
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
            break;
        case 2:
            NSLog("Yes");
            break;
        case 3:
            NSLog("No");
            break;
        default:
            NSLog("Default");
            break;
            //Some code here..
        
    }
    }
}

/* extension UIButton {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let imageData = data as NSData? {
                    self.setBackgroundImage(UIImage(data: imageData), forState: UIControlState.Normal)
                }
            }
        }
    }
} */