//
//  UserProfileViewController.swift
//  SpeerTechnologies_iOS_assessment
//
//  Created by Valya Derksen on 2021-10-09.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userNameLblb: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var followers: UIButton!
    @IBOutlet weak var following: UIButton!
    
    // instance of user object to display. The data is passed from ViewController
    public var userInfo : User = User()
    
    // instance of api url to Followers or Following list to pass to TableView
    var urlForList : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: userInfo.avatar)
        userAvatar.load(url: url!)
        self.userNameLblb.text = userInfo.username
        self.nameLbl.text = "Name: " + userInfo.name
        self.descriptionLbl.text = "Description: " + userInfo.description
        self.followers.setTitle(String(userInfo.follower), for: .normal)
        self.following.setTitle(String(userInfo.following), for: .normal)
    }
    
    // NAVIGATION: set up segue Navigation to TableViewController(list of Followers) when number of followers clikced
    @IBAction func followers(sender: AnyObject) {
        self.urlForList = String(self.userInfo.url + "/followers")
        performSegue(withIdentifier: "segueList", sender: self)
    }

    // NAVIGATION: set up segue Navigation to TableViewController(list of Following) when number of following clikced
    @IBAction func following(sender: AnyObject) {
        self.urlForList = String(self.userInfo.url + "/following")
        performSegue(withIdentifier: "segueList", sender: self)
    }
    
    // pass api url to Followers or Following list
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! TableViewController
        destVC.url = self.urlForList
    }

}

// EXTENTION to get image from url
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


