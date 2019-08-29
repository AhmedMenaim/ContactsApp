//
//  ContactDataTableView.swift
//  ContactsApp
//
//  Created by Crypto on 8/24/19.
//  Copyright © 2019 Crypto. All rights reserved.
//

import UIKit

class ContactDataTableView: UITableViewController {

    var viewModel: ContactViewModel?
    var contact: Contact?
    
    @IBOutlet weak var imageViewContact: UIImageView!
    @IBOutlet weak var lblContactName: UILabel!
    @IBOutlet weak var lblContactMobile: UILabel!
    @IBOutlet weak var lblAnotherMobile: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var lblURL: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblBirthdayDate: UILabel!
    @IBOutlet weak var lblAnniversary: UILabel!
    @IBOutlet weak var lblSocialProfile: UILabel!
    @IBOutlet weak var lblRelatedName: UILabel!
    @IBOutlet weak var lblInstantMessage: UILabel!
    
    @IBOutlet weak var lblNotes: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        imageViewContact.cornerRadius = imageViewContact.frame.height / 2
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editContact))
        
        setData()

    }



    
    @objc func editContact () {
        
        let contactDetailsTableView = self.storyboard?.instantiateViewController(withIdentifier: "ContactDetailsTableView") as! ContactDetailsTableView
        contactDetailsTableView.viewModel = viewModel
        contactDetailsTableView.contact = contact
        contactDetailsTableView.delegate = self
        self.navigationController?.pushViewController(contactDetailsTableView, animated: true)
    }
    
    
    
    func setData() {
        lblContactName.text = "\(contact?.firstName ?? "Null") \(contact?.lastName ?? "Null" )"
        lblContactMobile.text = contact?.mobilePhone
        lblAnotherMobile.text = contact?.addPhone
        lblEmail.text = contact?.addEmail
        lblCompany.text = contact?.company
        lblURL.text = contact?.url
        lblAddress.text = contact?.address
        lblAnniversary.text = contact?.anniversary
        lblRelatedName.text = contact?.relatedName
        lblBirthdayDate.text = contact?.birthday
        lblSocialProfile.text = contact?.socialProfile
        lblInstantMessage.text = contact?.instantMessage
        lblNotes.text = contact?.notes
        

        if let data = contact?.contactImage {
            imageViewContact.image = UIImage(data: data as Data)
        }

    }
}


extension ContactDataTableView: ContactDetailsDelegate {
    func updateContact(newContact: Contact) {
        contact = newContact
        setData()
        tableView.reloadData()
    }
    
    
}
