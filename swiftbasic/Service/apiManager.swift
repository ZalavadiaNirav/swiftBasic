//
//  apiManager.swift
//  swiftbasic
//
//  Created by Gaurav Amrutiya on 22/03/18.
//  Copyright © 2018 Gaurav Amrutiya. All rights reserved.
//

import UIKit

protocol apiDelegate : class
{
    func networkDidFinish(resultDict: NSDictionary,error: Error?,apiTag:String) -> Void
    func networkDidFail(errorMsg: String,apiTag:String) -> Void
}

typealias successCompletionHandler = (responseDict:NSDictionary?,error:NSError?,apiTag:String);

let BASEURL:String = "https:\\www.google.com"
let APINAME:String = "\\demo_form.php?"

class apiManager : NSObject , URLSessionDelegate
{
    var session:URLSession!
    weak var delegate : apiDelegate?
    
    func initSession()
    {
        session=URLSession.init(configuration: URLSessionConfiguration.default)
    }
    
    func invokedApi(requestMethodType:String,parameterDict: Dictionary<String,Any>,apiTag1:String)
    {
        self.initSession()

        var apiUrlStr:String
        var apiURLReq:URLRequest
        if(requestMethodType=="get")
        {
            apiUrlStr=self.createGetRequest(parameterDict: parameterDict)
            let apiUrl:URL=URL.init(string: "http://mockbin.org/bin/e0e378de-fe56-4859-a9e8-769db76b0ef6")!
            
            //uncomment this for real api
//            let apiUrl:URL=URL.init(string: apiUrlStr)!
            
            apiURLReq = URLRequest.init(url: apiUrl)
            self.callWebservice(apiTag: apiTag1, req: apiURLReq)
        }
    }
    
    func createGetRequest(parameterDict: Dictionary<String,Any>) -> String
    {
        var apiRequestStr:String=("\(BASEURL)\(String(describing: APINAME))")
        if (!(parameterDict.isEmpty))
        {
            for (key,value) in (parameterDict)
            {
                apiRequestStr.append("\(key)=\(value)")
                apiRequestStr.append(",")
            }
            apiRequestStr.removeLast()
        }
        return (apiRequestStr)
    }
    
    func callWebservice(apiTag:String,req:URLRequest)
    {
        var request:URLRequest=req
        request.httpMethod="get"
    
        session.dataTask(with: request)
        { (data: Data?, response: URLResponse?, error: Error?) in
            print("check=\(String(describing: data))\(String(describing: error))")

            do
            {
                if(error==nil)
                {
                    let response:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    self.delegate?.networkDidFinish(resultDict: response, error: nil,apiTag: apiTag)
                }
                else
                {
                    self.delegate?.networkDidFail(errorMsg: error.debugDescription,apiTag: apiTag)
                }
                
            }
            catch
            {
               print("in catch")
            }
        }.resume()
    }
    
}
