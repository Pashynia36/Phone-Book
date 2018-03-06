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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print((reference?.name)!)
        print((reference?.phone)!)
        contactName.text = reference?.name
        contactPhone.setTitle(reference?.phone, for: .normal)
        if let check = UIImage(named: (reference?.image)!) {
            contactPhoto.image = check
        } else {
            contactPhoto.image = generateImageWithText(text: (reference?.name)!)
        }
        
    }
   
    @IBAction func callTap(_ sender: UIButton) {
        if let name = reference?.name, let phone = reference?.phone {
            let alert = UIAlertController(title: "Call", message: "\(name)", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "\(phone)", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func generateImageWithText(text: String) -> UIImage
    {
        let image = UIImage()
        var newText = ""
        let myColor = UIColor(white: 0.1, alpha: 0.2)
        
        let imageView = UIImageView(image: image)
        imageView.backgroundColor = myColor
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.textColor = UIColor.black
        
        for i in text {
            if i >= "A" && i <= "Z" {
                newText.append(i)
            }
        }
        label.text = newText
        
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0);
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return imageWithText!
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
