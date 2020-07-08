//
//  WebService.swift
//  Fictive Kin Project
//
//  Created by Dante Puglisi on 7/8/20.
//  Copyright © 2020 Dante Puglisi. All rights reserved.
//

import Foundation
import Alamofire

class WebService {
	func getPosts(onSuccess: @escaping ([Post]) -> (), onError: @escaping (Error) -> ()) {
		AF.request("https://jsonplaceholder.typicode.com/posts").responseData { response in
			switch response.result {
			case let .success(json):
				do {
					let posts = try JSONDecoder().decode([Post].self, from: json)
					onSuccess(posts)
				} catch let error {
					onError(error)
				}
			case let .failure(error):
				onError(error)
			}
		}
	}
}
