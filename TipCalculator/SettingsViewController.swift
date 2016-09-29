//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Apple on 9/18/16.
//  Copyright © 2016 Dhara Bavishi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    

   
    @IBOutlet weak var lblDefaultTipPercent: UILabel!
    
    @IBOutlet weak var lblSplit: UILabel!
    @IBOutlet weak var percentSlider: UISlider!
    
    @IBOutlet weak var splitSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
       

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        percentSlider.value = Float(DefaultSettings.getCustomPercent())
        splitSlider.value = Float(DefaultSettings.getCustomSplit())
        lblDefaultTipPercent.text = "\(DefaultSettings.getCustomPercent())%"
        lblSplit.text = "\(Int(DefaultSettings.getCustomSplit()))"
        
        

    }

    @IBAction func onBack(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onTap(sender: AnyObject) {
        
        self.view.endEditing(true)
    
    }
    
    @IBAction func onTipChanged(sender: UISlider) {
        
        if(sender.tag==1)
        {
            lblDefaultTipPercent.text = "\(round(sender.value))%"
            DefaultSettings.setCustomPercent(round(Double(sender.value)))
        }
        else
        {
            lblSplit.text = "\(Int(sender.value))"
            DefaultSettings.setCustomSplit(round(Double(sender.value)))
        }
       
        
    }
   
    

   

}
