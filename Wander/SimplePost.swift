//
//  SimplePost.swift
//  Wander
//
//  Created by Addison Leong on 2/13/16.
//  Copyright © 2016 Dinocat. All rights reserved.
//

import Foundation

public func makeAPIRequest(url:String, post:[String:String]?, completion:(result:String) -> Void) {
    let request = NSMutableURLRequest(URL: NSURL(string: url)!);
    var result = ""
    request.HTTPMethod = "GET";
    if (post != nil) {
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(post!, options: [])
    }
    request.HTTPShouldHandleCookies = false;
    let queue:NSOperationQueue = NSOperationQueue();
    NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: {
        (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
        if error != nil
        {
            completion(result: "error")
        }
        else
        {
            result = NSString(data:data!, encoding: NSUTF8StringEncoding)! as String
            completion(result: result)
        }
    })
}

func makePost(params : Dictionary<String, String>, url : String) {
    let request = NSMutableURLRequest(URL: NSURL(string: url)!)
    let session = NSURLSession.sharedSession()
    request.HTTPMethod = "POST"
    
    let err: NSError?
    request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
        let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
        let err: NSError?
        let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
        print(json)
        // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
        // The JSONObjectWithData constructor didn't return an error. But, we should still
        // check and make sure that json has a value using optional binding.
        if let parseJSON = json {
            var success = parseJSON["success"] as? Int
        }
        else {
            // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
            let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
        }
    })
    task.resume()
}

public func makeBody(parameters:[String:String]?, file:NSString?, boundary:String?) -> NSData? {
    if (file == "") {
        return nil
    }
    let filename = ((file?.lastPathComponent)! as NSString)
    let fileManager = NSFileManager()
    let fileData = fileManager.contentsAtPath(file! as String)
    let body = NSMutableData()
    if (parameters != nil) {
        for (key, value) in parameters! {
            body.appendData(("--\(boundary)\r\n" as NSString).dataUsingEncoding(NSUTF8StringEncoding)!)
            body.appendData(("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n" as NSString).dataUsingEncoding(NSUTF8StringEncoding)!)
            body.appendData(("\(value)\r\n" as NSString).dataUsingEncoding(NSUTF8StringEncoding)!)
        }
    }
    if (filename != "" && fileData != nil) {
        let mime = "application/octet-stream"
        let fileKey = "file"
        body.appendData(("--\(boundary)\r\n" as NSString).dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(("Content-Disposition: form-data; name=\"\(fileKey)\"; filename=\"\(filename)\"\r\n" as String).dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(("Content-Type: \(mime)\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(fileData!)
        body.appendData(("\r\n" as NSString).dataUsingEncoding(NSUTF8StringEncoding)!)
    }
    body.appendData(("--\(boundary)--\r\n" as NSString).dataUsingEncoding(NSUTF8StringEncoding)!)
    return body
}