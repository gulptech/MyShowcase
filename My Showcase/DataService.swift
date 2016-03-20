//
//  DataService.swift
//  My Showcase
//
//  Created by Joseph Pilon on 3/19/16.
//  Copyright © 2016 Gulp Technologies. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = "https://gshowcase.firebaseio.com"

class DataService {
    static let ds = DataService()
    
    private let _REF_BASE = Firebase(url: "\(URL_BASE)")
    private let _REF_POSTS = Firebase(url: "\(URL_BASE)/posts")
    private let _REF_USERS = Firebase(url: "\(URL_BASE)/users")
    
    var REF_BASE: Firebase {
        return _REF_BASE
    }
    
    var REF_POSTS: Firebase {
        return _REF_POSTS
    }
    
    var REF_USERS: Firebase {
        return _REF_USERS
    }
    
    func createFirebaseUser(uid: String, user: Dictionary<String,String>) {
        REF_USERS.childByAppendingPath(uid).setValue(user)
        
    }
    
}