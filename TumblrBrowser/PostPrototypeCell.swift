//
//  PostPrototypeCell.swift
//  TumblrBrowser
//
//  Created by Kobsonauta on 21.03.2018.
//  Copyright © 2018 Kobsonauta. All rights reserved.
//

import Foundation
import UIKit

class PostPrototypeCell: UITableViewCell {
    
    var message: String?
    var postImage: UIImage?
    var profileImage: UIImage?
    
    var messageView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.font = UIFont.boldSystemFont(ofSize: 14)
        return textView
    }()
    
    var postImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    var profileImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 3
        imageView.clipsToBounds = true
        return imageView
    }()

    var customSeparatorView : UIView = {
        var separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor(red: 0/255.0, green: 21/255.0, blue: 41/255.0, alpha: 1.0)
        return separator
    }()


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(messageView)
        self.addSubview(postImageView)
        self.addSubview(profileImageView)
        self.addSubview(customSeparatorView)

        messageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        messageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 13).isActive = true

        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        profileImageView.rightAnchor.constraint(equalTo: self.messageView.leftAnchor, constant: -5).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: self.postImageView.topAnchor, constant: -10).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true

        postImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        postImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        postImageView.bottomAnchor.constraint(equalTo: self.customSeparatorView.topAnchor).isActive = true
        postImageView.heightAnchor.constraint(equalTo: widthAnchor ).isActive = true

        customSeparatorView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        customSeparatorView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        customSeparatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        customSeparatorView.heightAnchor.constraint(equalToConstant: 15).isActive = true


    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let message = message {
            messageView.text = message
        }
        
        if let image = postImage {
            postImageView.image = image
        }

        if let profile = profileImage {
            profileImageView.image = profile
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
