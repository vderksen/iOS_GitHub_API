//
//  FollowUser.swift
//  SpeerTechnologies_iOS_assessment
//
//  Created by Valya Derksen on 2021-10-10.
//

struct FollowUser : Codable {
    var username : String
    var url : String
    
    init(){
        self.username = "Not found"
        self.url = "Not found"
    }
    
    enum CodingKeys : String, CodingKey {
        case username = "login"
        case url = "url"
    }
    
    func encode(to encoder: Encoder) throws {
        // nothing to encode
    }
    
    init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try response.decodeIfPresent(String.self, forKey: .username) ?? "Not found"
        self.url = try response.decodeIfPresent(String.self, forKey: .url) ?? "Not found"
    }
}
