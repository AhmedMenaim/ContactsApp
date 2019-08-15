//
//  ContactViewModel.swift
//  ContactsApp
//
//  Created by Crypto on 8/8/19.
//  Copyright © 2019 Crypto. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class ContactViewModel {
    
  
    var contact: Contact?
    var myContacts = [Contact]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
    
    
    let fetchRequest = NSFetchRequest<Contact>(entityName: "Contact")
    
    func fetchContactData () {
        context = appDelegate.persistentContainer.viewContext
        do {
            myContacts = try context.fetch(fetchRequest)
        }
        catch {
            print (error)
        }
    }
    
    func saveContact (contactImage: UIImage?, firstName: String, lastName: String?, company: String?, mobilePhone: String, addPhone: String?, addEmail: String?, id: Int ) {
        
        context = appDelegate.persistentContainer.viewContext
     
        let newContact = Contact(context: context)
        
        newContact.id = Int64(id)
        newContact.firstName = firstName
        newContact.lastName = lastName
        newContact.mobilePhone = mobilePhone
        newContact.addEmail = addEmail
        newContact.addPhone = addPhone
        newContact.company = company
        newContact.contactImage = contactImage?.jpegData(compressionQuality: 1) as NSData?
        
        do {
            try context.save()
        }
        catch {
            print (error)
        }
        
        
        
        
    }

    
   
    
}




