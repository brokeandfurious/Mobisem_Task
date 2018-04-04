//
//  DetailViewController.swift
//  Mobisem_Task
//
//  Created by Murat Ekrem Kolcalar on 3/19/18.
//  Copyright © 2018 murtilicious. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK - Declarations (Top Container)
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var checkInButton: UIView!
    
    // MARK - Declarations (Bottom Container)
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var wholeTextLabel: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
    
    var destination: Destination?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK - Setup View Attributes
        checkInButton.layer.borderWidth = 1
        checkInButton.layer.borderColor = UIColor.white.cgColor
        
            // Container Shadows
        imageContainerView.clipsToBounds = false
        imageContainerView?.layer.shouldRasterize = true
        imageContainerView?.layer.rasterizationScale = UIScreen.main.scale
        imageContainerView?.layer.shadowColor = Values.shared.shadowColor
        imageContainerView.layer.shadowColor = UIColor.black.cgColor
        imageContainerView.layer.shadowOpacity = 0.5
        imageContainerView.layer.shadowOffset = CGSize(width: -5, height: 10)
        imageContainerView.layer.shadowRadius = 5
//        imageContainerView.layer.shadowPath = UIBezierPath(roundedRect: imageContainerView.bounds, cornerRadius: 10).cgPath
        
            // Text Shadows
        cityLabel.textDropShadow()
        priceLabel.textDropShadow()
        descriptionLabel.textDropShadow()
        dateLabel.textDropShadow()
        
        
        // MARK - Nil Catcher
        if let destination = destination {
            imageView.image = destination.featuredImage
            cityLabel.text = destination.title.uppercased()
            profileImageView.image = destination.profileImage
            profileNameLabel.text = destination.profileName
            headlineLabel.text = destination.headline
            subtitleLabel.text = destination.subtitle
            wholeTextLabel.text = destination.wholeText
            reviewImageView.image = destination.reviewImage
        }
        
        // MARK - Swipe Down Gesture Recognizer
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.cancelsTouchesInView = false
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        
    }
    
    deinit {
        debugPrint("deinit...DetailViewController")
    }
    
    // Dismiss View upon Swipe
    @objc func respondToSwipeGesture() {
        hero_dismissViewController()
    }

}


