//
//  task.swift
//  TaskTracker
//
//  Created by Giovanni Trivellato on 12/09/26.
//

import Foundation
import SwiftData

@Model
class Task {
    var id = UUID()
    var title: String
    var iscompleted: Bool = false
    
    init(title: String, inCOmpleted: Bool = false){
        self.title = title
        self.iscompleted = inCOmpleted
    }
}
