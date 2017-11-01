//
//  ViewController.swift
//  CompileTimeImprovementDemo
//
//  Created by Martina Stremenova on 10/10/2017.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    
    // [TIME]: 2 ms
    // + 15 ms to compile function _makeTitleLabel()
    // Try to use functions instead of closures to decrease compile time
    lazy var optimizedTitleLabel:UILabel = self._makeTitleLabel()
    
    // [TIME]: 45 ms
    lazy var titleLabel = { () -> UILabel in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(label)
        
        let safeAreaLayoutGuides = self.view.safeAreaLayoutGuide
        let layoutMarginGuide = self.view.layoutMarginsGuide
        
        label.topAnchor.constraint(equalTo: safeAreaLayoutGuides.topAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: layoutMarginGuide.trailingAnchor, constant: -20).isActive = true
        label.leadingAnchor.constraint(equalTo: layoutMarginGuide.leadingAnchor, constant: 20).isActive = true
        
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .darkGray
        
        return label
    }()
    
    lazy var subtitleLabel = self._makeSubtitleLabel()
    
    // MARK: Private Properties
    private let viewModel = ViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStrings()
    }
    
    // MARK: UI - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    
    private func setStrings() {
        
        self.titleLabel.text = self.viewModel.title
        
        // Concatenating strings - - - - -
        
        // [TIME]: 46 ms
        self.subtitleLabel.text = self.viewModel.subtitle + "\n" + self.viewModel.description
        
        // [TIME]: 106 ms
        self.subtitleLabel.text = self.viewModel.subtitle.appending("\n").appending(self.viewModel.description)
        
        // [TIME]: 145 ms
        self.subtitleLabel.text = "\(self.viewModel.subtitle)\n\(self.viewModel.description)"
        
        
        // Concatenating strings with conversion - - - - -
        
        // [TIME]: 170 ms
        self.subtitleLabel.text = self.viewModel.subtitle + "\n" + self.viewModel.description + "\n" 
            + String(17) + "\n" + String(19) + "\n" + String(21)
        
        // [TIME]: 228 ms
        self.subtitleLabel.text = self.viewModel.subtitle.appending("\n").appending(self.viewModel.description).appending("\n")
            .appending(String(17)).appending("\n").appending(String(19)).appending("\n").appending(String(21))
        
        // [TIME]: 158 ms
        self.subtitleLabel.text = "\(self.viewModel.subtitle)\n\(self.viewModel.description)\n\(String(17))\n\(String(19))\n\(String(21333))"
    }
}

// MARK: - UI Components
extension ViewController {
    
    // [TIME]: 15ms
    private func _makeTitleLabel() -> UILabel {
        
        let label = self._makeAndAddLabel(to: self.view)
        
        let safeAreaLayoutGuides = self.view.safeAreaLayoutGuide
        let layoutMarginGuide = self.view.layoutMarginsGuide
        
        label.topAnchor.constraint(equalTo: safeAreaLayoutGuides.topAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: layoutMarginGuide.trailingAnchor, constant: -20).isActive = true
        label.leadingAnchor.constraint(equalTo: layoutMarginGuide.leadingAnchor, constant: 20).isActive = true
        
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .darkGray
        
        return label
    }
    
    // [TIME]: 16ms
    private func _makeSubtitleLabel() -> UILabel {
        
        let label = self._makeAndAddLabel(to: self.view)
        
        let layoutMarginGuide = self.view.layoutMarginsGuide
        
        label.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: layoutMarginGuide.trailingAnchor, constant: -20).isActive = true
        label.leadingAnchor.constraint(equalTo: layoutMarginGuide.leadingAnchor, constant: 20).isActive = true
        
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .darkGray
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }
    
    private func _makeAndAddLabel(to: UIView) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)

        return label
    }

}


