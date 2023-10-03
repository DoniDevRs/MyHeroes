//
//  MHButton.swift
//  MyHeroes
//
//  Created by Doni on 25/07/23.
//

import UIKit

public class MHButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroudnColor: UIColor, foregroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        set(backgroudnColor: backgroudnColor, foregroundColor: foregroundColor, title: title)
    }
    
    private func configure() {
        configuration = .filled()
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    public func set(backgroudnColor: UIColor, foregroundColor: UIColor, title: String) {
        DispatchQueue.main.async {
            self.configuration?.baseBackgroundColor = backgroudnColor
            self.configuration?.baseForegroundColor = foregroundColor
            self.configuration?.title = title
            self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        }
    }
}
