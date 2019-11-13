//
//  Task.swift
//  RxSwift_
//
//  Created by Yusuf ali cezik on 13.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation

enum Priority : Int{
    case high, medium, low
}

struct Task {
    let title:String
    let priority:Priority
}
