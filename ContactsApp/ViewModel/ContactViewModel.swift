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
    var filteredContacts = [Contact]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
    
    
    
    func fetchContactData () {
        let fetchRequest = NSFetchRequest<Contact>(entityName: "Contact")
        context = appDelegate.persistentContainer.viewContext
        do {
            myContacts = try context.fetch(fetchRequest)
        }
        catch {
            print (error)
        }
    }
    
    func saveContact (contactImage: UIImage?, firstName: String, lastName: String?, company: String?, mobilePhone: String, addPhone: String?, addEmail: String?,addUrl: String?, addAddress: String?, addAnniversary: String?, addBirthDay: String?,addRelatedName: String?, addInstantMessage: String?,addSocialProfile: String?, addNotes: String?, id: Int ) {
        
        
        context = appDelegate.persistentContainer.viewContext
     
        let newContact = Contact(context: context)
        
        newContact.id = Int64(id)
        newContact.firstName = firstName
        newContact.lastName = lastName
        newContact.mobilePhone = mobilePhone
        newContact.addEmail = addEmail
        newContact.addPhone = addPhone
        newContact.company = company
        newContact.address = addAddress
        newContact.url = addUrl
        newContact.anniversary = addAnniversary
        newContact.birthday = addBirthDay
        newContact.socialProfile = addSocialProfile
        newContact.relatedName = addRelatedName
        newContact.notes = addNotes
        newContact.instantMessage = addInstantMessage
        newContact.contactImage = contactImage?.jpegData(compressionQuality: 1) as NSData?
        
        do {
            try context.save()
        }
        catch {
            print (error)
        }
        
        
        
        
    }

    
   
    func updateContact(contactImage: UIImage?,firstName: String, lastName: String?, company: String?, mobilePhone: String, addPhone: String?, addEmail: String?,addUrl: String?, addAddress: String?, addAnniversary: String?, addBirthDay: String?,addRelatedName: String?, addInstantMessage: String?,addSocialProfile: String?, addNotes: String?, id: Int ) -> Contact? {
        
        let fetchRequest = NSFetchRequest<Contact>(entityName: "Contact")
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        do {
            
            let contact = try context.fetch(fetchRequest).first
            contact?.firstName = firstName
            contact?.lastName = lastName
            contact?.mobilePhone = mobilePhone
            contact?.company = company
            contact?.addPhone = addPhone
            contact?.addEmail = addEmail
            contact?.address = addAddress
            contact?.url = addUrl
            contact?.anniversary = addAnniversary
            contact?.birthday = addBirthDay
            contact?.socialProfile = addSocialProfile
            contact?.relatedName = addRelatedName
            contact?.notes = addNotes
            contact?.instantMessage = addInstantMessage
            contact!.contactImage = contactImage?.jpegData(compressionQuality: 1) as NSData?
            
            do {
                try context.save()
                return contact!
            }
            catch {
                print(error)
                return nil
            }
        }
        catch {
            print(error)
            return nil
        }
    }
    
    
    
    
    func deleteContact(contactId: Int64) {

        let deleteFetchRequest = NSFetchRequest<Contact>(entityName: "Contact")
        deleteFetchRequest.predicate = NSPredicate(format: "id == \(contactId)")

        do {
            let contact = (
                try context.fetch(deleteFetchRequest).first)!
            context.delete(contact)
            try context.save()
            
            
        } catch  {
            print(error)
        }

    }
    
}




