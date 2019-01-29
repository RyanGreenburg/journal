//
//  Journal.swift
//  Journal 4
//
//  Created by RYAN GREENBURG on 1/26/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import Foundation


class Journal: Codable {
    
    var name: String
    var entries: [Entry]
    
    init(name: String){
        self.name = name
        self.entries = []
    }
}

extension Journal: Equatable {
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        return lhs.name == rhs.name && lhs.entries == rhs.entries
    }
}
