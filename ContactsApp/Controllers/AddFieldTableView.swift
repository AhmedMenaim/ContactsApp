//
//  AddFieldTableView.swift
//  ContactsApp
//
//  Created by Crypto on 8/22/19.
//  Copyright © 2019 Crypto. All rights reserved.
//

import UIKit

class AddFieldTableView: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Field"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(CancelBack))
        

    }
    
    @objc func  CancelBack () {
        self.navigationController?.popViewController(animated: true)
    }
    
}
