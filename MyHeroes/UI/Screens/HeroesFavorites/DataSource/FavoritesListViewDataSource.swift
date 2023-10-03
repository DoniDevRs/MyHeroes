//
//  FavoritesListViewDataSource.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import UIKit

public protocol FavoritesListViewDataSourceDelegate: AnyObject {
    func didSelectItem(with entity: HeroEntity)
    func showRemoveError(with dialog: DialogEntity)
}

open class FavoritesListViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    public var favorites: [HeroEntity]
    public weak var delegate: FavoritesListViewDataSourceDelegate?
    
    public init(favorites: [HeroEntity], delegate: FavoritesListViewDataSourceDelegate? = nil) {
        self.favorites = favorites
        self.delegate = delegate
    }
    
    public func update(with favorites: [HeroEntity]) {
        self.favorites = favorites
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.Constants.reuseID) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.updateView(with: favorite)
        
        let image = UIImage(systemName: "chevron.right")
        let accessory  = UIImageView(frame:CGRect(x:0, y:0, width:(image?.size.width)!, height:(image?.size.height)!))
        accessory.image = image
        accessory.tintColor = UIColor.gray
        cell.accessoryView = accessory
    
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        (delegate)?.didSelectItem(with: favorites[indexPath.row])
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            let alert = DialogEntity(title: "Unable to remove",
                                    message: error.rawValue,
                                    buttonTitle: "Ok")
            self.delegate?.showRemoveError(with: alert)
        }
    }
}
