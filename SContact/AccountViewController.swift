//
//  AccountViewController.swift
//  SBusinessCard
//
//  Created by Luthon Hagvinprice on 2017-12-04.
//  Copyright © 2017 Luthon Hagvinprice. All rights reserved.
//
//
//  AccountViewController.swift
//  ios8_carousel
//
//  Created by Stanley Ng on 9/11/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
   // @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var createTextImageView: UIImageView!
    @IBOutlet weak var inputsView: UIView!
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var positions = [String: CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // config text fields
        firstNameTextField.autocorrectionType = .no
        lastNameTextField.autocorrectionType = .no
        emailTextField.autocorrectionType = .no
        
        // config keyboard show / hide observer
        NotificationCenter.default.addObserver(self, selector: Selector(("willShowKeyboard:")), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: Selector(("willHideKeyboard:")), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // store objects' initial position
        positions.updateValue(createTextImageView.frame.origin.y, forKey: "create_text")
        positions.updateValue(inputsView.frame.origin.y, forKey: "inputs_view")
        positions.updateValue(actionView.frame.origin.y, forKey: "action_view")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
   /* @IBAction func onCheck(sender: UIButton) {
        checkButton.isSelected = !checkButton.isSelected
    }*/
    
    func willShowKeyboard(notification: NSNotification) {
        
        print("AccountViewController - willShowKeyboard")
        
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        let kbSize: CGSize = (userInfo.object(forKey: UIKeyboardFrameBeginUserInfoKey)! as AnyObject).cgRectValue.size
        print("height: \(kbSize.height), width: \(kbSize.width)")
        
        // reposition views
        UIView.animate(withDuration: 0.4, animations: {
            
            // reposition login text
            self.createTextImageView.frame.origin.y = 0
            
            // reposition inputs view
            self.inputsView.frame.origin.y = 60
            
            // reposition action view
            self.actionView.frame.origin.y = kbSize.height + 80
            
        })
    }
    
    func willHideKeyboard(notification: NSNotification) {
        
        print("AccountViewController - willHideKeyboard")
        
        // reposition views
        UIView.animate(withDuration: 0.4, animations: {
            
            // reposition login text
            self.createTextImageView.frame.origin.y = self.positions["create_text"]!
            
            // reposition inputs view
            self.inputsView.frame.origin.y = self.positions["inputs_view"]!
            
            // reposition action view
            self.actionView.frame.origin.y = self.positions["action_view"]!
            
        })
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

