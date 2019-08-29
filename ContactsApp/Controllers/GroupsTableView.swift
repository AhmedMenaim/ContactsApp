//
//  GroupsTableView.swift
//  ContactsApp
//
//  Created by Crypto on 8/24/19.
//  Copyright © 2019 Crypto. All rights reserved.
//

import UIKit


protocol GroupsTableViewDelegate: class {
    func HideTableView ()
}


class GroupsTableView: UITableViewController {

    
     weak var delegate: GroupsTableViewDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Groups"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        switch section {
        case 0:
            switch indexPath.row {
            case 1:
                // Hide the table View data//
                
                delegate?.HideTableView()
                
            default:
                // Check and Check the cells //
                
                if let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: 0)) {
                    
                    cell.accessoryType = (cell.accessoryType == .checkmark) ? .none : .checkmark
                    
                    
                }

                
            }
        default:
            print("error")
        }

    }
    
}
