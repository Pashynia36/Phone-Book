//
//  DetailViewCell.swift
//  Phone Book
//
//  Created by Pavlo Novak on 3/6/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit

class DetailViewCell: UITableViewCell {

    @IBOutlet weak var personPhoto: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personNumber: UILabel!
    
    override func awakeFromNib(){
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool){
        
        super.setSelected(selected, animated: animated)
    }
    
    func prepareForCell(person: Contact, indexPath: Int){
        
        personName.text = person.name
        personNumber.text = person.phone
        if let check = UIImage(named: person.name) {
            personPhoto.image = check
            personPhoto.layer.borderWidth = 2.0
        } else {
            personPhoto.image = UIImage.generateImageWithText(text: personName.text!, color: CGColor.chooseColor())
            personPhoto.layer.borderWidth = 0.0
        }
    }
}
