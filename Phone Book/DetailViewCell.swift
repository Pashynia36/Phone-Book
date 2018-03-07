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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool){
        
        super.setSelected(selected, animated: animated)
    }
    
    func prepareForCell(cell: Contact, indexPath: Int){
        
        personName.text = cell.name
        personNumber.text = cell.phone
        if let check = UIImage(named: cell.name) {
            personPhoto.image = check
            personPhoto.layer.borderWidth = 2.0
        } else {
            personPhoto.image = UIImage.generateImageWithText(text: personName.text!, color: CGColor.chooseColor())
        }
    }
}
