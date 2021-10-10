//
//  ViewController.swift
//  SpeerTechnologies_iOS_assessment
//
//  Created by Valya Derksen on 2021-10-09.
//

import UIKit
import Combine

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet var seachBar: UISearchBar!
    @IBOutlet var lblResult: UILabel!
    @IBOutlet weak var viewProfile: UIButton!

    // Create instances for fetch API data
    private let userFetcher = UserFetcher.getInstance()
    private var userInfo : User = User()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seachBar.delegate = self
    }

    // SEARCH BAR: get input and use input to fetch data from API
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchUser = searchBar.text?.lowercased()
        print(searchUser!)
        let apiURL = "https://api.github.com/users/" + searchUser!
        print(apiURL)
        self.userFetcher.fetchDataFromAPI(apiURL: apiURL)
        self.receiveChanges()
    }
    
    private func receiveChanges(){
        self.userFetcher.$userInfo.receive(on: RunLoop.main)
            .sink { (user) in
                print(#function, "Received user info: ", user)
                self.userInfo = user
                self.lblResult.text = "\(self.userInfo.username)"
                if self.lblResult.text != "Not found" {
                    //Make button2 Visible
                    self.viewProfile.isHidden = false // if we did got valid result, make view profile buttom invisiable
                } else {
                    self.viewProfile.isHidden = true // if we got valid result, make view profile buttom visiable
                }
                self.viewDidLoad()
            }
            .store(in : &cancellables)
    }
    
    // NAVIGATION: set up segue Navigation to UserProfileViewController by clicking "view profile" button
    @IBAction func viewProfile(sender: AnyObject) {
        performSegue(withIdentifier: "segueUserProfile", sender: self)
        }

    // pass object userInfo to UserProfileViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! UserProfileViewController
        destVC.userInfo = self.userInfo
    }

}

