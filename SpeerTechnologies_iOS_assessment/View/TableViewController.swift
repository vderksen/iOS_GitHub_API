//
//  TableViewController.swift
//  SpeerTechnologies_iOS_assessment
//
//  Created by Valya Derksen on 2021-10-09.
//

import UIKit
import Combine

class TableViewController: UITableViewController {
    
    // instance of API url to followers or following list (passed from UserProfileViewController)
    var url : String = ""
    
    // Create instances for fetch API data to get followers or following array
    private let followUserFetcher = FollowUserFetcher.getInstance()
    private var usersCellList : [FollowUser] = [FollowUser]()
    private var cancellables: Set<AnyCancellable> = []
    
    // Create instances for fetch API data about user from followers or following list (this data will be past to FollowerUserViewController)
    private let userFetcher = UserFetcher.getInstance()
    public var followUserInfo : User = User()
    private var cancellables2: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // fetch the array of followers or following users
        self.followUserFetcher.fetchDataFromAPI(apiURL: url)
        self.receiveChanges()
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.usersCellList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserCell
        cell.lblUserName.text = "\(self.usersCellList[indexPath.row].username)"
        return cell
    }
    
    // Receive changes for followers or following list
    private func receiveChanges(){
        self.followUserFetcher.$followUserInfo.receive(on: RunLoop.main)
            .sink{ (user) in
                self.usersCellList.removeAll()
                self.usersCellList.append(contentsOf: user)
                self.tableView.reloadData()
            }
            .store(in : &cancellables)
    }

    // NAVIGATION: Perform action when cell is tapped (get user url to fetch data and perfom segue to FollowUserViewController)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // get the url to user profile for cell being tapped
        let url = String(usersCellList[indexPath.row].url)
        print(url)
        // use this url to fetch data abiut the user
        self.userFetcher.fetchDataFromAPI(apiURL: url)
        self.receiveChanges2()
        print(followUserInfo)
        // perfom segue to this user profile
        if (followUserInfo.avatar != "Not found") {
            performSegue(withIdentifier: "segueFollowUserProfile", sender: self)
        }
    }
    
    private func receiveChanges2(){
        self.userFetcher.$userInfo.receive(on: RunLoop.main)
            .sink { (user) in
                print(#function, "Received user info: ", user)
                self.followUserInfo = user
                self.viewDidLoad()
            }
            .store(in : &cancellables2)
    }
    
    // Pass object following or followers to FollowUserViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! FollowUserViewController
        destVC.followUserInfo = self.followUserInfo
    }

    
       
}
