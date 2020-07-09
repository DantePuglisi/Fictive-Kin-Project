//
//  WebServiceTests.swift
//  Fictive Kin Project Tests
//
//  Created by Dante Puglisi on 7/9/20.
//  Copyright © 2020 Dante Puglisi. All rights reserved.
//

import XCTest

@testable import Fictive_Kin_Project

class WebServiceTests: XCTestCase {
	
	var webService: WebService!
	
	override func setUp() {
		super.setUp()
		
		guard let path = Bundle.main.url(forResource: "DataMock", withExtension: "json") else { return }
		
		webService = WebService(urlString: path.relativeString)
	}
	
	func testRequest() {
		let reqExpectation = expectation(description: "PostsRequest")
		webService.getPosts(onSuccess: { posts in
			reqExpectation.fulfill()
			XCTAssert(posts.count > 0, "We received 0 posts")
			XCTAssert(posts.count == 100, "We didn't receive 100 posts, we received \(posts.count)")
			/// On `DataMock.json` a post can be removed at it will fail here
		}) { error in
			XCTAssert(true, "Error when fetching posts: \(error.localizedDescription)")
		}
		waitForExpectations(timeout: 4.0, handler: nil)
	}

}
