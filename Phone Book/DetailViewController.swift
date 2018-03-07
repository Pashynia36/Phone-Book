//
//  DetailViewController.swift
//  Phone Book
//
//  Created by Pavlo Novak on 3/6/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var reference: Contact?

    @IBOutlet weak var contactPhone: UIButton!
    @IBOutlet weak var contactPhoto: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        setUpNavAppear()
        
        contactName.text = reference?.name
        contactPhone.setTitle(reference?.phone, for: .normal)
        
        if let check = UIImage(named: (reference?.name)!) {
            contactPhoto.image = check
            contactPhoto.layer.borderWidth = 2.0
        } else {
            contactPhoto.image = UIImage.generateImageWithText(text: (reference?.name)!, color: UIColor.lightGray.withAlphaComponent(0.2))
        }
    }

    func setUpNavAppear(){
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .white
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    @IBAction func callTap(_ sender: UIButton){
        
        if let name = reference?.name, let phone = reference?.phone {
            let alert = UIAlertController(title: "Call", message: "\(name)", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "\(phone)", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
