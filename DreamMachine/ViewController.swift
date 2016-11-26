//
//  ViewController.swift
//  DreamMachine
//
//  Created by Matt Garnett on 11/26/16.
//  Copyright © 2016 Matt Garnett. All rights reserved.
//

import UIKit
import Alamofire

let API_KEY = "c668548963c587733e0075b81c41e202"

class ViewController: UIViewController {
    
    var timeUntilREM = [Int]()
    
    @IBOutlet weak var activityWheel: UIActivityIndicatorView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "segueToSleepMode") {
            
            let sleepVC = (segue.destination as! SleepViewController)
            sleepVC.timeUntilREM = timeUntilREM
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let endpoint = "https://dreammachine.herokuapp.com"
 
        let defaults = UserDefaults.standard
        if let last_time = defaults.object(forKey: "last") as? [Int] {
            timeUntilREM = last_time
        } else {
            activityWheel.startAnimating()
            activityWheel.alpha = 1
        }
        
        Alamofire.request(endpoint).responseJSON { response in
                guard let result = response.result.value as? [Int] else {
                    print("didn't get todo object as JSON from API")
                    print("Error: \(response.result.error)")
                    return
                }
            
            self.timeUntilREM = result
            self.activityWheel.stopAnimating()
            self.activityWheel.alpha = 0
            
            defaults.set(result, forKey: "last")
        
            print(response)
            
            
            /*let current = json["main"] as? NSDictionary
            if let temp = current?["temp"] as? Int {
                //temp -= 273.15
                var temp_string = String(describing: temp-273) + "°"
                self.mainLabel.text = temp_string
            } else {
                    self.mainLabel.text = "Error"
            }*/
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }


}

