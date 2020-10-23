//
//  AddContactViewController.swift
//  app5-Charles-Rockhead
//
//  Created by Charles Rockhead on 10/23/20.
//

import Foundation

import UIKit

protocol AddContactDelegate: class {
    func didCreate(_ contact: Contact)
}

class AddContactViewController: UIViewController {

    weak var delegate: AddContactDelegate?
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

       
    @IBAction func saveAction(_ sender: Any) {
        let newContact = createNewContact()
        if let validNewConttact = newContact {
            self.delegate?.didCreate(validNewConttact)
        }
        dump(newContact)
    }
    
 
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var company: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //UM not sure if this works
    func createNewContact() -> Contact? {
        if (firstName.text == "" || lastName.text == "" || company.text == "" || email.text == "" || email.text == "" || phoneNumber.text == "") {
            return nil
        }

        let contact = Contact(firstName: firstName.text ?? "", lastName: lastName.text ?? "", company: company.text ?? "", email: email.text ?? "", phoneNumber: phoneNumber.text ?? "")
        
        return contact
    }
    
    


}
