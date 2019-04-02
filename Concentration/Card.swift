//
//  Card.swift
//  Concentration
//
//  Created by Cormac Hayden on 3/22/19.
//  Copyright © 2019 Cormac Hayden. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    
    var hashValue: Int { return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
