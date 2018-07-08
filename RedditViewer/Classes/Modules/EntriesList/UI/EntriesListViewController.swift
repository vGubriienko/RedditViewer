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
    
    // MARK: - Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// TableView DS mock
extension EntriesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as! EntryCell
        
        let model = EntryCell.Model(ID: "",
                                    author: "John Dou",
                                    postDate: Date(),
                                    description: "Test description",
                                    commentsCount: 154,
                                    thumb: nil)
        
        cell.model = model
        
        return cell
    }
    
}

// TabeView Delegate mock
extension EntriesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.showPicture(for: "")
    }
    
}
