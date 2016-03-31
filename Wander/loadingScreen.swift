//
//  loadingScreen.swift
//  Wander
//
//  Created by Addison Leong on 2/13/16.
//  Copyright © 2016 Dinocat. All rights reserved.
//

import Foundation
import UIKit

class loadingScreen: UIViewController {
    
    @IBOutlet weak var loading: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        print(appDelegate.mainRequest)
        loading.image = UIImage.animatedImageNamed("Loading", duration: 1.5)
        delay(1.5) {
            let location = "location=" + appDelegate.mainRequest["location"]!
            let transportation = "&transportation=" + appDelegate.mainRequest["transportation"]!
            let spending = "&price=" + appDelegate.mainRequest["spending"]!
            let post = location + transportation + spending
            let url = ("https://wanderaround.herokuapp.com/places?" + post).stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
            print(url)
            let request = NSMutableURLRequest(URL: NSURL(string: url!)!)
            request.HTTPMethod = "GET"
            
            let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
            
            let session = NSURLSession(configuration: sessionConfiguration)
            
            let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                let responseJSON = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.destinations = responseJSON
//                print(responseJSON)
                self.performSegueWithIdentifier("toAttractions", sender: self)
            })
            task.resume()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
}