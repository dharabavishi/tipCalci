//
//  DefaultSettings.swift
//  TipCalculator
//
//  Created by Apple on 9/23/16.
//  Copyright © 2016 Dhara Bavishi. All rights reserved.
//

import UIKit

class DefaultSettings: NSObject {
    
    // MAX_TIME is set 10 mins for saving the bill amount
    static let MAX_TIME = 10*60
    static let MAX_TIP_PERCENT = 30
    static let MIN_TIP_PERCENT = 0
    static let MAX_SPLIT = 10
    static let MIN_SPLIT = 1

    static let defaults = NSUserDefaults.standardUserDefaults()
    static let formatter = NSNumberFormatter()
    
    struct Constants {
        
        static let defaultPercent = "defaultPercent"
        static let lastBillAmount = "lastBillAmount"
        static let lastTimeStamp = "lastSavedTimeStamp"
        static let defaultSplit = "defaultSplit"
     
    }
    
    class func setCustomSplit(percent:Double)
    {
        defaults.setValue(percent, forKey: Constants.defaultSplit)
        defaults.synchronize()
    }
    class func getCustomSplit()->Double{
        
        let per = defaults.valueForKey(Constants.defaultSplit)
        if per == nil
        {
            defaults.setValue(1, forKey: Constants.defaultSplit)
            defaults.synchronize()
            return 1
        }
        else
        {
            return per as! Double
        }
        
    }
    
    class func setCustomPercent(percent:Double)
    {
        defaults.setValue(percent, forKey: Constants.defaultPercent)
        defaults.synchronize()
    }
    class func getCustomPercent()->Double{
        
        let per = defaults.valueForKey(Constants.defaultPercent)
        if per == nil
        {
            defaults.setValue(15, forKey: Constants.defaultPercent)
            defaults.synchronize()
            return 15
        }
        else
        {
            return per as! Double
        }
        
    }
   
    class func setBillAmount(strBill:String) {
        defaults.setValue(strBill, forKey: Constants.lastBillAmount)
        defaults.setValue(NSDate(), forKey: Constants.lastTimeStamp)
        defaults.synchronize()

    }
    class func getBillAmount()->String? {
        
        let lastTimeStamp = defaults.valueForKey(Constants.lastTimeStamp) as! NSDate?
        if lastTimeStamp==nil
        {
            return nil

        }
        else
        {
            let elapsedTime = NSDate().timeIntervalSinceDate(lastTimeStamp!)
            let duration = Int(elapsedTime)
            print(duration)

            if(duration<=MAX_TIME)
            {
                
                return defaults.valueForKey(Constants.lastBillAmount) as! String?
            }
            else
            {
                return nil
                
            }
        }
       
        
        
    }
    class func getFormattedNumber(number:Double)->String
    {
        
        formatter.numberStyle = .CurrencyStyle
        formatter.maximumFractionDigits = 2;
        let formattedStr: NSString = formatter.stringFromNumber(NSNumber(double: number))!
        return formattedStr as String
        
        
    }
    
    

}
