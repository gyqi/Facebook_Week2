//
//  LoginViewController.swift
//  Facebook
//
//  Created by Grace Qi on 2/10/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var LogoImageView: UIImageView!
    @IBOutlet weak var FieldImageView: UIView!
    @IBOutlet weak var LabelImageView: UIView!
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginActivityIndicator: UIActivityIndicatorView!
    
    var logoInitialY: CGFloat!
    var fieldInitialY: CGFloat!
    var labelInitialY: CGFloat!
    
    var logoOffset: CGFloat!
    var fieldOffset: CGFloat!
    var labelOffset: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoInitialY = LogoImageView.frame.origin.y
        fieldInitialY = FieldImageView.frame.origin.y
        labelInitialY = LabelImageView.frame.origin.y
        
        logoOffset = -30
        fieldOffset = -70
        labelOffset = -210
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func DidTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        LogoImageView.frame.origin.y = logoInitialY + logoOffset
        FieldImageView.frame.origin.y = fieldInitialY + fieldOffset
        LabelImageView.frame.origin.y = labelInitialY + labelOffset
        
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        LogoImageView.frame.origin.y = logoInitialY
        FieldImageView.frame.origin.y = fieldInitialY
        LabelImageView.frame.origin.y = labelInitialY
    }
    
    @IBAction func pressLoginButton(sender: AnyObject) {
        self.loginActivityIndicator.startAnimating()
        loginButton.selected = true
        
        if emailField.text == "email" && passwordField.text == "password" {
            delay(2) {
                self.loginActivityIndicator.stopAnimating()
                self.loginButton.selected = false
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
            
        } else {
            delay(2) {
                self.loginActivityIndicator.stopAnimating()
                self.loginButton.selected = false
                let alertController = UIAlertController(title: "Error", message: "Please enter your email and password.", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                }
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
        }
        
    }
    
    @IBAction func editingChanged(sender: AnyObject) {
        if emailField.text!.isEmpty || passwordField.text!.isEmpty {
            loginButton.enabled = false
        } else {
            loginButton.enabled = true
        }
    }
    
    // helper function
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
