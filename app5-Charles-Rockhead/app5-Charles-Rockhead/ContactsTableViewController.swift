//
//  ContactsTableViewController.swift
//  app5-Charles-Rockhead
//
//  Created by Charles Rockhead on 10/23/20.
//

import Foundation

import UIKit

class ContactsTableViewController: UITableViewController, AddContactDelegate {
    var contactList: [Contact] = []
    
    func didCreate(_ contact: Contact) {
        dismiss(animated: true, completion: nil)
        contactList.append(contact)
        contactList = contactList.sorted { $0.lastName.lowercased() < $1.lastName.lowercased() }
        self.tableView.reloadData()
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showAddContact", sender: sender)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let me = Contact(firstName: "Charles", lastName: "Rockhead", company: "UPain", email: "rockhead@seas.upenn.edu", phoneNumber: "2156201858")
        let friend = Contact(firstName: "Sara", lastName: "Reddy", company: "UPain", email: "reddysar@seas.upenn.edu", phoneNumber: "8177184043")
        contactList.insert(me, at: 0)
        contactList.insert(friend, at: 1)
    }
    
    // MARK: - Basic table view methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return contactList.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            if let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell") {
                let contact = contactList[indexPath.row]
                //let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell")
                cell.textLabel?.text = contact.firstName + " " + contactList[indexPath.row].lastName
                cell.detailTextLabel?.text = contact.company
                return cell
            }

            return UITableViewCell()
        }

        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100.0
        }


        // MARK: - Handle user interaction
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //Show segue to DVC and use prepareForSegue to pass data from CTVC to DVC.
            performSegue(withIdentifier: "ShowDetail", sender: (Any).self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let index = tableView.indexPathForSelectedRow?.row else {return}
                if let dvc = segue.destination as? DetailViewController {
                    dvc.contact = contactList[index]
                }
        }
        
        if segue.identifier == "ShowAddContact" {
            if let nc = segue.destination as? UINavigationController {
                if let acvc = nc.topViewController as? AddContactViewController {
                    acvc.delegate = self
                }
            }
        }
    }
}
