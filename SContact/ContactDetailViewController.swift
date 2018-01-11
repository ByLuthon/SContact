//
//  ContactDetailViewController.swift
//  ContactsApplication
//
//  SwedbankDigiContact
//
//  Created by Luthon Hagvinprice on 2017-11-08.
//  Copyright © 2017 Luthon Hagvinprice. All rights reserved.
//


import UIKit
import CoreData

class ContactDetailViewController: UIViewController {
    
    var contacts: [NSManagedObject] = []
    var contact: NSManagedObject? = nil
    var isDeleted: Bool = false
    var indexPath: IndexPath? = nil
    var qrcodeImage: CIImage!
    var firstLetters: UILabel!
    
@IBOutlet weak var firstLettersLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.userInitial()
   

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        firstnameLabel.text = contact?.value(forKey:"firstname") as? String
        lastnameLabel.text = contact?.value(forKey:"lastname") as? String
        phoneLabel.text = contact?.value(forKey:"phoneNumber") as? String
        companyLabel.text = contact?.value(forKey:"company") as? String
        
       
        let data = self.contact?.value(forKey: "qrCodeData") as! NSData
        print(data)
        let image : UIImage = UIImage(data: data as Data)!
        self.qrcodeImage = CIImage(image: image)
        self.qrcodeImageView.image =  UIImage(ciImage: qrcodeImage)
        
        
        self.displayQRCodeImage()
        
       
    }
/*
    func displayQRCodeImage() {
        let scaleX = self.qrcodeImageView.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = self.qrcodeImageView.frame.size.height / qrcodeImage.extent.size.height

        let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))

        self.qrcodeImageView.image = UIImage(ciImage: transformedImage)
    }
    
    */
    
    func displayQRCodeImage() {
        let scaleX = self.qrcodeImage.extent.size.width / qrcodeImage.extent.size.width
        let scaleY = self.qrcodeImage.extent.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
       // _ = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        
        self.qrcodeImageView.image = UIImage(ciImage: transformedImage)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var qrcodeImageView: UIImageView!
    @IBOutlet weak var initialsLabel: UILabel! // Display user initials
    
 
   /* func userInitial (){
        let firstName = contact?.value(forKey: "firstname") as? String
        let lastName = contact?.value(forKey: "lastname") as? String
        let name = [firstName!] + [lastName!]
         //initialsLabel.text = name as? String
        let firstLetters = name.map { String($0.first!) }
        print(firstLetters) // ["G", "M"]
        print(name) // print fullname
    }*/
    
    
    
    @IBAction func done(_ sender: Any) {
        performSegue(withIdentifier: "unwindToContactList", sender: self)
    }
    
    
    @IBAction func deleteContact(_ sender: Any) {
        isDeleted = true
        performSegue(withIdentifier: "unwindToContactList", sender: self)
            
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContact" {
            guard let viewController = segue.destination as? AddContactViewController else { return }
            viewController.titleText = "Edit Contact"
            viewController.contact = contact
            viewController.indexPathForContact = self.indexPath!
        }
    }
  }
