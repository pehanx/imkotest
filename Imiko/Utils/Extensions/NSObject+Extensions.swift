//
//  NSObject+Extensions.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 01.06.2022.
//

import Foundation

extension NSObject {
    static var stringFromClass: String { return NSStringFromClass(self) }
    var stringFromClass: String { return NSStringFromClass(type(of: self)) }
    static var className: String { return self.stringFromClass.components(separatedBy: ".").last! }
    var className: String { return self.stringFromClass.components(separatedBy: ".").last! }
}
