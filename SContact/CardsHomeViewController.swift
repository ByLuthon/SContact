  //
//  CardsHomeViewController.swift
//  ScardSwedbank
//
//  Created by Luthon Hagvinprice on 2017-11-25.
//  Copyright © 2017 Developer Inspirus. All rights reserved.
// This View Controller Card Home View COntroller Displays an horizontal list of created cards

import UIKit
import CoreData
//import Gemini

class CardsHomeViewController: UIViewController
        {
    
    var contacts: [NSManagedObject] = []
    var qrcodeImage: CIImage!
    var qrcodeImageView: UIImageView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    // Change UICollection View to Gemini
    @IBOutlet weak var collectionView: UICollectionView!
    //private var activeCell : UICollectionView!
    
   //CardsCollectionViewCell
    @IBOutlet weak var addCardView: UIView!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var sideViewB: UIView!
    
    // Define Cell Color
    let colored = [UIColor.darkGray, UIColor.gray,UIColor.lightGray, UIColor(red:0.96, green:0.44, blue:0.46, alpha:1.0), UIColor(red:0.75, green:0.60, blue:0.53, alpha:1.0) ,UIColor(red:1.00, green:0.38, blue:0.00, alpha:1.0), UIColor(red:1.00, green:0.60, blue:0.00, alpha:1.0), UIColor(red:0.19, green:0.51, blue:0.56, alpha:1.0), UIColor(red:1.00, green:0.80, blue:0.00, alpha:1.0), UIColor(red:0.28, green:0.58, blue:0.63, alpha:1.0)]

    
    // MARK: - IBOutlets
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // View Didload
        // Add card
        addCardView.isHidden = true
        sideView.isHidden = true
        sideViewB.isHidden = true
        //setupView()
        fetch()
        self.collectionView.reloadData()
        
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
        
        // LOAD long gesture
        
        
        
    }
    
    // Set status bar to light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.collectionView.reloadData()
    }
    

    
    //MARK: - Data Source - UiCOllection data source
    func fetch() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Contact")
        do {
            contacts = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
    }
    

    
    // Present Add contact viewcontroller when add button pressed
    @IBAction func addCardButton() {
        let vc = AddContactViewController() //
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func closeCardButton() {
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private struct Storyboard {
        static let CellIdentifier = "Cards Cell"
    }
}
  
  
  // MARK: - UIScrollViewDelegate
  extension CardsHomeViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //collectionView.animateVisibleCells()
    }
  }

  
// MARK: - UICollectionViewDataSource
extension CardsHomeViewController : UICollectionViewDataSource{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
        {
            if contacts.count > 0 {
                print("isfirstime")
                
                addCardView.isHidden = true
                sideViewB.isHidden = true
                sideView.isHidden = true
            } else {
        addCardView.isHidden = false
        sideViewB.isHidden = false
        sideView.isHidden = false
            }
            
          return contacts.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as! CardsCollectionViewCell
        //self.collectionView.animateCell(cell)
    
        
        
        let contact = contacts[indexPath.row]
        cell.backgroundColor = self.colored[indexPath.row % self.colored.count]
        cell.firstnameLabel.text = contact.value(forKey:"firstname") as? String
        cell.lastnameLabel.text = contact.value(forKey:"lastname") as? String
        cell.companyLabel.text = contact.value(forKey:"company") as? String
        
        // QR Code Data
       let data = contact.value(forKey: "qrCodeData") as! NSData
       print(data)
       let image : UIImage = UIImage(data: data as Data)!
        self.qrcodeImage = CIImage(image: image)
        cell.qrcodeImageView.image = UIImage(ciImage: qrcodeImage)
        
        print(contacts)
    
        return cell
    }

  }


extension CardsHomeViewController : UIScrollViewDelegate
{
    private func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        //targetContentOffset.memory = offset
   
    
    }
    
    // MARK FUNC BUTTONS
    
    func save(lastname: String, phoneNumber: String, company:String, firstname:String, imageData: NSData) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName:"Contact", in: managedObjectContext) else { return }
        let contact = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        contact.setValue(firstname, forKey: "firstname")
        contact.setValue(lastname, forKey: "lastname")
        contact.setValue(phoneNumber, forKey: "phoneNumber")
        contact.setValue(company, forKey: "company")
        contact.setValue(imageData, forKey: "qrCodeData")
        do {
            try managedObjectContext.save()
            self.contacts.append(contact)
        } catch let error as NSError {
            print("Couldn't save. \(error)")
        }
    }
    
    func update(indexPath: IndexPath, lastname:String, company: String,  firstname: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let contact = contacts[indexPath.row]
        contact.setValue(lastname, forKey:"lastname")
        contact.setValue(firstname, forKey: "firstname")
        contact.setValue(company, forKey: "comapny")
        do {
            try managedObjectContext.save()
            contacts[indexPath.row] = contact
        } catch let error as NSError {
            print("Couldn't update. \(error)")
        }
    }
    
    func delete(_ contact: NSManagedObject, at indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        managedObjectContext.delete(contact)
        contacts.remove(at: indexPath.row)
    }
    
    
    //Unwind segue
    @IBAction func unwindToContactList(segue: UIStoryboardSegue) {
        if let viewController = segue.source as? CreatCardViewController {
            guard let lastname: String = viewController.lastnameTextField.text, let phoneNumber: String = viewController.phoneNumberTextField.text, let company: String = viewController.companyTextField.text, let firstname: String = viewController.firstnameTextField.text, let imageData: NSData = viewController.imageData else
                
            {
                return
                
            }
            if lastname != "" && company != "" {
                if let indexPath = viewController.indexPathForContact {
                    update(indexPath: indexPath, lastname: lastname, company: company, firstname: firstname)
                } else {
                    save(lastname:lastname, phoneNumber:phoneNumber, company:company, firstname:firstname, imageData: imageData)
                }
            }
            // tableView.reloadData()
            collectionView.reloadData()
        } else if let viewController = segue.source as? ContactDetailViewController {
            if viewController.isDeleted {
                guard let indexPath: IndexPath = viewController.indexPath else { return }
                let contact = contacts[indexPath.row]
                delete(contact, at: indexPath)
                
                //tableView.reloadData()
                
                collectionView.reloadData()
                
            }
        }
    }
    
    
  }
  




