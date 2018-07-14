//
//  AppStateImp.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/14/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


class AppState: AppStateProtocol {
    
    var applicationCoordinatorState: ApplicationCoordinatorRestorationState?
    var picturePreviewState: PicturePreviewRestorationState?
    var entriesListState: EntriesListRestorationState?
    
    func setState<State>(_ state: State?) where State: RestorationState {
        switch State.restorationKey {
        case EntriesListRestorationState.restorationKey:            entriesListState = state as? EntriesListRestorationState
        case PicturePreviewRestorationState.restorationKey:         picturePreviewState = state as? PicturePreviewRestorationState
        case ApplicationCoordinatorRestorationState.restorationKey: applicationCoordinatorState = state as? ApplicationCoordinatorRestorationState
        default:
            fatalError("State with name `\(State.restorationKey)` not found in application state")
        }
    }
    
    func getState<State: RestorationState>() -> State? {
        switch State.restorationKey {
        case EntriesListRestorationState.restorationKey:            return entriesListState as? State
        case PicturePreviewRestorationState.restorationKey:         return picturePreviewState as? State
        case ApplicationCoordinatorRestorationState.restorationKey: return applicationCoordinatorState as? State
        default:
            fatalError("State with name `\(State.restorationKey)` not found in application state")
        }
    }
    
}
