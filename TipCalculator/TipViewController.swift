//
//  TipViewController.swift
//  TipCalculator
//
//  Created by Apple on 9/18/16.
//  Copyright © 2016 Dhara Bavishi. All rights reserved.
//

import UIKit

class TipViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var txtBillAmount: UITextField!
    
    
    @IBOutlet weak var lblTipAmount: UILabel!
    
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    @IBOutlet weak var lblTipPercent: UILabel!
    
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblNoOfPerson: UILabel!
    @IBOutlet weak var lblPerPersonAmt: UILabel!
   
    @IBOutlet weak var billView: UIView!
    @IBOutlet weak var editView: UIView!
    
    @IBOutlet weak var lineViewTxt: UIView!
    @IBOutlet weak var lineView: UIView!
    var isEdit:Bool = false
    
    var noOfPerson:Int = 1
    var tipPercent:Int=15
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.BlackTranslucent
        nav?.tintColor = UIColor.whiteColor()
        
        let bill = DefaultSettings.getBillAmount()
        
        if bill == nil || bill == ""
        {
            txtBillAmount.placeholder = DefaultSettings.getFormattedNumber(0.00)
            fadeIn()
        }

        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
       
        let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {

             self.txtBillAmount.becomeFirstResponder()
        })
        let bill = DefaultSettings.getBillAmount()
        if bill != nil || bill != ""
        {
            self.txtBillAmount.text = bill
            
        }
        
        if let per:Double = DefaultSettings.getCustomPercent()
        {
            tipPercent = Int(per)
            lblTipPercent.text = "\(tipPercent)%"
        }
        if let per:Double = DefaultSettings.getCustomSplit()
        {
            noOfPerson = Int(per)
            lblNoOfPerson.text = "\(noOfPerson)"
        }
        updateLabels()

    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onTap(sender: AnyObject) {
        
        txtBillAmount.resignFirstResponder()
    }
    
    
    
    @IBAction func onChagingTipPerson(sender: UIButton) {
       
        if(sender.tag==1)
        {
            if(tipPercent==DefaultSettings.MAX_TIP_PERCENT)
            {
                tipPercent = DefaultSettings.MAX_TIP_PERCENT
            }
            else
            {
                tipPercent += 1
            }
            
        }
        else if(sender.tag==2)
        {
            if(tipPercent==DefaultSettings.MIN_TIP_PERCENT)
            {
                tipPercent = DefaultSettings.MIN_TIP_PERCENT
            }
            else
            {
                tipPercent -= 1
            }
            
        }
        else if(sender.tag==3)
        {
            if(noOfPerson==DefaultSettings.MAX_SPLIT)
            {
                noOfPerson = DefaultSettings.MAX_SPLIT
            }
            else
            {
                noOfPerson += 1
            }
            
        }
        else
        {
            if(noOfPerson==DefaultSettings.MIN_SPLIT)
            {
                noOfPerson = DefaultSettings.MIN_SPLIT
            }
            else
            {
                noOfPerson -= 1
            }
            
        }
        txtBillAmount.resignFirstResponder()
        updateLabels()
        
    }
    
    @IBAction func onBillUpdate(sender: AnyObject) {
        
        updateLabels()
        if(!isEdit)
        {
            fadeOut()
            isEdit = !isEdit
            
        }
        
    }
    
    func updateLabels(){
        
        lblTipPercent.text = "\(tipPercent)%"
        let bill = Double(txtBillAmount.text!) ?? 0
        let tip = (bill*(Double(tipPercent)))/100.0
        lblTipAmount.text = DefaultSettings.getFormattedNumber(tip)
        lblTotalAmount.text = DefaultSettings.getFormattedNumber(tip+bill)
        lblNoOfPerson.text = "\(noOfPerson)"
        lblPerPersonAmt.text = DefaultSettings.getFormattedNumber((tip+bill)/Double(noOfPerson))
        
        DefaultSettings.setBillAmount(txtBillAmount.text!)
        
        
    }
    
    func fadeIn(){
        
        let txtWidth = self.billView.frame.size.width
        UIView.animateWithDuration(0.5, animations: { () -> Void in
           
            
            self.billView.transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.billView.frame.origin.y = 150
            self.billView.frame.origin.x = -(self.billView.frame.size.width-txtWidth-30)
           
           
        
           
        })
        
        self.editView.alpha=0
        self.lblTotalAmount.alpha=0
        self.lineView.alpha=0
        self.lblTotal.alpha=0
        
       
        
    }
    func fadeOut(){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.billView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            self.billView.frame.origin.y = 64
            self.billView.frame.origin.x = 0
            self.editView.alpha=1
            self.lblTotalAmount.alpha=1
            self.lineView.alpha=1
            self.lblTotal.alpha=1
        })
        
    }
   
    
}
