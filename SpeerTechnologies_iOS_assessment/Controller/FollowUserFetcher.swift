//
//  FollowUserFetcher.swift
//  SpeerTechnologies_iOS_assessment
//
//  Created by Valya Derksen on 2021-10-10.
//

import Foundation

class FollowUserFetcher: ObservableObject{
    
    @Published var followUserInfo = [FollowUser]()
    
    //singleton instance
    private static var shared : FollowUserFetcher?
    
    static func getInstance() -> FollowUserFetcher{
        if shared != nil{
            //instance already exists
            return shared!
        }else{
            // create a new singlton instance
            return FollowUserFetcher()
        }
    }
    
    func fetchDataFromAPI(apiURL : String){
        guard let api = URL(string: apiURL) else {
            return
        }
        URLSession.shared.dataTask(with: api){ (data: Data?, response: URLResponse?, error: Error?) in
            if let err = error {
                print(#function, "Could not fetch data", err)
            }else {
                // receive data or response
                DispatchQueue.global().async {
                    do {
                        if let jsonData = data {
                            let decoder = JSONDecoder()
                            // use this responce if array of JSON objects
                            let decodedList = try decoder.decode([FollowUser].self, from: jsonData)
                            // use this responce if JSON object
                            DispatchQueue.main.async {
                                self.followUserInfo = decodedList
                            }
                        } else {
                            print(#function, "No JSON data received")
                        }
                    } catch  let error {
                        print(#function, error)
                    }
                }
            }
        }.resume()
    }
}

