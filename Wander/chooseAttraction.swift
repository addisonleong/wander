//
//  chooseAttraction.swift
//  Wander
//
//  Created by Addison Leong on 2/13/16.
//  Copyright © 2016 Dinocat. All rights reserved.
//

import Foundation
import UIKit

class chooseAttraction: UIViewController {
    
    @IBOutlet weak var destinationImage: UIButton!
    @IBOutlet weak var label: UILabel!
    var list:[String:[AnyObject]] = [String:[AnyObject]]()
    var i = 0
    var places = [AnyObject]()
    var food = [AnyObject]()
    var chosenPlaces = [AnyObject]()
    var chosenFood = [AnyObject]()
    var onfood = false
    
    override func viewWillAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        places = appDelegate.destinations["places"] as! [AnyObject]
        food = appDelegate.destinations["restaurants"] as! [AnyObject]
        let image = getProperty(0, property: "image")
        destinationImage.imageFromUrl(image)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nah(sender: AnyObject) {
        i++
        let image = getProperty(i, property: "image")
        destinationImage.imageFromUrl(image)
    }
    
    @IBAction func yeah(sender: AnyObject) {
        if (onfood == false && i < places.count) {
            chosenPlaces.append(places[i])
            if (chosenPlaces.count > 7) {
                i = places.count
                let image = getProperty(i, property: "image")
                destinationImage.imageFromUrl(image)
            }
            else {
                i++
                let image = getProperty(i, property: "image")
                destinationImage.imageFromUrl(image)
            }
        }
        else if (i - places.count + 1 < food.count) {
            chosenFood.append(food[i - places.count + 1])
            if (chosenFood.count > 3) {
                makeItinerary()
            }
            else {
                i++
                let image = getProperty(i, property: "image")
                destinationImage.imageFromUrl(image)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func getProperty(index:Int, property:String) -> String {
        if (index < places.count) {
            if let selected = places[index] as? [String: AnyObject] {
                if let property = selected[property] as? String {
                    return property
                }
            }
            
        }
        else if (index - places.count + 1 < food.count) {
            onfood = true
            label.text = "Want to eat here?"
            if let selected = food[index - places.count + 1] as? [String: AnyObject] {
                if let property = selected[property] as? String {
                    return property
                }
            }
        }
        else {
            
        }
        return ""
    }
    
    func getPropertyPlaces(index:Int, property:String) -> String {
        if (index < chosenPlaces.count) {
            if let selected = chosenPlaces[index] as? [String: AnyObject] {
                if let property = selected[property] as? String {
                    return property
                }
            }
            
        }
        return ""
    }
    
    func getPropertyFood(index:Int, property:String) -> String {
        if (index < chosenFood.count) {
            if let selected = chosenFood[index] as? [String: AnyObject] {
                if let property = selected[property] as? String {
                    return property
                }
            }
            
        }
        return ""
    }
    
    func getLocationFood(index:Int) -> String {
        if (index < chosenFood.count) {
            if let selected = chosenFood[index] as? [String: AnyObject] {
                if let property = selected["location"] as? [String: AnyObject] {
                    let location = "&dropoff[latitude]=" + String(property["lat"]) + "dropoff[longitude]=" + String(property["lng"])
                    return location
                }
            }
            
        }
        return ""
    }
    
    func getLocationPlaces(index:Int) -> String {
        if (index < chosenPlaces.count) {
            if let selected = chosenPlaces[index] as? [String: AnyObject] {
                if let property = selected["location"] as? [String: AnyObject] {
                    let location = "&dropoff[latitude]=" + String(property["lat"]!) + "&dropoff[longitude]=" + String(property["lng"]!)
                    return location
                }
            }
            
        }
        return ""
    }
    
    func makeItinerary() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var newItineraryTimes = [String]()
        newItineraryTimes.append("10:00AM - 1:30PM")
        newItineraryTimes.append("1:45PM - 3:00PM")
        newItineraryTimes.append("3:15PM - 5:15PM")
        newItineraryTimes.append("5:30PM - 7:30PM")
        newItineraryTimes.append("7:45PM - 9:45PM")
        
        var newItineraryImages = [String]()
        newItineraryImages.append(getPropertyPlaces(0, property: "image"))
        newItineraryImages.append(getPropertyFood(0, property: "image"))
        newItineraryImages.append(getPropertyPlaces(2, property: "image"))
        newItineraryImages.append(getPropertyFood(1, property: "image"))
        newItineraryImages.append(getPropertyPlaces(4, property: "image"))
        
        var newItineraryActivities = [String]()
        newItineraryActivities.append(getPropertyPlaces(0, property: "name"))
        newItineraryActivities.append(getPropertyFood(0, property: "name"))
        newItineraryActivities.append(getPropertyPlaces(2, property: "name"))
        newItineraryActivities.append(getPropertyFood(1, property: "name"))
        newItineraryActivities.append(getPropertyPlaces(4, property: "name"))
        
        let newItineraryLocations = [String]()
        newItineraryActivities.append(getLocationPlaces(0))
        newItineraryActivities.append(getLocationFood(0))
        newItineraryActivities.append(getLocationPlaces(2))
        newItineraryActivities.append(getLocationFood(1))
        newItineraryActivities.append(getLocationPlaces(4))

        appDelegate.itineraryTimes = newItineraryTimes
        appDelegate.itineraryImages = newItineraryImages
        appDelegate.itineraryActivities = newItineraryActivities
        appDelegate.itineraryLocation = newItineraryLocations
        
        performSegueWithIdentifier("toItinerary", sender: self)
    }
}

extension UIButton {
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
}

/*
var requestArray:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
requestArray["places"] = chosenPlaces
requestArray["restaurants"] = chosenFood
let request = NSMutableURLRequest(URL: NSURL(string: "https://wanderaround.herokuapp.com/itinerary")!);
var result = ""
request.HTTPMethod = "POST";
request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(requestArray, options: [])
print(requestArray)
request.HTTPShouldHandleCookies = false;
let queue:NSOperationQueue = NSOperationQueue();
NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: {
(response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
if error != nil
{

}
else
{
result = NSString(data:data!, encoding: NSUTF8StringEncoding)! as String
print(result)
}
})
*/