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
    var data = [CellData]()
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTumblrData()
        data = [CellData.init(message: "weed-and-poetry", image: #imageLiteral(resourceName: "testPic"), profileImage: #imageLiteral(resourceName: "profile"))]
        setupView()
        setupSearchController()
    }

    private func fetchTumblrData() {
        let jsonStringURL = URL(string: "https://weed-and-poetry.tumblr.com/api/read/")
        guard let xml = XML(contentsOf: jsonStringURL!) else { return }
        guard let name = xml[0][1][0]["tumblelog"]?.attributes["name"] else { return }
        guard let imageURL = xml[0][1][0]["photo-url"]?.text else { return }
        guard let profileImage = xml[0][1][0]["tumblelog"]?.attributes["avatar-url-40"] else { return }

        let postImageURL = URL(string: imageURL)
        let profileImageURL = URL(string: profileImage)

        let post = Post(name: name, imageURL: postImageURL, profileImageURL: profileImageURL)
        self.posts.append(post)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostPrototypeCell
//        cell.postImage = data[indexPath.row].image
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
        return data.count
    }

    private func setupView() {
        self.tableView.register(PostPrototypeCell.self, forCellReuseIdentifier: "postCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
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

