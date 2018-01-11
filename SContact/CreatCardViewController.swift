//
//  CreatCardViewController.swift
//  SBusinessCard
//
//  Created by Luthon Hagvinprice on 2017-12-28.
//  Copyright © 2017 Luthon Hagvinprice. All rights reserved.
//

import UIKit
import CoreData
import Contacts
import ContactsUI

class CreatCardViewController: UIViewController {

    var contacts: [NSManagedObject] = []
    
    var titleText = "Add Contact"
    var contact: NSManagedObject? = nil
    var indexPathForContact: IndexPath? = nil
    var qrcodeImage: CIImage!
    var imageData: NSData! = nil
    
   @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveAndClose: UIBarButtonItem!
    
    // Details
    //@IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    
    
    // Work
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailAdressTextField: UITextField!
    
    //Adress
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var postcodeTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    // Social
    @IBOutlet weak var linkedinTextField: UITextField!
    @IBOutlet weak var twitterTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // PlaceHolder TExt

        firstnameTextField.attributedPlaceholder = NSAttributedString(string: "Firstname",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        lastnameTextField.attributedPlaceholder = NSAttributedString(string: "Lastname",
                                                                      attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        companyTextField.attributedPlaceholder = NSAttributedString(string: "Company",
                                                                      attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Work title",
                                                                    attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        phoneNumberTextField.attributedPlaceholder = NSAttributedString(string: "Phone",
                                                                  attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        
        emailAdressTextField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        adressTextField.attributedPlaceholder = NSAttributedString(string: "Adress",
                                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
         postcodeTextField.attributedPlaceholder = NSAttributedString(string: "Post Code",
                                                                   attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        cityTextField.attributedPlaceholder = NSAttributedString(string: "City",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        linkedinTextField.attributedPlaceholder = NSAttributedString(string: "Linkedin",
                                                                 attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        twitterTextField.attributedPlaceholder = NSAttributedString(string: "twitter",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        
    
        
        
        //titleLabel.text = titleText
        if let contact = self.contact {
            
            //fullnameTextField.text = contact.value(forKey: "fullname") as? String
            firstnameTextField.text = contact.value(forKey: "firstname") as? String
            lastnameTextField.text = contact.value(forKey: "lastname") as? String
            companyTextField.text = contact.value(forKey: "company") as? String
            
            titleTextField.text = contact.value(forKey: "title") as? String
            phoneNumberTextField.text = contact.value(forKey: "phoneNumber") as? String
            emailAdressTextField.text = contact.value(forKey: "email") as? String
            
            adressTextField.text = contact.value(forKey: "adress") as? String
            postcodeTextField.text = contact.value(forKey: "postcode") as? String
            cityTextField.text = contact.value(forKey: "city") as? String
            
            linkedinTextField.text = contact.value(forKey: "linkedin") as? String
            twitterTextField.text = contact.value(forKey: "twitter") as? String
            
        }
        // Move TextFields to keyboard. Step 1: Add tap gesture to view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// Move TextFields to keyboard. Step 7: Add observers to receive UIKeyboardWillShow and UIKeyboardWillHide notification.
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        /// Move TextFields to keyboard. Step 8: Remove observers to NOT receive notification when viewcontroller is in the background.
        removeObservers()
    }
    
    // MARK
    
    func textBasedVCard()-> Data?{
        //        let firstName = self.firstnameTextField.text!
        //        let lastName =  self.lastnameTextField.text!
        var string = "BEGIN:VCARD\nVERSION:3.0\n"
        string += "FN:\(self.firstnameTextField.text!)\nN:\(self.lastnameTextField.text!)\nORG:\(self.companyTextField.text!)\nTITLE:\(self.titleTextField.text!)\nTEL;TYPE=WORK,VOICE:\(self.phoneNumberTextField.text!)\nADR;TYPE=WORK:;;\(self.adressTextField.text!)\nPOSTALCODE:\(self.postcodeTextField.text!)\nCITY:\(self.cityTextField.text!)\nitem3.URL:\(self.linkedinTextField.text!)\nitem4.URL:\(self.twitterTextField.text!)\nEMAIL;TYPE=PREF,INTERNET:\(self.emailAdressTextField.text!)\nEND:VCARD"
        print(string)
        let utf8str = string.data(using: String.Encoding.utf8)
        if let base64Encoded = utf8str?.base64EncodedString(options: .init(rawValue: 0))
        {
            self.generateQRCode(string: string)
            return Data(base64Encoded: base64Encoded)!
        }
        return nil
    }
    
    func generateQRCode(string: String) {
        if qrcodeImage == nil {
            
            let data = string.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
            
            qrcodeImage = filter?.outputImage
            
            //displayQRCodeImage()
            
            let context:CIContext = CIContext.init(options: nil)
            let cgImage:CGImage = context.createCGImage(qrcodeImage, from: qrcodeImage.extent)!
            let image:UIImage = UIImage.init(cgImage: cgImage)
            
            self.imageData = UIImagePNGRepresentation(image)! as NSData
            print(imageData)
        }
    }
    
    @IBAction func close(_ sender: Any) {
        lastnameTextField.text = nil
        phoneNumberTextField.text = nil
        performSegue(withIdentifier: "unwindToContactList", sender: self)
        
    }
    
   
    @IBAction func cancelButton(_ sender: Any) {
        //  lastnameTextField.text = nil
        //  phoneNumberTextField.text = nil
        self.dismiss(animated: true)
    }
    
    func save(lastname: String, phoneNumber: String, company:String, firstname:String, imageData: NSData) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName:"Contact", in: managedObjectContext) else { return }
        let contact = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        contact.setValue(firstname, forKey: "firstname")
        contact.setValue(lastname, forKey: "lastname")
        contact.setValue(phoneNumber, forKey: "phoneNumber")
        contact.setValue(company, forKey: "company")
        //contact.setValue(email, forKey: "email")
        //contact.setValue(title, forKey: "title")
        //contact.setValue(adress, forKey: "adress")
        //contact.setValue(postcode, forKey: "postcode")
        // contact.setValue(city, forKey: "company")
        contact.setValue(imageData, forKey: "qrCodeData")
        do {
            try managedObjectContext.save()
            self.contacts.append(contact)
        } catch let error as NSError {
            print("Couldn't save. \(error)")
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // Move TextFields to keyboard. Step 2: Add method to handle tap event on the view and dismiss keyboard.
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        // This should hide keyboard for the view.
        view.endEditing(true)
    }
    
    
    /// Move TextFields to keyboard. Step 3: Add observers for 'UIKeyboardWillShow' and 'UIKeyboardWillHide' notification.
    func addObservers() {
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) {
            notification in
            self.keyboardWillShow(notification: notification)
        }
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil) {
            notification in
            self.keyboardWillHide(notification: notification)
        }
    }
    
    /// Move TextFields to keyboard. Step 4: Add method to handle keyboardWillShow notification, we're using this method to adjust scrollview to show hidden textfield under keyboard.
    func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        scrollView.contentInset = contentInset
    }
        
    
    /// Move TextFields to keyboard. Step 5: Method to reset scrollview when keyboard is hidden.
    func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
        
        /// Move TextFields to keyboard. Step 6: Method to remove observers.
        func removeObservers() {
            NotificationCenter.default.removeObserver(self)
        }
    
    // save and close NAvigation
    @IBAction func saveAndClose(_ sender: UIBarButtonItem) {
        let vCARD = self.textBasedVCard()
        print("vCard",vCARD!)
        performSegue(withIdentifier: "unwindToContactList", sender: self)
        
        
    }
    
    @IBAction func saveEndClose(_ sender: Any) {
        let vCARD = self.textBasedVCard()
        print("vCard",vCARD!)
        performSegue(withIdentifier: "unwindToContactList", sender: self)
        
        
    }
    
    // save and close NAvigation
    @IBAction func saveAction(_ sender: Any) {
        let vCARD = self.textBasedVCard()
        print("vCard",vCARD!)
        performSegue(withIdentifier: "unwindToContactList", sender: self)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // Set status bar to light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

}
