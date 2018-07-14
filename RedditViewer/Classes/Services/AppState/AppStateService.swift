//
//  AppStateService.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/14/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


final class AppStateService<State: Codable> {
    
    private (set) var state: State
    private let stateFileURL: URL
    
    init(stateFileURL: URL, statePlaceholder: State) {
        self.stateFileURL = stateFileURL
        state = statePlaceholder
    }
    
    func restoreState(_ completion: @escaping (_ result: State) -> Void) {
        var newState: State? = self.state
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: self.stateFileURL) {
                newState = try? PropertyListDecoder().decode(State.self, from: data)
            }
            
            DispatchQueue.main.async {
                self.state = newState ?? self.state
                
                completion(self.state)
            }
        }
    }
    
    func saveState(synchronously: Bool) {
        let saveBlock = {
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .binary
            if let data = try? encoder.encode(self.state) {
                try? data.write(to: self.stateFileURL)
            }
        }
        
        if synchronously {
            saveBlock()
        } else {
            DispatchQueue.global().async {
                saveBlock()
            }
        }
    }
    
}
