//
//  Contact+CoreDataProperties.swift
//  ContactsApp
//
//  Created by Crypto on 8/29/19.
//  Copyright © 2019 Crypto. All rights reserved.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var addEmail: String?
    @NSManaged public var addPhone: String?
    @NSManaged public var company: String?
    @NSManaged public var contactImage: NSData?
    @NSManaged public var firstName: String?
    @NSManaged public var id: Int64
    @NSManaged public var lastName: String?
    @NSManaged public var mobilePhone: String?
    @NSManaged public var birthday: String?
    @NSManaged public var url: String?
    @NSManaged public var address: String?
    @NSManaged public var anniversary: String?
    @NSManaged public var relatedName: String?
    @NSManaged public var socialProfile: String?
    @NSManaged public var instantMessage: String?
    @NSManaged public var notes: String?

}
