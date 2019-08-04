//
//  Extension.swift
//  Plated
//
//  Created by User on 8/3/19.
//  Copyright © 2019 Jonathan King. All rights reserved.
//

import UIKit

/************** For UI Purposes Only *****************/

extension MenuTableViewController {
    var platedFont: UIFont {
        let size = 16.dynamic
        return UIFont(name: Constants.platedFontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    func prepareNavigationBar() {
        
        let image = #imageLiteral(resourceName: "plated-80")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
        
        recentsButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: Constants.platedFontName, size: 16)!,
            NSAttributedString.Key.foregroundColor: UIColor.black],
                                             for: .normal)
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = menus[section].title
        label.font = self.platedFont
        label.textAlignment = .center
        return label
    }
}


extension UIImageView {
    
    func setImage(with imageUrl: String) {
        
        guard let url = URL(string: imageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //check for the error, then construct the image using data
            if let error = error {
                print(Constants.fetchImageFailureTitle, error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                UIView.transition(with: self,
                                  duration: 0.2,
                                  options: .transitionCrossDissolve,
                                  animations: { self.image = image },
                                  completion: nil)
            }
            
            }.resume()
    }
    
}

extension UINavigationItem {
    
    func setTitleView() {
        
        let image = #imageLiteral(resourceName: "plated-80")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.titleView = imageView
        
    }
}


extension UIViewController {
    
    func presentAlert(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message ?? Constants.somethingWentWrong, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
}

extension Int {
    var dynamic: CGFloat {
        guard let height = UIApplication.shared.keyWindow?.frame.height else { return CGFloat(self) }
        return height * (CGFloat(self)/height)
    }
}

extension Data {
    var asString : String {
        return String(data: self, encoding: .utf8)!
    }
}






