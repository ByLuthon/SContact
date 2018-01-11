//
//  ContactDetailsCollectionViewCell.swift
//  ScardSwedbank
//
//  Created by Luthon Hagvinprice on 2017-11-23.
//  Copyright © 2017 Developer Inspirus. All rights reserved.
//
// This View Controller cardsCollcetionViewCell Displays Single Cards created by the user in the CollectionView on the CardHomeViewController
//


import UIKit
import CoreData
//import Gemini

class CardsCollectionViewCell: UICollectionViewCell {
    // UICollectionViewCell
     var isDeleted: Bool = false
    @IBOutlet var myDeleteCellView: UIView!
    @IBOutlet var myCellView: UIView!

    var contacts: [NSManagedObject] = []
    var contact: NSManagedObject? = nil
    //var isDeleted: Bool = false
    var indexPath: IndexPath? = nil
    var qrcodeImage: CIImage!
    var firstLetters: UILabel!
    
    // JUST ADDED DELET BUTTON DON't WORK YET connected to storyboad cell
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var qrcodeImageView: UIImageView!
    
    @IBOutlet weak var workTitleLabel: UILabel!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var phoneNumbersLabel: UILabel!
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
   
  
    
    func reloadData()
    {
        self.firstnameLabel.text = contact?.value(forKey:"firstname") as? String
        self.lastnameLabel.text = contact?.value(forKey:"lastname") as? String
      //  phoneLabel.text = contact?.value(forKey:"phoneNumber") as? String
        self.companyLabel.text = contact?.value(forKey:"company") as? String
        
        // QR Code Data
        let data = self.contact?.value(forKey: "qrCodeData") as! NSData
        print(data)
        let image : UIImage = UIImage(data: data as Data)!
        self.qrcodeImage = CIImage(image: image)
        self.qrcodeImageView.image =  UIImage(ciImage: qrcodeImage)
        self.displayQRCodeImage()
        
        
        
        let firstName = contact?.value(forKey: "firstname") as? String
        let lastName = contact?.value(forKey: "lastname") as? String
        let name = [firstName!] + [lastName!]
        
        //self.fullNameLabel.text = name as? String
        
        //initialsLabel.text = name as? String
        let firstLetters = name.map { String($0.first!) }
        print(firstLetters) // ["G", "M"]
        print(name) // print fullname
    
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 12.0
        self.clipsToBounds = true
    }
    
    
    func displayQRCodeImage() {
        let scaleX = self.qrcodeImage.extent.size.width / qrcodeImage.extent.size.width
        let scaleY = self.qrcodeImage.extent.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        self.qrcodeImageView.image = UIImage(ciImage: transformedImage)
    }
    
    @IBAction func deleteContact(_ sender: Any) {
        isDeleted = true
        //performSegue(withIdentifier: "unwindToContactList", sender: self)
        
    }
    
   

}












