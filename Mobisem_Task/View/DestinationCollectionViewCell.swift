//
//  DestinationCollectionViewCell.swift
//  Mobisem_Task
//
//  Created by Murat Ekrem Kolcalar on 3/19/18.
//  Copyright © 2018 murtilicious. All rights reserved.
//

import UIKit
import Hero

class DestinationCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
        
    // MARK - Declarations and Outlets (Top Container)
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var whiteContainerView: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var checkInButton: UIView!
    
    @IBOutlet weak var titleLabelView: UILabel!
    @IBOutlet weak var priceLabelView: UILabel!
    @IBOutlet weak var descriptionLabelView: UILabel!
    @IBOutlet weak var dateLabelView: UILabel!
    
    // MARK - Programmatically Added Views (Bottom Container)
    var circleProfileImage = UIImageView()
    var profileNameLabel = UILabel()
    var sideTextLabel = UILabel()
    var headlineLabel = UILabel()
    var subtitleLabel = UILabel()
    var wholeTextLabel = UILabel()
    var reviewImageView = UIImageView()
        // social icons
    var iconFacebook = UIImageView()
    var iconTwitter = UIImageView()
    var iconInstagram = UIImageView()
    var iconTumblr = UIImageView()
    var iconGoogle = UIImageView()
    
    var destination: Destination! {
        
        // MARK - Layer Attributes and Assignments
        didSet {
            // MARK - Rounded Corners
            cellImage.layer.cornerRadius = 5
            whiteView.layer.cornerRadius = 5
            cellImage.layer.masksToBounds = true
            whiteView.layer.masksToBounds = true
            
            // MARK - Shadows
                // Image Container Shadow
            imageContainerView.clipsToBounds = false
            imageContainerView.layer.shadowColor = Values.shared.shadowColor
            imageContainerView.layer.shadowOpacity = 0.5
            imageContainerView.layer.shadowOffset = CGSize.zero
            imageContainerView.layer.shadowRadius = 6
            imageContainerView.layer.shadowPath = UIBezierPath(roundedRect: imageContainerView.bounds, cornerRadius: 25).cgPath
            
                // White Container Shadow
            whiteContainerView.clipsToBounds = false
            whiteContainerView.layer.shadowColor = Values.shared.shadowColor
            whiteContainerView.layer.shadowOpacity = 0.5
            whiteContainerView.layer.shadowOffset = CGSize.zero
            whiteContainerView.layer.shadowRadius = 8
            whiteContainerView.layer.shadowPath = UIBezierPath(roundedRect: whiteContainerView.bounds, cornerRadius: 20).cgPath
            
                // Text Shadow
            titleLabelView.textDropShadow()
            priceLabelView.textDropShadow()
            descriptionLabelView.textDropShadow()
            descriptionLabelView.font = UIFont.italicSystemFont(ofSize: 14.0)
            dateLabelView.textDropShadow()
            
            // MARK - Borders
                // Button
            checkInButton.layer.opacity = 0.7
            checkInButton.layer.borderWidth = 1
            checkInButton.layer.borderColor = UIColor.white.cgColor
            
            // MARK - Add Label on the Check-In Button
            let checkInLabel = UILabel()
            checkInLabel.translatesAutoresizingMaskIntoConstraints = false
            checkInButton.addSubview(checkInLabel)
            checkInLabel.textColor = UIColor.white
            checkInLabel.centerXAnchor.constraint(equalTo: checkInButton.centerXAnchor).isActive = true
            checkInLabel.centerYAnchor.constraint(equalTo: checkInButton.centerYAnchor).isActive = true
            checkInLabel.text = "Check-In"
            checkInLabel.font = UIFont.systemFont(ofSize: 13.0)
            
            // MARK - Add Views on the Bottom Container
                // Circular Profile Image
            whiteView.addSubview(circleProfileImage)
            circleProfileImage.translatesAutoresizingMaskIntoConstraints = false
            circleProfileImage.clipsToBounds = true
            circleProfileImage.layer.cornerRadius = 20
            circleProfileImage.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 15).isActive = true
            circleProfileImage.leftAnchor.constraint(equalTo: whiteView.leftAnchor, constant: 15).isActive = true
            circleProfileImage.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
            circleProfileImage.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
            
                // Profile Name
            whiteView.addSubview(profileNameLabel)
            profileNameLabel.translatesAutoresizingMaskIntoConstraints = false
            profileNameLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
            profileNameLabel.textColor = UIColor.black
            profileNameLabel.leftAnchor.constraint(equalTo: circleProfileImage.rightAnchor, constant: 15).isActive = true
            profileNameLabel.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 15).isActive = true
            
                // Side Text
            whiteView.addSubview(sideTextLabel)
            sideTextLabel.translatesAutoresizingMaskIntoConstraints = false
            sideTextLabel.font = UIFont.systemFont(ofSize: 12.0)
            sideTextLabel.textColor = UIColor.gray
            sideTextLabel.leftAnchor.constraint(equalTo: profileNameLabel.rightAnchor, constant: 7).isActive = true
            sideTextLabel.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 15).isActive = true
            sideTextLabel.text = "shared a comment."
            
                // Date and Time Text (This is just a string)
            let commentTimeLabel = UILabel()
            whiteView.addSubview(commentTimeLabel)
            commentTimeLabel.translatesAutoresizingMaskIntoConstraints = false
            commentTimeLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
            commentTimeLabel.leftAnchor.constraint(equalTo: circleProfileImage.rightAnchor, constant: 15).isActive = true
            commentTimeLabel.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor, constant: 5).isActive = true
            commentTimeLabel.text = "07:00"
            
            let commentDateLabel = UILabel()
            whiteView.addSubview(commentDateLabel)
            commentDateLabel.translatesAutoresizingMaskIntoConstraints = false
            commentDateLabel.font = UIFont.systemFont(ofSize: 12.0)
            commentDateLabel.textColor = UIColor.gray
            commentDateLabel.leftAnchor.constraint(equalTo: commentTimeLabel.rightAnchor, constant: 7).isActive = true
            commentDateLabel.topAnchor.constraint(equalTo: sideTextLabel.bottomAnchor, constant: 7).isActive = true
            commentDateLabel.text = "am  MARCH 26, 2018"
            
                // Headline Text
            whiteView.addSubview(headlineLabel)
            headlineLabel.translatesAutoresizingMaskIntoConstraints = false
            headlineLabel.font = UIFont.boldSystemFont(ofSize: 19.0)
            headlineLabel.leftAnchor.constraint(equalTo: whiteView.leftAnchor, constant: 15).isActive = true
            headlineLabel.topAnchor.constraint(equalTo: circleProfileImage.bottomAnchor, constant: 20).isActive = true
            
                // Subtitle Text
            whiteView.addSubview(subtitleLabel)
            subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
            subtitleLabel.font = UIFont.italicSystemFont(ofSize: 14.0)
            subtitleLabel.textColor = UIColor.darkGray
            subtitleLabel.leftAnchor.constraint(equalTo: whiteView.leftAnchor, constant: 15).isActive = true
            subtitleLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 7).isActive = true
            
                // Whole Text Label
            whiteView.addSubview(wholeTextLabel)
            wholeTextLabel.translatesAutoresizingMaskIntoConstraints = false
            wholeTextLabel.font = UIFont.systemFont(ofSize: 14.0)
            wholeTextLabel.textColor = UIColor.gray
            wholeTextLabel.lineBreakMode = .byWordWrapping
            wholeTextLabel.numberOfLines = 0
            wholeTextLabel.leftAnchor.constraint(equalTo: whiteView.leftAnchor, constant: 15).isActive = true
            wholeTextLabel.rightAnchor.constraint(equalTo: whiteView.rightAnchor, constant: 10).isActive = true
            wholeTextLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 15).isActive = true
            
                // Review Image View
            whiteView.addSubview(reviewImageView)
            reviewImageView.clipsToBounds = true
            reviewImageView.translatesAutoresizingMaskIntoConstraints = false
            reviewImageView.leftAnchor.constraint(equalTo: whiteView.leftAnchor, constant: 15).isActive = true
            reviewImageView.rightAnchor.constraint(equalTo: whiteView.rightAnchor, constant: 15).isActive = true
            reviewImageView.topAnchor.constraint(equalTo: wholeTextLabel.bottomAnchor, constant: 20).isActive = true
            reviewImageView.widthAnchor.constraint(equalTo: whiteView.widthAnchor, multiplier: 1, constant: -30).isActive = true
            reviewImageView.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
            reviewImageView.contentMode = .scaleAspectFill
            
                // Share & Social Media Icons
                    // Share
            let shareTextLabel = UILabel()
            whiteView.addSubview(shareTextLabel)
            shareTextLabel.translatesAutoresizingMaskIntoConstraints = false
            shareTextLabel.font = UIFont.italicSystemFont(ofSize: 12.0)
            shareTextLabel.textColor = UIColor.gray
            shareTextLabel.leftAnchor.constraint(equalTo: whiteView.leftAnchor, constant: 15).isActive = true
            shareTextLabel.topAnchor.constraint(equalTo: reviewImageView.bottomAnchor, constant: 20).isActive = true
            shareTextLabel.text = "Share".uppercased()
            
                    // Icon - Facebook
            whiteView.addSubview(iconFacebook)
            iconFacebook.translatesAutoresizingMaskIntoConstraints = false
            iconFacebook.topAnchor.constraint(equalTo: reviewImageView.bottomAnchor, constant: 18).isActive = true
            iconFacebook.leftAnchor.constraint(equalTo: shareTextLabel.rightAnchor, constant: 95).isActive = true
            iconFacebook.widthAnchor.constraint(equalToConstant: 18.0).isActive = true
            iconFacebook.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
            iconFacebook.image = UIImage(named:"icn-facebook")
            
                    // Icon - Twitter
            whiteView.addSubview(iconTwitter)
            iconTwitter.translatesAutoresizingMaskIntoConstraints = false
            iconTwitter.topAnchor.constraint(equalTo: reviewImageView.bottomAnchor, constant: 18).isActive = true
            iconTwitter.leftAnchor.constraint(equalTo: iconFacebook.rightAnchor, constant: 5).isActive = true
            iconTwitter.widthAnchor.constraint(equalToConstant: 18.0).isActive = true
            iconTwitter.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
            iconTwitter.image = UIImage(named:"icn-twitter")
            
                    // Icon - Instagram
            whiteView.addSubview(iconInstagram)
            iconInstagram.translatesAutoresizingMaskIntoConstraints = false
            iconInstagram.topAnchor.constraint(equalTo: reviewImageView.bottomAnchor, constant: 18).isActive = true
            iconInstagram.leftAnchor.constraint(equalTo: iconTwitter.rightAnchor, constant: 5).isActive = true
            iconInstagram.widthAnchor.constraint(equalToConstant: 18.0).isActive = true
            iconInstagram.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
            iconInstagram.image = UIImage(named:"icn-instagram")
            
                    // Icon - Tumblr
            whiteView.addSubview(iconTumblr)
            iconTumblr.translatesAutoresizingMaskIntoConstraints = false
            iconTumblr.topAnchor.constraint(equalTo: reviewImageView.bottomAnchor, constant: 18).isActive = true
            iconTumblr.leftAnchor.constraint(equalTo: iconInstagram.rightAnchor, constant: 5).isActive = true
            iconTumblr.widthAnchor.constraint(equalToConstant: 18.0).isActive = true
            iconTumblr.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
            iconTumblr.image = UIImage(named:"icn-tumblr")
            
                    // Icon - Google
            whiteView.addSubview(iconGoogle)
            iconGoogle.translatesAutoresizingMaskIntoConstraints = false
            iconGoogle.topAnchor.constraint(equalTo: reviewImageView.bottomAnchor, constant: 18).isActive = true
            iconGoogle.leftAnchor.constraint(equalTo: iconTumblr.rightAnchor, constant: 5).isActive = true
            iconGoogle.widthAnchor.constraint(equalToConstant: 18.0).isActive = true
            iconGoogle.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
            iconGoogle.image = UIImage(named:"icn-google")
            
            updateUI()
        }
        
    }

    // MARK - Update UI elements with the correct data
    func updateUI() {
        cellImage?.image = destination.featuredImage!
        titleLabelView.text = destination.title.uppercased()
        priceLabelView.text = destination.price.uppercased()
        descriptionLabelView.text = destination.description
        dateLabelView.text = destination.date
        
        circleProfileImage.image = destination.profileImage
        profileNameLabel.text = destination.profileName
        headlineLabel.text = destination.headline
        subtitleLabel.text = destination.subtitle
        wholeTextLabel.text = destination.wholeText
        reviewImageView.image = destination.reviewImage
    }
    
}

// Drop shadow extension for texts
extension UILabel {
    func textDropShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    
    static func createCustomLabel() -> UILabel {
        let label = UILabel()
        label.textDropShadow()
        return label
    }
}
