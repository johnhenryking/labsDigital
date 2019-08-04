//
//  MenuTableViewController.swift
//  Plated
//
//  Created by User on 8/3/19.
//  Copyright © 2019 Jonathan King. All rights reserved.
//

import UIKit
import RealmSwift

class MenuTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareNavigationBar()
        self.fetchMenus()
        
    }
    
    var menus: [Menu] = []
    var countBasedOnRecipes = 0
    var reuseIdentifier = "menuCell"
    
    @IBOutlet weak var recentsButton: UIBarButtonItem!
    
    func fetchMenus() {
        
        guard let url = URL(string: Constants.menusURL) else { return }
        
        NetworkManager.shared.fetchDocumentsWithAlamofire(url: url) { (menus: [Menu]?, error) in
            if let error = error {
                self.presentAlert(title: Constants.errorTitle, message: error.localizedDescription)
            } else if let menus = menus {
                self.menus = menus
                for menu in menus {
                    self.fetchRecipes(with: menu)
                }
            }
        }
    }
    
    func fetchRecipes(with menu: Menu) {
        
        guard let id = menu.id else { return }
        guard let url = URL(string: Constants.recipesURL(with: id)) else { return }
        
        NetworkManager.shared.fetchDocumentsWithAlamofire(url: url) { (recipes: [Recipe]?, error) in
            if let error = error {
                self.presentAlert(title: Constants.errorTitle, message: error.localizedDescription)
            } else if let recipes = recipes {
                self.menus[id - 1].recipes = recipes
                self.countBasedOnRecipes += 1
                self.insertRecipes(in: self.tableView, at: id)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recentsSegue" {
            let recents = segue.destination as? RecentsTableViewController
            recents?.navigationItem.title = Constants.recents
            recents?.requestType = .recents
        }
    }

}

extension MenuTableViewController {
    
    // MARK: - TableView Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return countBasedOnRecipes
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menus[section].title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipe = self.menus[section].recipes else { return 0 }
        return recipe.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MenuTableViewCell
        cell.recipe = self.menus[indexPath.section].recipes?[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func insertRecipes(in tableView: UITableView, at menuId: Int) {
        let index = IndexSet(integer: menuId-1)
        DispatchQueue.main.async {
            tableView.insertSections(index, with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let recents = UIStoryboard(name: "Recents", bundle: nil).instantiateInitialViewController() as? RecentsTableViewController
        recents?.navigationItem.setTitleView()
        let recipe = self.menus[indexPath.section].recipes![indexPath.item]
        recents?.recipes = [recipe]
        recipe.writeToRealm()
        navigationController?.show(recents!, sender: nil)
    }
    
}
