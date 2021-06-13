//
//  Box.swift
//  Movie Flix App!
//
//  Created by Swapnil Gavali on 12/06/21.
//

import Foundation
class Box<T> {
    
    var listener : Listener?
    
    typealias Listener = ((T) -> Void)
    
    var value:T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value:T) {
        self.value = value
    }
    
    func bind(listener: Listener?)  {
        self.listener = listener
        listener?(value)
    }
}
