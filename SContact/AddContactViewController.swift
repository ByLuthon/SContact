//
//  AddContactViewController.swift
//  ContactsApplication
//
//  SwedbankDigiContact
//
//  Created by Luthon Hagvinprice on 2017-11-08.
//  Copyright © 2017 Luthon Hagvinprice. All rights reserved.
//


import UIKit
import CoreData
import Contacts
import ContactsUI

class AddContactViewController: UIViewController, UITextFieldDelegate {
    
    var contacts: [NSManagedObject] = []
    
    var titleText = "Add Contact"
    var contact: NSManagedObject? = nil
    var indexPathForContact: IndexPath? = nil
    var qrcodeImage: CIImage!
    var imageData: NSData! = nil
    
    var activeTextField: UITextField!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
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
    
 //@IBOutlet weak var imgQRCode: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        titleLabel.text = titleText
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
        // Do any additional setup after loading the view.
    }
    
    // Set status bar to light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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

//        if let data = string.data(using: .utf8) {
//            let contacts = CNContactVCardSerialization.contacts(with: data)
//            let contact = contacts.first
//            print("\(String(describing: contact?.familyName))")
//        }
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

    
    // MARK: Custom method implementation
    
/*
    func displayQRCodeImage() {
        let scaleX = imgQRCode.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = imgQRCode.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        imgQRCode.image = UIImage(ciImage: transformedImage)
    }
    */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

        
        @IBAction func saveButton(_ sender: Any) {
           // _ = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! CardsHomeViewController
            //self.dismiss(animated: true, completion: nil)
           
            guard let lastname:String = lastnameTextField.text else {
                print("no lastname")
                return
            }
            guard let phoneNumber: String = phoneNumberTextField.text else {
                 print("no phone")
                return
            }
            guard let company: String = companyTextField.text else {
                print("no company ")
                return
            }
            guard let firstname: String = firstnameTextField.text else {
                print("no firstname")
                return
            }
            guard let imageData: NSData = imageData else {
                print("no iamge")
                return
            }
            
           
 
            save(lastname:lastname, phoneNumber:phoneNumber, company:company, firstname:firstname, imageData: imageData)
           print ("ok")
            
            
            
            _ = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! CardsHomeViewController
            self.dismiss(animated: true, completion: nil)
                
            }
    /*
     ///
     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
     
     let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("nextView") as NextViewController
     self.presentViewController(nextViewController, animated:true, completion:nil)
     _ = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! CardsHomeViewController
     //
     navigationController?.pushViewController(myVC, animated: true)
     //self.present(myVC, animated:true, completion:nil)
     self.dismiss(animated: true, completion: nil)
     
     ///
     */
    
    
    
    // save and close NAvigation
    @IBAction func saveAndClose(_ sender: Any) {
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
    
    
    
}


