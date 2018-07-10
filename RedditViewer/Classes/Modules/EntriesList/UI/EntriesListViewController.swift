//
//  EntriesListViewController.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import UIKit


class EntriesListViewController: UIViewController, MVVMViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var entriesTableView: UITableView!
    
    // MARK: - Public Properties
    
    var viewModel: EntriesListViewModel!
    
    // MARK: - Private Properties
    
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        bindViewModel()
        
        viewModel.refreshEntries()
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        entriesTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControlEvents.valueChanged)
        //refreshControl.tintColor = UIColor.red
        entriesTableView.addSubview(refreshControl)
    }
    
    @objc private func handleRefresh() {
        viewModel.refreshEntries()
    }
    
    private func bindViewModel() {
        viewModel.entries.observe = { [weak self] _, _ in
            self?.entriesTableView.reloadData()
        }
        
        viewModel.isLoadingEntries.observe = { [weak self] _, isLoading in
            if isLoading == false {
                self?.refreshControl.endRefreshing()
                self?.entriesTableView.visibleCells
                    .compactMap { $0 as? LoadingCell }
                    .first?
                    .loadingIndicator
                    .stopAnimating()
            }
        }
    }

}


extension EntriesListViewController: UITableViewDataSource {
    
    enum Sections: Int {
        case Entries     = 0
        case LoadingCell = 1
        
        static let count = 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Sections(rawValue: section)! {
        case .Entries:      return viewModel.entries.value.count
        case .LoadingCell:  return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Sections(rawValue: indexPath.section)! {
        case .Entries:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as! EntryCell
            
            // TODO: move out conversion
            // TODO: add thumb loading
            let model = viewModel.entries.value[indexPath.row]
            
            let cellModel = EntryCell.Model(ID: model.ID,
                                            author: model.author,
                                            postDate: model.postDate,
                                            description: model.title,
                                            commentsCount: model.commentsCount,
                                            thumb: nil)
            
            cell.model = cellModel
            
            return cell
        case .LoadingCell:
            return tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if Sections(rawValue: indexPath.section)! == .LoadingCell {
            if let loadingCell = cell as? LoadingCell, viewModel.isLoadingEntries.value == false {
                loadingCell.loadingIndicator.startAnimating()
            }
            
            viewModel.loadMoreEntries()
        }
    }
    
}

// TabeView Delegate mock
extension EntriesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if Sections(rawValue: indexPath.section)! == .Entries {
            guard let cell = tableView.cellForRow(at: indexPath) as? EntryCell, let entryID = cell.model?.ID else { return }

            viewModel.showPicture(for: entryID)
        }
    }
    
}
