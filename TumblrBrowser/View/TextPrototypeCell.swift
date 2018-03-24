//
//  TextPrototypeCell.swift
//  TumblrBrowser
//
//  Created by Kobsonauta on 24.03.2018.
//  Copyright © 2018 Kobsonauta. All rights reserved.
//

import Foundation
import UIKit

class TextPrototypeCell: UITableViewCell {

    var profileName: String?
    var profileImage: UIImage?
    var message: String?

    var profileNameView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.font = UIFont.boldSystemFont(ofSize: 14)
        return textView
    }()

    var profileImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 3
        imageView.clipsToBounds = true
        return imageView
    }()

    var messageView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.font = UIFont.boldSystemFont(ofSize: 14)
        return textView
    }()

    var customSeparatorView : UIView = {
        var separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor(red: 0/255.0, green: 21/255.0, blue: 41/255.0, alpha: 1.0)
        return separator
    }()


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.addSubview(profileNameView)
        self.addSubview(profileImageView)
        self.addSubview(messageView)
        self.addSubview(customSeparatorView)

        profileNameView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        profileNameView.topAnchor.constraint(equalTo: self.topAnchor, constant: 13).isActive = true
        profileNameView.leftAnchor.constraint(equalTo: self.profileImageView.rightAnchor, constant: 5)

        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true

        messageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        messageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        messageView.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 10).isActive = true


        customSeparatorView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        customSeparatorView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        customSeparatorView.topAnchor.constraint(equalTo: self.messageView.bottomAnchor).isActive = true
        customSeparatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        customSeparatorView.heightAnchor.constraint(equalToConstant: 15).isActive = true

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let profileName = profileName {
            profileNameView.text = profileName
        }

        if let profileImg = profileImage {
            profileImageView.image = profileImg
        }

        if let message = message {
            messageView.text = message
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}