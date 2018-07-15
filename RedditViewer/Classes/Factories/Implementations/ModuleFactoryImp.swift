//
//  ModuleFactoryImp.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import UIKit



final class ModuleFactoryImp: TopEntriesModuleFactory, PicturePreviewModuleFactory {
    
    func makeTopEntriesModule(with appRestorationState: AppStateProtocol?) -> (moduleIO: EntriesListModuleIO, presentable: Presentable) {
        let viewModel = EntriesListViewModelImp(with: appRestorationState, entriesProvider: RedditDataProvider())
        let topEntriesVC = EntriesListViewController.controllerFromStoryboard(.main, viewModel: viewModel)
        return (viewModel, topEntriesVC)
    }
    
    func makePicturePreviewModule(with appRestorationState: AppStateProtocol?, picture: Picture) -> (moduleIO: PicturePreviewModuleIO, presentable: Presentable) {
        let viewModel = PicturePreviewViewModelImp(picture: picture, pictureProvider: RedditDataProvider(), pictureSaver: DeviceLibraryPictureSaver())
        let previewVC = PicturePreviewViewController.controllerFromStoryboard(.main, viewModel: viewModel)
        return (viewModel, previewVC)
    }
    
}
