//
//  ViewController.swift
//  ContactsApp
//
//  Created by Crypto on 8/8/19.
//  Copyright © 2019 Crypto. All rights reserved.
//

import UIKit
import CoreData
class ContactsViewController: UIViewController,mine {
    
    @IBOutlet weak var contactsTableView: UITableView!
    var viewModel = ContactViewModel()
    var lastSelectedIndexPath: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        // here we make fetch first to bring the data to be able to have all data 
        viewModel.fetchContactData()
        self.title = "Contacts"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContact))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Groups", style: .done, target: self, action: #selector(goToGroups))
        contactsTableView.register(UINib(nibName: "ContactCell", bundle: nil), forCellReuseIdentifier: "ContactCell")
        
    }
    
    @objc func addContact () {
        let contactDetailsTableView = self.storyboard?.instantiateViewController(withIdentifier: "ContactDetailsTableView") as! ContactDetailsTableView
        contactDetailsTableView.viewModel = viewModel
        self.navigationController?.pushViewController(contactDetailsTableView, animated: true)
        
    }
    //  ///////////////////  TODO //////////////////////////////
    @objc func goToGroups () {
        
    }
    
}

extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.myContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = viewModel.myContacts[indexPath.row]
        let ContactCell = contactsTableView.dequeueReusableCell(withIdentifier: "ContactCell") as! ContactCell
        
        ContactCell.lblContactName.text = "\(contact.firstName ?? "Null") \(contact.lastName ?? "Null")"
        
        return ContactCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastSelectedIndexPath = indexPath
        let contact = viewModel.myContacts[indexPath.row]
        let contactDetailsTableView = self.storyboard?.instantiateViewController(withIdentifier: "ContactDetailsTableView") as! ContactDetailsTableView
        contactDetailsTableView.id = Int (viewModel.myContacts[indexPath.row].id)
        contactDetailsTableView.firstName = viewModel.myContacts[indexPath.row].firstName
        contactDetailsTableView.lastName = viewModel.myContacts[indexPath.row].lastName
        contactDetailsTableView.company = viewModel.myContacts[indexPath.row].company
        contactDetailsTableView.MobilePhone = viewModel.myContacts[indexPath.row].mobilePhone
        contactDetailsTableView.addMobile = viewModel.myContacts[indexPath.row].addPhone
        contactDetailsTableView.addEmail = viewModel.myContacts[indexPath.row].addEmail

         contactDetailsTableView.contact = contact
       

        self.navigationController?.pushViewController(contactDetailsTableView, animated: true)
        
        
    }
    
    
    
    
    //    - Delete Function -   //
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let fetchRequest = NSFetchRequest<Contact>(entityName: "Contact")
            fetchRequest.predicate = NSPredicate(format: "id == \(viewModel.myContacts[indexPath.row].id)")
            
            do {
                let contact = (
                    try viewModel.context.fetch(fetchRequest).first)!
                
                viewModel.context.delete(contact)
                
                viewModel.myContacts.remove(at: indexPath.row)
                
                contactsTableView.beginUpdates()
                
                contactsTableView.deleteRows(at: [indexPath], with: .automatic)
                
                contactsTableView.endUpdates()
                
            } catch {
                print(error)
            }
            
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        viewModel.fetchContactData()
        contactsTableView.reloadData()
        
        
        
    }
    
   
}


protocol mine: class {
    
}
