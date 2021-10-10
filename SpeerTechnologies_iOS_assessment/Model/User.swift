//
//  User.swift
//  SpeerTechnologies_iOS_assessment
//
//  Created by Valya Derksen on 2021-10-09.
//

import Foundation

struct User : Codable {
    var username : String
    var avatar : String
    var url : String
    var name : String
    var description : String
    var follower : Int
    var following : Int
    
    init(){
        self.username = "Not found"
        self.avatar = "https//avatars.githubusercontent.com/u/1650768?v=4"
        self.url = "Not found"
        self.name = "Not found"
        self.description = "Not found"
        self.follower = 0
        self.following = 0
    }
    
    enum CodingKeys : String, CodingKey {
        case username = "login"
        case avatar = "avatar_url"
        case url = "url"
        case name = "name"
        case description = "bio"
        case follower = "followers"
        case following = "following"
    }
    
    func encode(to encoder: Encoder) throws {
        // nothing to encode
    }
    
    init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try response.decodeIfPresent(String.self, forKey: .username) ?? "Not found"
        self.avatar = try response.decodeIfPresent(String.self, forKey: .avatar) ?? "https//avatars.githubusercontent.com/u/1650768?v=4"
        self.url = try response.decodeIfPresent(String.self, forKey: .url) ?? "Not found"
        self.name = try response.decodeIfPresent(String.self, forKey: .name) ?? "Not found"
        self.description = try response.decodeIfPresent(String.self, forKey: .description) ?? "Not found"
        self.follower = try response.decodeIfPresent(Int.self, forKey: .follower) ?? 0
        self.following = try response.decodeIfPresent(Int.self, forKey: .following) ?? 0
    }
}

