//
//  Cheklist.swift
//  Checklist
//
//  Created by didAR on 1/7/20.
//  Copyright © 2020 Mehrshad. All rights reserved.
//

import UIKit

class Cheklist: NSObject {
    var name = ""
    var items = [ChecklistItem]()
    init(name :String) {
        self.name = name
        super.init()
    }
}
