//
//  Contact+CoreDataProperties.swift
//  ContactsApp
//
//  Created by Crypto on 8/8/19.
//  Copyright © 2019 Crypto. All rights reserved.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var company: String?
    @NSManaged public var contactImage: NSData?
    @NSManaged public var mobilePhone: String?
    @NSManaged public var addEmail: String?
    @NSManaged public var addPhone: String?
    @NSManaged public var id: Int64

}
