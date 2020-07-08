//
//  ViewController.swift
//  Fictive Kin Project
//
//  Created by Dante Puglisi on 7/8/20.
//  Copyright © 2020 Dante Puglisi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var webService: WebService! = nil
	
	var posts = [Post]()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		webService.getPosts(onSuccess: { [weak self] posts in
			self?.posts = posts
		}) { error in
			print("ERROR!: \(error.localizedDescription)")
		}
	}

}

