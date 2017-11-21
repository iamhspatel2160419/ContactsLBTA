//
//  ExpandableNames.swift
//  ContactsLBTA
//
//  Created by Brian Voong on 11/17/17.
//  Copyright © 2017 Lets Build That App. All rights reserved.
//

import Foundation

struct ExpandableNames {
    var isExpanded: Bool
    var names: [Contact]
}

struct Contact {
    let name: String
    var hasFavorited: Bool
}
