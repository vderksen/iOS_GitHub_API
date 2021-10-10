//
//  FollowUserViewController.swift
//  SpeerTechnologies_iOS_assessment
//
//  Created by Valya Derksen on 2021-10-10.
//

import UIKit
import Combine

class FollowUserViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var descriptionLbl : UILabel!
    @IBOutlet weak var followersLbl: UILabel!
    @IBOutlet weak var followingLbl: UILabel!
    
    // instance of user object to display. The data is passed from TableViewController
    public var followUserInfo : User = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: followUserInfo.avatar)
        avatar.load(url: url!)
        self.userNameLbl.text = followUserInfo.username
        self.nameLbl.text = "Name: " + followUserInfo.name
        self.descriptionLbl.text = "Description: " + followUserInfo.description
        self.followersLbl.text = "Followers: " + String(followUserInfo.follower)
        self.followingLbl.text = "Following: " + String(followUserInfo.following)
    }

}
