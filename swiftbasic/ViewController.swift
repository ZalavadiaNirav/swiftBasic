//
//  ViewController.swift
//  swiftbasic
//
//  Created by Gaurav Amrutiya on 22/03/18.
//  Copyright © 2018 Gaurav Amrutiya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,apiDelegate {
    
    var objApiManager : apiManager = apiManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        objApiManager.delegate=self
        let parameterDict1 : Dictionary <String,Any> = ["name":"nirav","no":"222"]
        objApiManager.invokedApi(requestMethodType: "get", parameterDict: parameterDict1,apiTag1: "HOME_API")
    }

    //MARK: - network methods -

    func networkDidFinish(resultDict: NSDictionary, error: Error?,apiTag: String) {
        print("in vc tag=\(apiTag) result=\(resultDict)")
    }
    
    func networkDidFail(errorMsg: String,apiTag: String) {
        print("in vc tag=\(apiTag) error=\(errorMsg)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

