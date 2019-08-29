//
//  ContactDetailsTableView.swift
//  ContactsApp
//
//  Created by Crypto on 8/8/19.
//  Copyright © 2019 Crypto. All rights reserved.
//

import UIKit


protocol ContactDetailsDelegate: class {
    func updateContact(newContact: Contact)
}


class ContactDetailsTableView: UITableViewController {
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var textFieldCompany: UITextField!
    @IBOutlet weak var textFieldAddPhone: UITextField!
    @IBOutlet weak var textFieldMobileNumber: UITextField!
    @IBOutlet weak var textFieldAddEmail: UITextField!
    @IBOutlet weak var textFieldAddURL: UITextField!
    @IBOutlet weak var textFieldAddAddress: UITextField!
    @IBOutlet weak var textFieldAddBirthDay: UITextField!
    @IBOutlet weak var textFieldAddDate: UITextField!
    @IBOutlet weak var textFieldAddRelatedName: UITextField!
    @IBOutlet weak var textFieldAddSocialProfile: UITextField!
    @IBOutlet weak var textFieldAddInstantMessage: UITextField!
    @IBOutlet weak var textFieldAddNotes: UITextField!
    
    
    var viewModel: ContactViewModel?
    var contact: Contact?
    
    weak var delegate: ContactDetailsDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Contact"
        
        imageViewOutlet.cornerRadius = imageViewOutlet.frame.height / 2
        textFieldFirstName.text = contact?.firstName
        textFieldLastName.text = contact?.lastName
        textFieldCompany.text = contact?.company
        textFieldAddPhone.text = contact?.addPhone
        textFieldMobileNumber.text = contact?.mobilePhone
        textFieldAddEmail.text = contact?.addEmail
        textFieldAddURL.text = contact?.url
        textFieldAddDate.text = contact?.anniversary
        textFieldAddAddress.text = contact?.address
        textFieldAddBirthDay.text = contact?.birthday
        textFieldAddRelatedName.text = contact?.relatedName
        textFieldAddSocialProfile.text = contact?.socialProfile
        textFieldAddInstantMessage.text = contact?.instantMessage
        textFieldAddNotes.text = contact?.notes
        
        if let data = contact?.contactImage {
             imageViewOutlet.image = UIImage(data: data as Data)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(SaveContact))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(CancelBack))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureAction))
            imageViewOutlet.addGestureRecognizer(tapGesture)
        

    }
    
    @objc func gestureAction() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: nil)
            
        }
    }
    
    
    @objc func SaveContact() {
        
        guard !textFieldFirstName.text!.isEmpty && !textFieldMobileNumber.text!.isEmpty else {return}

        if contact?.id != nil {
            let newContact = viewModel?.updateContact(contactImage: imageViewOutlet.image, firstName: textFieldFirstName.text!, lastName: textFieldLastName.text, company: textFieldCompany.text, mobilePhone: textFieldMobileNumber.text!, addPhone: textFieldAddPhone.text, addEmail: textFieldAddEmail.text, addUrl: textFieldAddURL.text, addAddress: textFieldAddAddress.text, addAnniversary: textFieldAddDate.text, addBirthDay: textFieldAddBirthDay.text, addRelatedName: textFieldAddRelatedName.text, addInstantMessage: textFieldAddInstantMessage.text, addSocialProfile: textFieldAddSocialProfile.text, addNotes: textFieldAddNotes.text, id: Int((contact?.id)!))
            delegate?.updateContact(newContact: newContact!)

        }
        else {
            viewModel?.saveContact(contactImage: imageViewOutlet.image, firstName: textFieldFirstName.text!, lastName: textFieldLastName.text, company: textFieldCompany.text, mobilePhone: textFieldMobileNumber.text! , addPhone: textFieldAddPhone.text, addEmail: textFieldAddEmail.text, addUrl: textFieldAddURL.text, addAddress: textFieldAddAddress.text, addAnniversary: textFieldAddDate.text , addBirthDay: textFieldAddBirthDay.text, addRelatedName: textFieldAddRelatedName.text, addInstantMessage: textFieldAddInstantMessage.text, addSocialProfile: textFieldAddSocialProfile.text, addNotes: textFieldAddNotes.text, id: Int(Int64.random(in: 1...1000000)))
        }
     
        self.navigationController?.popViewController(animated: true)
      
            
        
    }
    
    
    
    @objc func  CancelBack () {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonAddFieldAction(_ sender: Any) {
        
        let addFieldTableView = self.storyboard?.instantiateViewController(withIdentifier: "AddFieldTableView") as! AddFieldTableView
        self.navigationController?.pushViewController(addFieldTableView, animated: true)
    }

    
}
extension ContactDetailsTableView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        
            imageViewOutlet.image = image
        
        picker.dismiss(animated: true, completion: nil)
        
        
        
        
    }
    
    
}
