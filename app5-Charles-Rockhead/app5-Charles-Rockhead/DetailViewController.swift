//
//  DetailViewController.swift
//  app5-Charles-Rockhead
//
//  Created by Charles Rockhead on 10/23/20.
//

import Foundation

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var contact: Contact?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    
    
    @IBAction func imageViewTapped(_ sender: UITapGestureRecognizer) {
        print("tapped")
        presentImagePicker()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        company.text = contact?.company
        email.text = contact?.email
        phoneNumber.text = contact?.phoneNumber
        name.text = (contact?.firstName ?? "") + " " + (contact?.lastName ?? "")
    }
    
    func imagePickerController(_ : UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            picture.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func presentImagePicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }


}
