//
//  ContactTableViewController.swift
//  UISearchControllerDemo
//
//  Created by Chhaileng Peng on 7/14/18.
//  Copyright © 2018 Chhaileng Peng. All rights reserved.
//

import UIKit

class ContactTableViewController: UITableViewController {

    let names = ["Dara", "Daro", "Dary", "Sok", "Sao", "Channat", "Sokha",
                 "Dara", "Daro", "Dary", "Sok", "Sao", "Channat", "Sokha",
                 "Dara", "Daro", "Dary", "Sok", "Sao", "Channat", "Sokha"]
    
    var filteredData = [String]()
    
    var searchController: UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        filteredData = names
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchController = UISearchController(searchResultsController: nil)
        searchController?.dimsBackgroundDuringPresentation = false
        searchController?.hidesNavigationBarDuringPresentation = true
        tableView.tableHeaderView = searchController?.searchBar
        searchController?.searchBar.placeholder = "Search name"
        searchController?.searchBar.setValue("បោះបង់", forKey:"_cancelButtonText")
        searchController?.searchResultsUpdater = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)

        cell.textLabel?.text = filteredData[indexPath.row]

        return cell
    }

}

extension ContactTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        if let notFoundLabel = self.view.viewWithTag(999) {
            notFoundLabel.removeFromSuperview()
        }
        
        if let searchText = searchController.searchBar.text {
            if searchText != "" {
                filteredData = names.filter({ (name) -> Bool in
                    return name.lowercased().contains(searchText.lowercased())
                })
            } else {
                filteredData = names
            }
        } else {
            filteredData = names
        }
        
        if filteredData.count == 0 {
            let label = UILabel(frame: CGRect(x: 0, y: 200, width: self.view.frame.width, height: 30))
            label.text = "Not found"
            label.tag = 999
            label.textAlignment = .center
            tableView.addSubview(label)
        }
        
        tableView.reloadData()
    }
    
    
}














