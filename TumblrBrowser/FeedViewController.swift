//
//  FeedViewController.swift
//  TumblrBrowser
//
//  Created by Kobsonauta on 20.03.2018.
//  Copyright © 2018 Kobsonauta. All rights reserved.
//

import UIKit

struct CellData {
    var message: String?
    var image: UIImage?
    var profileImage: UIImage?
}

struct Post {
    var name: String?
    var imageURL: URL?
    var profileImageURL: URL?
}


class FeedViewController: UITableViewController {

    var searchController : UISearchController!
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTumblrData()
        setupView()
        setupSearchController()
    }

    private func fetchTumblrData() {
        let jsonStringURL = URL(string: "https://ballerinaproject.tumblr.com/api/read/")
        guard let xml = XML(contentsOf: jsonStringURL!) else { return }
        let postsRange = xml[0][1].children.count
        print(postsRange)
        for i in 0..<postsRange {
            guard let name = xml[0][1][i]["tumblelog"]?.attributes["name"] else { return }
            guard let imageURL = xml[0][1][i]["photo-url"]?.text else { return }
            guard let profileImage = xml[0][1][i]["tumblelog"]?.attributes["avatar-url-40"] else { return }
            print(imageURL)
            print(i)
            let postImageURL = URL(string: imageURL)
            let profileImageURL = URL(string: profileImage)

            let post = Post(name: name, imageURL: postImageURL, profileImageURL: profileImageURL)
            self.posts.append(post)
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostPrototypeCell
        cell.message = posts[indexPath.row].name
        let profileImageUrl: URL? = posts[indexPath.row].profileImageURL
        if let imageUrl = profileImageUrl {
            PhotoManager.shared.getPhoto(from: imageUrl, completion: {(image) -> (Void) in
                if let image = image {
                    cell.profileImageView.image = image
                }
            })
        }
        let postImageUrl: URL? = posts[indexPath.row].imageURL
        if let imageUrl = postImageUrl {
            PhotoManager.shared.getPhoto(from: imageUrl, completion: {(image) -> (Void) in
                if let image = image {
                    cell.postImageView.image = image
                }
            })
        }
        cell.layoutSubviews()
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    private func setupView() {
        self.tableView.register(PostPrototypeCell.self, forCellReuseIdentifier: "postCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 250
    }

    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search Tumblr Profile"

        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
    }
}

