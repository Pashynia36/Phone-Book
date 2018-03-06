//
//  Contact.swift
//  Phone Book
//
//  Created by Pavlo Novak on 3/6/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import Foundation

class Contact {
    
    var name: String
    var phone: String
    var image: String
    
    init(name: String, phone: String, image: String) {
        self.name = name
        self.phone = phone
        self.image = image
    }
}
