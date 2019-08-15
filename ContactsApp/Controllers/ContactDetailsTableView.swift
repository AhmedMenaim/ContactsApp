//
//  ContactDetailsTableView.swift
//  ContactsApp
//
//  Created by Crypto on 8/8/19.
//  Copyright © 2019 Crypto. All rights reserved.
//

import UIKit

class ContactDetailsTableView: UITableViewController,mine {
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    
    @IBOutlet weak var textFieldFirstName: UITextField!
    
    @IBOutlet weak var textFieldLastName: UITextField!
    
    @IBOutlet weak var textFieldCompany: UITextField!
    
    @IBOutlet weak var textFieldAddPhone: UITextField!
    
    @IBOutlet weak var textFieldMobileNumber: UITextField!
    
    @IBOutlet weak var textFieldAddEmail: UITextField!
    
    // My Variables
    var id: Int?
    var firstName: String?
    var lastName: String?
    var company: String?
    var MobilePhone: String?
    var addMobile: String?
    var addEmail: String?
    
    /////////////////
    var viewModel: ContactViewModel?
    var contact: Contact?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Contact"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(SaveContact))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(CancelBack))

    }
    
    
    @objc func SaveContact() {
        
        guard !textFieldFirstName.text!.isEmpty && !textFieldMobileNumber.text!.isEmpty else {return}

        viewModel?.saveContact(contactImage: imageViewOutlet.image, firstName: textFieldFirstName.text!, lastName: textFieldLastName.text, company: textFieldCompany.text, mobilePhone: textFieldMobileNumber.text! , addPhone: textFieldAddPhone.text, addEmail: textFieldAddEmail.text, id: Int(Int64.random(in: 1...1000000)))
        
        self.navigationController?.popViewController(animated: true)
      
            
        
    }
    
    
    
    @objc func  CancelBack () {
        self.navigationController?.popViewController(animated: true)
    }
    
    

    
}
