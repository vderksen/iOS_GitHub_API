//
//  UserFetcher.swift
//  SpeerTechnologies_iOS_assessment
//
//  Created by Valya Derksen on 2021-10-09.
//

import Foundation

class UserFetcher: ObservableObject{
    
    @Published var userInfo = User()
    
    //singleton instance
    private static var shared : UserFetcher?
    
    static func getInstance() -> UserFetcher{
        if shared != nil{
            //instance already exists
            return shared!
        }else{
            // create a new singlton instance
            return UserFetcher()
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
                            let decodedList = try decoder.decode(User.self, from: jsonData)
                            // use this responce if JSON object
                            DispatchQueue.main.async {
                                self.userInfo = decodedList
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
