//
//  PostViewController.swift
//  Fictive Kin Project
//
//  Created by Dante Puglisi on 7/8/20.
//  Copyright © 2020 Dante Puglisi. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var bodyLabel: UILabel!
	
	var post: Post?
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		setupView()
	}
	
	fileprivate func setupView() {
		titleLabel.text = post?.title ?? "Error"
		bodyLabel.text = post?.body ?? "Error"
	}
}
