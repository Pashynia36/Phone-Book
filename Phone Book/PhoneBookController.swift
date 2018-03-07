//
//  PhoneBookController.swift
//  Phone Book
//
//  Created by Pavlo Novak on 3/6/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit
import Contacts

class PhoneBookController: UITableViewController {

    /*
    class CNPhoneNumber
    */
    let contactStore = CNContactStore()
    let colors = [UIColor.black, UIColor.blue, UIColor.brown, UIColor.magenta, UIColor.cyan, UIColor.green, UIColor.red, UIColor.darkGray, UIColor.orange, UIColor.purple, UIColor.yellow]
    var book = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        contactStore.requestAccess(for: .contacts) { (success, error) in
            if success {
                print("Authorization Successful")
            }
        }
        setUpNavAppear()
        
        fetchContacts()
        // self.clearsSelectionOnViewWillAppear = false
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    // залить проект на гит, вручную сделать деселект поля
    //
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setUpNavAppear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return book.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DetailViewCell
        cell.personName.text = book[indexPath.row].name
        cell.personNumber.text = book[indexPath.row].phone
        //print(book[indexPath.row].name)
        if let check = UIImage(named: book[indexPath.row].name) {
            cell.personPhoto.image = check
            cell.personPhoto.layer.borderWidth = 2.0
        } else {
            cell.personPhoto.image = generateImageWithText(text: book[indexPath.row].name)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        vc.reference = book[indexPath.row]
        vc.tabBarController?.title = "1234"
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUpNavAppear() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = .white
        navigationItem.title = "Phone Book"
    }
    
    func fetchContacts() {
        
        let key = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: key)
        try! contactStore.enumerateContacts(with: request) { (contact, stoppingPointer) in
            let name = contact.givenName + " " + contact.familyName
            let number = contact.phoneNumbers.first?.value.stringValue
            
            let contactToAppend = Contact(name: name, phone: number!)
            
            self.book.append(contactToAppend)
        }
        tableView.reloadData()
    }
    
    func generateImageWithText(text: String) -> UIImage
    {
        let image = UIImage()
        var newText = ""
        func chooseColor() -> UIColor {
            let rand = Int(arc4random_uniform(UInt32(colors.count)))
            return colors[rand].withAlphaComponent(0.2)
        }
        let myColor = chooseColor()
        let imageView = UIImageView(image: image)
        imageView.backgroundColor = myColor
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.textColor = UIColor.black
        
        for i in text {
            if newText.count == 2 {
                break
            }
            if i >= "A" && i <= "Z" || i >= "А" && i <= "Я" {
                newText.append(i)
            }
        }
        label.text = newText
        
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0);
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithText!
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
