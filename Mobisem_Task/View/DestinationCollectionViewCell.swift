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
    var checkInLabel = UILabel()
    var commentTimeLabel = UILabel()
    var commentDateLabel = UILabel()
    var shareTextLabel = UILabel()
    
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
    
    // Add subviews on the page
    private func prepareViewComponent(){
        checkInButton?.addSubview(checkInLabel)
        whiteView?.addSubview(circleProfileImage)
        whiteView?.addSubview(profileNameLabel)
        whiteView?.addSubview(sideTextLabel)
        whiteView?.addSubview(commentTimeLabel)
        whiteView?.addSubview(commentDateLabel)
        whiteView?.addSubview(headlineLabel)
        whiteView?.addSubview(subtitleLabel)
        whiteView?.addSubview(wholeTextLabel)
        whiteView?.addSubview(reviewImageView)
        whiteView?.addSubview(shareTextLabel)
        whiteView?.addSubview(iconFacebook)
        whiteView?.addSubview(iconTwitter)
        whiteView?.addSubview(iconInstagram)
        whiteView?.addSubview(iconTumblr)
        whiteView?.addSubview(iconGoogle)
    }
    
    // MARK - Set shadows for views
    private func setShadows() {
        // MARK - Rounded Corners
        cellImage.layer.cornerRadius = 5
        whiteView.layer.cornerRadius = 5
        cellImage.layer.masksToBounds = true
        whiteView.layer.masksToBounds = true
        
        // MARK - Shadows
        // Image Container Shadow
        imageContainerView.clipsToBounds = false
        imageContainerView.layer.shouldRasterize = true
        imageContainerView.layer.rasterizationScale = UIScreen.main.scale
        imageContainerView.layer.shadowColor = Values.shared.shadowColor
        imageContainerView.layer.shadowOpacity = 0.5
        imageContainerView.layer.shadowRadius = 6
        imageContainerView.layer.shadowPath = UIBezierPath(roundedRect: imageContainerView.bounds, cornerRadius: 25).cgPath
        
        // White Container Shadow
        whiteContainerView.clipsToBounds = false
        whiteContainerView.layer.shouldRasterize = true
        whiteContainerView.layer.rasterizationScale = UIScreen.main.scale
        whiteContainerView.layer.shadowColor = Values.shared.shadowColor
        whiteContainerView.layer.shadowOpacity = 0.5
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
    }
    
    // MARK - Set constraints for all views
    private func setConstraints() {
        
        // MARK - Add Label on the Check-In Button
        checkInLabel.text = "Check-In"
        checkInLabel.font = UIFont.systemFont(ofSize: 13.0)
        checkInLabel.textColor = UIColor.white
        checkInLabel.arrangeConstraints(centerX: checkInButton.centerXAnchor, centerY: checkInButton.centerYAnchor)
        
        // MARK - Add Views on the Bottom Container
        // Circular Profile Image
        circleProfileImage.clipsToBounds = true
        circleProfileImage.layer.cornerRadius = 20
        circleProfileImage.arrangeConstraints(whiteView.leftAnchor, leftConstant: 15,
                                              top: whiteContainerView.topAnchor, topConstant: 15,
                                              wEqualToConstant: 40, hEqualToConstant: 40)
        
        // Profile Name
        profileNameLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
        profileNameLabel.textColor = UIColor.black
        profileNameLabel.arrangeConstraints(circleProfileImage.rightAnchor, leftConstant: 15, top: whiteView.topAnchor, topConstant: 15)
        
        // Side Text
        sideTextLabel.text = "shared a comment."
        sideTextLabel.font = UIFont.systemFont(ofSize: 12.0)
        sideTextLabel.textColor = UIColor.gray
        sideTextLabel.arrangeConstraints(profileNameLabel.rightAnchor, leftConstant: 7, top: whiteView.topAnchor, topConstant: 15)
        
        // Date and Time Text (This is just a string)
        commentTimeLabel.text = "07:00"
        commentTimeLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        commentTimeLabel.arrangeConstraints(circleProfileImage.rightAnchor, leftConstant: 15,
                                            top: profileNameLabel.bottomAnchor, topConstant: 5)
        
        commentDateLabel.text = "am  MARCH 26, 2018"
        commentDateLabel.font = UIFont.systemFont(ofSize: 12.0)
        commentDateLabel.textColor = UIColor.gray
        commentDateLabel.arrangeConstraints(commentTimeLabel.rightAnchor, leftConstant: 7,
                                            top: sideTextLabel.bottomAnchor, topConstant: 7)
        
        // Headline Text
        headlineLabel.font = UIFont.boldSystemFont(ofSize: 19.0)
        headlineLabel.arrangeConstraints(whiteView.leftAnchor, leftConstant: 15,
                                         top: circleProfileImage.bottomAnchor, topConstant: 20)
        
        // Subtitle Text
        subtitleLabel.font = UIFont.italicSystemFont(ofSize: 14.0)
        subtitleLabel.textColor = UIColor.darkGray
        subtitleLabel.arrangeConstraints(whiteView.leftAnchor, leftConstant: 15,
                                         top: headlineLabel.bottomAnchor, topConstant: 7)
        
        // Whole Text Label
        wholeTextLabel.font = UIFont.systemFont(ofSize: 14.0)
        wholeTextLabel.textColor = UIColor.gray
        wholeTextLabel.lineBreakMode = .byWordWrapping
        wholeTextLabel.numberOfLines = 0
        wholeTextLabel.arrangeConstraints(whiteView.leftAnchor, leftConstant: 15,
                                          right: whiteView.rightAnchor, rightConstant: 10,
                                          top: subtitleLabel.bottomAnchor, topConstant: 15)
        
        // Review Image View
        reviewImageView.clipsToBounds = true
        reviewImageView.contentMode = .scaleAspectFill
        reviewImageView.arrangeConstraints(whiteView.leftAnchor, leftConstant: 15,
                                           right: whiteView.rightAnchor, rightConstant: 15,
                                           top: wholeTextLabel.bottomAnchor, topConstant: 20,
                                           width: whiteView.widthAnchor, widthMultiplier: 1, widthConstant: -30,
                                           hEqualToConstant: 80)
        
        // Share & Social Media Icons
        // Share
        shareTextLabel.text = "Share".uppercased()
        shareTextLabel.font = UIFont.italicSystemFont(ofSize: 12.0)
        shareTextLabel.textColor = UIColor.gray
        shareTextLabel.arrangeConstraints(whiteView.leftAnchor, leftConstant: 15, top: reviewImageView.bottomAnchor, topConstant: 20)
        
        // Icon - Facebook
        iconFacebook.translatesAutoresizingMaskIntoConstraints = false
        iconFacebook.topAnchor.constraint(equalTo: reviewImageView.bottomAnchor, constant: 18).isActive = true
        iconFacebook.leftAnchor.constraint(equalTo: shareTextLabel.rightAnchor, constant: 95).isActive = true
        iconFacebook.widthAnchor.constraint(equalToConstant: 18.0).isActive = true
        iconFacebook.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        iconFacebook.image = UIImage(named:"icn-facebook")
        
        // Icon - Twitter
        iconTwitter.translatesAutoresizingMaskIntoConstraints = false
        iconTwitter.topAnchor.constraint(equalTo: reviewImageView.bottomAnchor, constant: 18).isActive = true
        iconTwitter.leftAnchor.constraint(equalTo: iconFacebook.rightAnchor, constant: 5).isActive = true
        iconTwitter.widthAnchor.constraint(equalToConstant: 18.0).isActive = true
        iconTwitter.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        iconTwitter.image = UIImage(named:"icn-twitter")
        
        // Icon - Instagram
        
        iconInstagram.translatesAutoresizingMaskIntoConstraints = false
        iconInstagram.topAnchor.constraint(equalTo: reviewImageView.bottomAnchor, constant: 18).isActive = true
        iconInstagram.leftAnchor.constraint(equalTo: iconTwitter.rightAnchor, constant: 5).isActive = true
        iconInstagram.widthAnchor.constraint(equalToConstant: 18.0).isActive = true
        iconInstagram.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        iconInstagram.image = UIImage(named:"icn-instagram")
        
        // Icon - Tumblr
        
        iconTumblr.translatesAutoresizingMaskIntoConstraints = false
        iconTumblr.topAnchor.constraint(equalTo: reviewImageView.bottomAnchor, constant: 18).isActive = true
        iconTumblr.leftAnchor.constraint(equalTo: iconInstagram.rightAnchor, constant: 5).isActive = true
        iconTumblr.widthAnchor.constraint(equalToConstant: 18.0).isActive = true
        iconTumblr.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        iconTumblr.image = UIImage(named:"icn-tumblr")
        
        // Icon - Google
        
        iconGoogle.translatesAutoresizingMaskIntoConstraints = false
        iconGoogle.topAnchor.constraint(equalTo: reviewImageView.bottomAnchor, constant: 18).isActive = true
        iconGoogle.leftAnchor.constraint(equalTo: iconTumblr.rightAnchor, constant: 5).isActive = true
        iconGoogle.widthAnchor.constraint(equalToConstant: 18.0).isActive = true
        iconGoogle.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        iconGoogle.image = UIImage(named:"icn-google")
    }
    
    // MARK - Update UI elements with the correct data
    func updateUI() {
        cellImage?.image = destination!.featuredImage!
        titleLabelView.text = destination!.title.uppercased()
        priceLabelView.text = destination!.price.uppercased()
        descriptionLabelView.text = destination!.description
        dateLabelView.text = destination!.date
        
        circleProfileImage.image = destination!.profileImage
        profileNameLabel.text = destination!.profileName
        headlineLabel.text = destination!.headline
        subtitleLabel.text = destination!.subtitle
        wholeTextLabel.text = destination!.wholeText
        reviewImageView.image = destination!.reviewImage
    }
    
    var destination: Destination? {
        
        willSet {
            setShadows()
        }
        
        didSet {
            prepareViewComponent()
            setConstraints()
            updateUI()
        }
        
    }
    
}

