//
//  Observable.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/9/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


class Observable<Value> {
    
    var observe: (_ oldValue: Value, _ value: Value) -> () = { _, _ in }
    
    var value: Value {
        didSet { observe(oldValue, value) }
    }
    
    init(_ value: Value) {
        self.value = value
    }
    
}
