//
//  Cards.swift
//  SBusinessCard
//
//  Created by Luthon Hagvinprice on 2017-11-25.
//  Copyright © 2017 Luthon Hagvinprice. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Cards
    
{
    // MARK: - Public API
    var title = ""
    var company = ""
    var firstName = ""
    var lastName = ""
    var initials = ""
    // var phoneNumbers = ""
    var qrCodeImage: UIImage!
    var numberOfCards = 0
    var featuredImage: UIImage!
    
    
    init (firstName: String, lastName:String, company: String, title: String, initials: String, qrCodeImage: UIImage!, featuredImage: UIImage!)
    {
        self.title = title
        self.company = company
        self.firstName = firstName
        self.lastName = lastName
        self.initials = initials
        self.qrCodeImage = qrCodeImage
        numberOfCards = 1
        self.featuredImage = featuredImage
        
    }
    
    // MARK: - Private
    // Dummy data
    static func createCards() -> [Cards]
        
    {
        return [
            Cards(firstName: "Luthon", lastName: "Hagvinprice", company:"Swedbank AB", title: "Head of Corporate innovation", initials: "HP", qrCodeImage: UIImage(named: "QR_Code_Model_1_Example")!, featuredImage: UIImage(named: "red")!),
            Cards(firstName: "Luthon", lastName: "Hagvinprice", company:"LuthCorp", title: "Founder", initials: "LH", qrCodeImage: UIImage(named: "QR_Code_Model_1_Example")!, featuredImage: UIImage(named: "lilla")!),
            Cards(firstName: "Luthon", lastName: "Hagvinprice", company:"Luthon Foundation", title: "Chairman", initials: "LH", qrCodeImage: UIImage(named: "QR_Code_Model_1_Example")!, featuredImage: UIImage(named: "green")!),
            Cards(firstName: "Luthon", lastName: "Hagvinprice", company:"Lowte AB", title: "Chief Inforamtion Officer", initials: "LH", qrCodeImage: UIImage(named: "QR_Code_Model_1_Example")!, featuredImage: UIImage(named: "blue")!),
            
        ]
    }
    
    /* // QR Code function
 
     func displayQRCodeImage() {
     let scaleX = self.qrcodeImageView.frame.size.width / qrcodeImage.extent.size.width
     let scaleY = self.qrcodeImageView.frame.size.height / qrcodeImage.extent.size.height
     
     let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
     
     self.qrcodeImageView.image = UIImage(ciImage: transformedImage)
     }
     
 */
    
    
}