// Function for constraints
extension UIView {
    
    func arrangeConstraints(_ left: NSLayoutXAxisAnchor?=nil, leftConstant: CGFloat?=nil,
                        right: NSLayoutXAxisAnchor?=nil, rightConstant: CGFloat?=nil,
                        top: NSLayoutYAxisAnchor?=nil, topConstant: CGFloat?=nil,
                        bottom: NSLayoutYAxisAnchor?=nil, bottomConstant: CGFloat?=nil,
                        width: NSLayoutDimension?=nil, widthMultiplier: CGFloat?=nil, widthConstant: CGFloat?=nil, wEqualToConstant: CGFloat?=nil,
                        height: NSLayoutDimension?=nil, heightMultiplier: CGFloat?=nil, heightConstant: CGFloat?=nil, hEqualToConstant: CGFloat?=nil,
                        centerX: NSLayoutXAxisAnchor?=nil, centerY: NSLayoutYAxisAnchor?=nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let left = left, let leftConstant = leftConstant {
            self.leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }
        
        if let right = right, let rightConstant = rightConstant {
            self.rightAnchor.constraint(equalTo: right, constant: rightConstant).isActive = true
        }
        
        if let top = top, let topConstant = topConstant {
            self.topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        
        if let bottom = bottom, let bottomConstant = bottomConstant {
            self.bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant).isActive = true
        }
        
        if let width = width, let widthConstant = widthConstant, let widthMultiplier = widthMultiplier {
            self.widthAnchor.constraint(equalTo: width, multiplier: widthMultiplier, constant: widthConstant).isActive = true
        }
        
        if let height = height, let heightConstant = heightConstant, let heightMultiplier = heightMultiplier {
            self.heightAnchor.constraint(equalTo: height, multiplier: heightMultiplier, constant: heightConstant).isActive = true
        }
        
        if let wEqualToConstant = wEqualToConstant {
            self.widthAnchor.constraint(equalToConstant: wEqualToConstant).isActive = true
        }
        
        if let hEqualToConstant = hEqualToConstant {
            self.heightAnchor.constraint(equalToConstant: hEqualToConstant).isActive = true
        }
        
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
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



