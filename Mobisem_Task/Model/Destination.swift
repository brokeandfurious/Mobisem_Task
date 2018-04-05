//
//  Destination.swift
//  Mobisem_Task
//
//  Created by Murat Ekrem Kolcalar on 3/19/18.
//  Copyright © 2018 murtilicious. All rights reserved.
//

import UIKit

class Destination {
    // MARK - API
    var title = ""
    var price = ""
    var description = ""
    var date = ""
    var featuredImage: UIImage!
    
    var profileImage: UIImage!
    var profileName = ""
    var headline = ""
    var subtitle = ""
    var wholeText = ""
    var reviewImage: UIImage!
    
    init(title: String, price: String, description: String, date: String, featuredImage: UIImage!, profileImage: UIImage!, profileName: String, headline: String, subtitle: String, wholeText: String, reviewImage: UIImage!) {
        self.title = title
        self.price = price
        self.description = description
        self.date = date
        self.featuredImage = featuredImage
        
        self.profileImage = profileImage
        self.profileName = profileName
        self.headline = headline
        self.subtitle = subtitle
        self.wholeText = wholeText
        self.reviewImage = reviewImage
    }
    
    // MARK - Private
    
    static func createDestination() -> [Destination] {
        return [
            Destination(title: "New York", price: "$420", description: "Empire State Building", date: "10/6/2018", featuredImage: UIImage(named: "ny")!, profileImage: UIImage(named: "avt-keanu"), profileName: "Luke Price", headline: "Vajrasana Retreat Center", subtitle: "Walsham-le-willows", wholeText: "Lorem ipsum dolor amet whatever keffiyeh art party aesthetic direct trade. Coloring book put a bird on it enamel pin truffaut shaman, brunch vegan 8-bit brooklyn four loko hoodie. Pitchfork semiotics activated charcoal jianbing 8-bit, blue bottle seitan man braid YOLO heirloom williamsburg readymade retro. Cronut next level raclette hoodie.", reviewImage: UIImage(named: "ny")),
            Destination(title: "Paris", price: "$1299", description: "The Eiffel Tower", date: "10/6/2018", featuredImage: UIImage(named: "paris")!, profileImage: UIImage(named: "avt-arya"), profileName: "Arya Stark", headline: "The Louvre Museum", subtitle: "Epiphany and Inspiration", wholeText: "It is architecture that fades into the background, allowing your mind to concentrate. This is another sentence, just trying out some new things.", reviewImage: UIImage(named: "r-paris")),
            Destination(title: "Toronto", price: "$1110", description: "Niagara Falls", date: "10/6/2018", featuredImage: UIImage(named: "toronto")!, profileImage: UIImage(named: "avt-girl"), profileName: "Katya Zamo", headline: "Saratoga Center", subtitle: "Epitome of Fine Arta", wholeText: "It is architecture that fades into the background.", reviewImage: UIImage(named: "ny")),
            Destination(title: "Phuket", price: "$990", description: "Empire State Building", date: "10/6/2018", featuredImage: UIImage(named: "woods")!, profileImage: UIImage(named: "ny"), profileName: "Tim Hortons", headline: "Crystal Clear", subtitle: "I want to go back.", wholeText: "It is architecture that fades into the background, allowing your mind to concentrate.", reviewImage: UIImage(named: "phuket")),
            Destination(title: "Istanbul", price: "$720", description: "Hagia Sophia", date: "10/6/2018", featuredImage: UIImage(named: "r-istanbul")!, profileImage: UIImage(named: "ny"), profileName: "Luke Price", headline: "A Night to Remember", subtitle: "Street Cats", wholeText: "It is architecture that fades into the background, allowing your mind to concentrate.", reviewImage: UIImage(named: "istanbul")),
            Destination(title: "Istanbul", price: "$720", description: "Hagia Sophia", date: "10/6/2018", featuredImage: UIImage(named: "r-istanbul")!, profileImage: UIImage(named: "ny"), profileName: "Luke Price", headline: "A Night to Remember", subtitle: "Street Cats", wholeText: "It is architecture that fades into the background, allowing your mind to concentrate.", reviewImage: UIImage(named: "istanbul")),
            Destination(title: "Istanbul", price: "$720", description: "Hagia Sophia", date: "10/6/2018", featuredImage: UIImage(named: "r-istanbul")!, profileImage: UIImage(named: "ny"), profileName: "Luke Price", headline: "A Night to Remember", subtitle: "Street Cats", wholeText: "It is architecture that fades into the background, allowing your mind to concentrate.", reviewImage: UIImage(named: "istanbul"))
        ]
    }
}
