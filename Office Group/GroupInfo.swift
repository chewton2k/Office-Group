//
//  GroupInfo.swift
//  Office Group
//
//  Created by Charlton Shih on 8/12/24.
//

import Foundation
import SwiftData

@Model
class GroupInfo: Identifiable{
    let id = UUID()
    var name: String
    var email: String
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}
