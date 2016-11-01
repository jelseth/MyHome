//
//  FirstViewController.swift
//  MyHome2
//
//  Created by Jake on 10/12/16.
//  Copyright © 2016 Jake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class FirstViewController: UIViewController {
    let State = false
    var Origin = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btn_DoorState(_ sender: AnyObject)
    {
        //comments
        let queue = DispatchQueue(label: "com.cnoon.response-queue", qos: .utility, attributes: [.concurrent])
        
        Alamofire.request("http://192.168.15.47", parameters: ["foo": "bar"])
            .response(
                queue: queue,
                responseSerializer: DataRequest.jsonResponseSerializer(),
                completionHandler: { response in
                    // You are now running on the concurrent `queue` you created earlier.
                    print("Parsing JSON on thread: \(Thread.current) is main thread: \(Thread.isMainThread)")
                    
                    // Validate your JSON response and convert into model objects if necessary
                    print(response.result.value)
                    
                    // To update anything on the main thread, just jump back on like so.
                    DispatchQueue.main.async {
                        
                        let JSON = SwiftyJSON.JSON(response.result.value)
                        let originJson = JSON["To"]
                        self.Origin = originJson.string!
                        let num = arc4random_uniform(100)
                        self.lbl_DoorState.text = "\(self.Origin) \(num) Hi"
                        print("Am I back on the main thread: \(Thread.isMainThread)")
                        
                    }
                }
        )

    }
    @IBOutlet weak var lbl_DoorState: UILabel!
    
}

