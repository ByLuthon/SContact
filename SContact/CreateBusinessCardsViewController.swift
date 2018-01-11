//
//  CreateBusinessCardsViewController.swift
//  SBusinessCard
//
//  Created by Luthon Hagvinprice on 2017-11-30.
//  Copyright © 2017 Luthon Hagvinprice. All rights reserved.
//

import UIKit

class CreateBusinessCardsViewController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet var inputsView: UIView!
    var positions = [String: CGFloat]()
    
    // @IBOutlets
        @IBOutlet weak var cancelButton: UIBarButtonItem!
     
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // config text fields
        
        firstNameTextField.autocorrectionType = .no
        lastNameTextField.autocorrectionType = .no
        companyTextField.autocorrectionType = .no
    
        
        // config keyboard show / hide observer
        NotificationCenter.default.addObserver(self, selector: Selector(("willShowKeyboard:")), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: Selector(("willHideKeyboard:")), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // store objects' initial position
        positions.updateValue(inputsView.frame.origin.y, forKey: "inputs_view")
        
    }

    
   
    
    // Dismiss view when cancel button pressed
    @IBAction func cancelButton(_ sender: Any) {
        //self.dismiss(animated: true, completion:nil)
        self.navigationController?.dismiss(animated: false, completion:nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // keyboard will showfunction
    
    func willShowKeyboard(notification: NSNotification) {
        
        print("CreateBusinessCardsViewController - willShowKeyboard")
        
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        let kbSize: CGSize = (userInfo.object(forKey: UIKeyboardFrameBeginUserInfoKey)! as AnyObject).cgRectValue.size
        print("height: \(kbSize.height), width: \(kbSize.width)")
        
        // reposition views
        UIView.animate(withDuration: 0.4, animations: {
            
            // reposition inputs view 60
            self.inputsView.frame.origin.y = 91
            
          
        })
    }
    
    // Keyboard will hide
    func willHideKeyboard(notification: NSNotification) {
        
        print("CreateBusinessCardsViewController - willHideKeyboard")
        
        // reposition views
        UIView.animate(withDuration: 0.4, animations: {
            
            // reposition inputs view
            self.inputsView.frame.origin.y = self.positions["inputs_view"]!
            
           
            
        })
    }
    
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

    
    
    
}
