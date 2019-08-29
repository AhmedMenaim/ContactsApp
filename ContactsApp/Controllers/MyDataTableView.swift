//
//  MyDataTableView.swift
//  ContactsApp
//
//  Created by Crypto on 8/23/19.
//  Copyright © 2019 Crypto. All rights reserved.
//

import UIKit

class MyDataTableView: UITableViewController {

    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblFaceTime: UILabel!
    @IBOutlet weak var lblFirstEmail: UILabel!
    @IBOutlet weak var lblSecondEmail: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageViewOutlet.cornerRadius = imageViewOutlet.frame.height / 2
        underLinedLabel(myLabel: lblNumber, lblString: "+20 111 9555612")
        underLinedLabel(myLabel: lblFaceTime, lblString: "FaceTime")
        underLinedLabel(myLabel: lblFirstEmail, lblString: "anything@icloud.com")
        underLinedLabel(myLabel: lblSecondEmail, lblString: "anything@icloud.com")
        underLinedLabel(myLabel: lblAddress, lblString: "My address...")
    }

    func underLinedLabel(myLabel: UILabel, lblString: String ) {
        let attributedString = NSMutableAttributedString.init(string: lblString)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
        myLabel.attributedText = attributedString
    
    }
}
