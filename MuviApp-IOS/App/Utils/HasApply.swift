//
//  Apply.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import Foundation

protocol HasApply { }

extension NSObject: HasApply { }

extension HasApply {
    func apply(closure:(Self) -> ()) -> Self {
        closure(self)
        return self
    }
}
