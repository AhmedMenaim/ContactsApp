//
//  ViewController.swift
//  ContactsApp
//
//  Created by Crypto on 8/8/19.
//  Copyright © 2019 Crypto. All rights reserved.
//

import UIKit
import CoreData
class ContactsListViewController: UIViewController {
    
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var userDataView: UIView!
    @IBOutlet weak var imageViewOutlet: UIImageView!

    

    let  searchController = UISearchController(searchResultsController: nil)
    var viewModel = ContactViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageViewOutlet.cornerRadius = imageViewOutlet.frame.height / 2
        setupSearchController()
        // here we make fetch first to bring the data to be able to have all data
        viewModel.fetchContactData()
        self.title = "Contacts"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContact))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Groups", style: .done, target: self, action: #selector(goToGroups))
        contactsTableView.register(UINib(nibName: "ContactCell", bundle: nil), forCellReuseIdentifier: "ContactCell")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureAction))
        userDataView.addGestureRecognizer(tapGesture)
        
        
    }
    
    func Sorting () {
        
        viewModel.myContacts = viewModel.myContacts.sorted(by: { $0.firstName!.lowercased() < $1.firstName!.lowercased() } )
//        viewModel.fetchContactData()
        contactsTableView.reloadData()
    }
    
    @objc func gestureAction () {
        let myDataTableView = (self.storyboard?.instantiateViewController(withIdentifier: "MyDataTableView"))!
        self.navigationController?.pushViewController(myDataTableView, animated: true)
    }
    
    @objc func addContact () {
        let contactDetailsTableView = self.storyboard?.instantiateViewController(withIdentifier: "ContactDetailsTableView") as! ContactDetailsTableView
        contactDetailsTableView.viewModel = viewModel
        self.navigationController?.pushViewController(contactDetailsTableView, animated: true)
        
    }
    
    @objc func goToGroups () {
        
        let groupsTableView =
            self.storyboard?.instantiateViewController(withIdentifier: "GroupsTableView") as? GroupsTableView
        groupsTableView?.delegate = self
        navigationController?.pushViewController(groupsTableView!, animated: true)
    }
    
    // Adding Search Bar //
    func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        searchController.dimsBackgroundDuringPresentation = false
        
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.isActive = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    // Filtering //
    func filterContentForSearchText(_ searchText: String) {
        viewModel.filteredContacts = viewModel.myContacts.filter { contact in
            let name = "\(contact.firstName ?? "")\(contact.lastName ?? "")"
            return
                name.lowercased().contains(searchText.lowercased().replacingOccurrences(of: " ", with: ""))
                   ||  name.lowercased().contains(searchText.lowercased().replacingOccurrences(of: "  ", with: "")) || searchText == ""
        }
        
        contactsTableView.reloadData()
    }
    
}

extension ContactsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return viewModel.filteredContacts.count
        }
        return viewModel.myContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ContactCell = contactsTableView.dequeueReusableCell(withIdentifier: "ContactCell") as! ContactCell
        
        var contact = viewModel.myContacts[indexPath.row]
        if searchController.isActive {
            contact = viewModel.filteredContacts[(indexPath as NSIndexPath).row]
        } else {
            contact = viewModel.myContacts[(indexPath as NSIndexPath).row]
        }
        
        
        ContactCell.lblContactName.text = "\(contact.firstName ?? "Null") \(contact.lastName ?? "Null")"
        
        return ContactCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        let contact = viewModel.myContacts[indexPath.row]
        let contactDataTableView = self.storyboard?.instantiateViewController(withIdentifier: "ContactDataTableView") as! ContactDataTableView
        contactDataTableView.viewModel = viewModel
        contactDataTableView.contact = contact
        self.navigationController?.pushViewController(contactDataTableView, animated: true)
        
        
    }
    
    
    
    
    //    - Delete Function -   //
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            
            viewModel.deleteContact(contactId: viewModel.myContacts[indexPath.row].id)
            
            viewModel.myContacts.remove(at: indexPath.row)
            
            contactsTableView.beginUpdates()
            
            contactsTableView.deleteRows(at: [indexPath], with: .automatic)
            
            contactsTableView.endUpdates()
            
            
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        viewModel.fetchContactData()
        Sorting()

        
        
    }
    
    
}

extension ContactsListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
extension ContactsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
}


extension ContactsListViewController: GroupsTableViewDelegate {
    func HideTableView () {
        if contactsTableView.isHidden {
            contactsTableView.isHidden = false
        }
        else {
            contactsTableView.isHidden = true
        }
        
    }
}
