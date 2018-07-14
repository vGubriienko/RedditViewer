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
    
    let refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        bindViewModel()
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        entriesTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = .white
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
            
            let model = viewModel.entries.value[indexPath.row]
            
            configureCell(cell, with: model)
            
            return cell
        case .LoadingCell:
            return tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath)
        }
    }
    
    private func configureCell(_ cell: EntryCell, with entry: RedditEntry) {
        let cellModel = EntryCell.Model(ID: entry.ID,
                                        author: entry.author,
                                        postDate: entry.postDate,
                                        description: entry.title,
                                        commentsCount: entry.commentsCount,
                                        thumbURL: entry.thumbURL)
        
        cell.model = cellModel
        
        cell.onTapThumb = { [weak self] model in
            guard let entryID = model?.ID else { return }
            
            self?.viewModel.showPicture(for: entryID)
        }
    }
    
}

extension EntriesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if Sections(rawValue: indexPath.section)! == .LoadingCell {
            if let loadingCell = cell as? LoadingCell, viewModel.isLoadingEntries.value == false {
                loadingCell.loadingIndicator.startAnimating()
            }
            
            viewModel.loadMoreEntries()
        }
    }
    
}
