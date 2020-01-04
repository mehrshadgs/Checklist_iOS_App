//
//  Checklistitem.swift
//  Checklist
//
//  Created by didAR on 1/1/20.
//  Copyright © 2020 Mehrshad. All rights reserved.
//

import Foundation
import UIKit
class ChecklistItem: NSObject, Codable{
    var text = ""
    var checked = false
    func toggleCheked(){
        checked = !checked
    }
}
