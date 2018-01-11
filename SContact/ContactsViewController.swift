//
//  ContactsViewController.swift
//  ContactsApplication
//
//  SwedbankDigiContact
//
//  Created by Luthon Hagvinprice on 2017-11-08.
//  Copyright © 2017 Luthon Hagvinprice. All rights reserved.
//

import UIKit
import CoreData
//import Gemini

class ContactsViewController: UITableViewController {
    
    var contacts: [NSManagedObject] = []
      var isDeleted: Bool = false
     private var activeCell : CardsCollectionViewCell!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Data Source
    
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
    
    // Dismiss view when cancel button pressed
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
         //fetch()
        self.dismiss(animated: true)
    }
    
    @IBAction func done(_ sender: Any) {
        
        performSegue(withIdentifier: "unwindToContactList", sender: self)
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
        contact.setValue(imageData, forKey: "qrCodeData")
        do {
            try managedObjectContext.save()
            self.contacts.append(contact)
        } catch let error as NSError {
            print("Couldn't save. \(error)")
        }
    }
    
    func update(indexPath: IndexPath, lastname:String, phoneNumber: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let contact = contacts[indexPath.row]
        contact.setValue(lastname, forKey:"lastname")
        contact.setValue(phoneNumber, forKey: "phoneNumber")
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // TABLE VIEW CELL
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        
        let contact = contacts[indexPath.row]
        
        cell.textLabel?.text = contact.value(forKey:"lastname") as? String
        cell.detailTextLabel?.text = contact.value(forKey:"phoneNumber") as? String
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            let contact = contacts[indexPath.row]
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedObjectContext = appDelegate.persistentContainer.viewContext
            managedObjectContext.delete(contact)
            
            contacts.remove(at: indexPath.row)
            isDeleted = true
            
            tableView.reloadData()
            
           // performSegue(withIdentifier: "unwindToContactList", sender: self)
        }
    }

    
    
    //MARK: - Navigation
    
    //Unwind segue
    @IBAction func unwindToContactList(segue: UIStoryboardSegue) {
        if let viewController = segue.source as? AddContactViewController {
            guard let lastname: String = viewController.lastnameTextField.text, let phoneNumber: String = viewController.phoneNumberTextField.text, let company: String = viewController.companyTextField.text, let firstname: String = viewController.firstnameTextField.text, let imageData: NSData = viewController.imageData else
            
            {
                return
            
            }
            if lastname != "" && phoneNumber != "" {
                if let indexPath = viewController.indexPathForContact {
                    update(indexPath: indexPath, lastname: lastname, phoneNumber: phoneNumber)
                } else {
                    save(lastname:lastname, phoneNumber:phoneNumber, company:company, firstname:firstname, imageData: imageData)
                }
            }
           // tableView.reloadData()
              tableView.reloadData()
        } else if let viewController = segue.source as? ContactDetailViewController {
            if viewController.isDeleted {
                guard let indexPath: IndexPath = viewController.indexPath else { return }
                let contact = contacts[indexPath.row]
                delete(contact, at: indexPath)
                tableView.reloadData()
            }
        }

    }
    
    // let indexPath = collectionView.indexPath(for: activeCell)
    // CHANGE CATS TO CONTACT
    //contacts.remove(at: indexPath!.row)
    //collectionView.deleteItems(at: [indexPath!])
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "contactDetailSegue" {
            guard let navViewController = segue.destination as? UINavigationController else { return }
            guard let viewController = navViewController.topViewController as? ContactDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let contact = contacts[indexPath.row]
            viewController.contact = contact
            viewController.indexPath = indexPath
        }
    }
    
    
   
    
}
