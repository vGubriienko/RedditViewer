//
//  BaseCoordinator.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


class BaseCoordinator: Coordinator {
    
    private (set) var childCoordinators: [Coordinator] = []

    func start(with restorationState: AppStateProtocol?) {
        fatalError("Must be implemented in subclasses")
    }

    func saveState() {
        fatalError("Must be implemented in subclasses")
    }
    
    func addDependency(_ coordinator: Coordinator) {
        for element in childCoordinators where element === coordinator {
            return
        }
        
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            return
        }
    }
    
}
