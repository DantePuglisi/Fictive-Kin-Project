//
//  Post.swift
//  Fictive Kin Project
//
//  Created by Dante Puglisi on 7/8/20.
//  Copyright © 2020 Dante Puglisi. All rights reserved.
//

import Foundation

struct Post: Codable {
	var userId: Int
	var title: String
	var body: String
}
