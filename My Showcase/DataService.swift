//
//  DataService.swift
//  My Showcase
//
//  Created by Joseph Pilon on 3/19/16.
//  Copyright © 2016 Gulp Technologies. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let ds = DataService()
    
    private let _REF_BASE = Firebase(url: "https://gshowcase.firebaseio.com/")
    
    var REF_BASE: Firebase {
        return _REF_BASE
    }
}