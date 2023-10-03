//
//  UITableView+Ext.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import UIKit

extension UITableView {
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
