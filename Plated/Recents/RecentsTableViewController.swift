//
//  TableViewController.swift
//  Plated
//
//  Created by User on 8/3/19.
//  Copyright © 2019 Jonathan King. All rights reserved.
//

import UIKit

class RecentsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchRecents()
    }
    
    var recipes = [Recipe]()
    var reuseIdentifier = "Cell"
    var requestType: RequestType = .indiviual
    
    enum RequestType {
        case recents, indiviual
    }
    
    fileprivate func fetchRecents() {
        if requestType == .recents {
            let results = NetworkManager.shared.realm.objects(Recipe.self)
            for result in results {
                let recipe: Recipe = result
                recipes.insert(recipe, at: 0)
                self.tableView.insertRows(at: [[0,0]], with: .automatic)
            }
        }
    }

}

extension RecentsTableViewController {
    
    // MARK: - TableView Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RecentsTableViewCell
        cell.recipe = self.recipes[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height/2.5
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.recipes[indexPath.row].deleteFromRealm()
            self.recipes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        if indexPath.row < recipes.count {
            return [delete]
        }
        return []
    }
    
    
}


