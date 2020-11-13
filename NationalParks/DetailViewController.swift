//
//  DetailViewController.swift
//  NationalParks
//
//  Created by Charles on 11/12/20.
//  Copyright © 2020 Charles. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate {
    var data: Repo.Park?
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = data?.images.first?.url {
            coverImageView.kf.setImage(with: url)
        }
        titleLabel.text = data?.name
        subtitleLabel.text = data?.designation
        descriptionTextView.text = data?.description
    }
}
