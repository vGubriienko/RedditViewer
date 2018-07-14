//
//  AppStateProtocol.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/14/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


protocol AppStateProtocol: class, Codable  {
    func setState<State: RestorationState>(_ state: State?)
    func getState<State: RestorationState>() -> State?
}
