//
//  Box.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 9.12.22.
//

class Box<T> {
    
    typealias Listener = (T) -> ()
   
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
    
}
