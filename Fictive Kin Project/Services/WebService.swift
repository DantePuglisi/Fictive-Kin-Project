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
	
	enum Endpoint: String {
		case posts = "https://jsonplaceholder.typicode.com/posts"
	}
	
	func get<T>(endpoint: Endpoint, onSuccess: @escaping (T) -> (), onError: @escaping (Error) -> ()) where T: Decodable {
		AF.request(endpoint.rawValue).responseData { response in
			switch response.result {
			case let .success(json):
				do {
					let array = try JSONDecoder().decode(T.self, from: json)
					onSuccess(array)
				} catch let error {
					onError(error)
				}
			case let .failure(error):
				onError(error)
			}
		}
	}
}
