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

    var images = [Contact]()
    let contactStore = CNContactStore()
    var book = [Contact]()
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        contactStore.requestAccess(for: .contacts) { (success, error) in
            if success {
                print("Authorization successful")
            }
        }
        fetchContacts()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillAppear(_ animated: Bool){
        
        super.viewWillDisappear(animated)
        setUpNavAppear()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return book.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DetailViewCell
        cell.prepareForCell(person: book[indexPath.row], indexPath: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        vc.reference = book[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUpNavAppear(){
        
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
}

