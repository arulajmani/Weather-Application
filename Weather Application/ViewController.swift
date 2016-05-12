//
//  ViewController.swift
//  Weather Application
//
//  Created by Arul Ajmani on 2016-02-24.
//  Copyright © 2016 Arul Ajmani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var cityTextField: UITextField!
    
    
    @IBAction func findWeather(sender: AnyObject) {
        
        var wasSucessful = false
        
        
        let attemptedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if let url = attemptedUrl {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                
                if let urlContent = data {
                    
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                    
                    if websiteArray.count > 1 {
                        
                        let weatherArray = websiteArray[1].componentsSeparatedByString("</span>")
                        
                        if weatherArray.count > 1 {
                            
                            let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º ")
                            
                            wasSucessful = true
                                                        
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                self.resultLabel.text = weatherSummary
                                
                            })
                            
                            
                        }
                        
                        
                    }
                    
                }
                
                if wasSucessful == false {
                    
                    self.resultLabel.text = "Couldn't find weather for that city, please try again"
                }
            }
            
            task.resume()
            
        } else {
            
             self.resultLabel.text = "Couldn't find weather for that city, please try again"
            
        }
    }
    
    
    @IBOutlet var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        self.view.endEditing(true)
        
    }
}

