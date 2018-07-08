//
//  MVVMViewController.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import UIKit


protocol MVVMViewController: class {
    
    associatedtype ViewModel
    
    var viewModel: ViewModel { get set }
    
}


extension MVVMViewController where Self: UIViewController {
    
    static func controllerInStoryboard(_ storyboard: UIStoryboard, viewModel: ViewModel) -> Self {
        let vc = controllerInStoryboard(storyboard, identifier: className)
        vc.viewModel = viewModel
        return vc
    }
    
    static func controllerFromStoryboard(_ storyboard: Storyboards, viewModel: ViewModel) -> Self {
        let vc =  controllerInStoryboard(UIStoryboard(name: storyboard.rawValue, bundle: nil), identifier: className)
        vc.viewModel = viewModel
        return vc
    }
    
}
