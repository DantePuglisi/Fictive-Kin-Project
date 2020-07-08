//
//  PostCell.swift
//  Fictive Kin Project
//
//  Created by Dante Puglisi on 7/8/20.
//  Copyright © 2020 Dante Puglisi. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell {

	@IBOutlet weak var viewBackground: UIView!
	@IBOutlet weak var titleLabel: UILabel!
	
	func setupCell(withPost post: Post) {
		titleLabel.text = post.title.prefix(1).uppercased() + post.title.dropFirst()
		configureBackground()
	}
	
	fileprivate func configureBackground() {
		viewBackground.backgroundColor = UIColor.CustomColor.cellBackground
		viewBackground.layer.cornerRadius = 16.0
	}

}
