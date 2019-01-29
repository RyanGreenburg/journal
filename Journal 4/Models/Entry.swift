//
//  Entry.swift
//  Journal 4
//
//  Created by RYAN GREENBURG on 1/26/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import Foundation

class Entry: Codable {
    
    var title: String
    var body: String
    var timestamp: Date
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
        self.timestamp = Date()
    }
}

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title && lhs.body == rhs.body && lhs.timestamp == rhs.timestamp
    }
}
