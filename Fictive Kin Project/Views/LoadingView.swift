//
//  LoadingView.swift
//  Fictive Kin Project
//
//  Created by Dante Puglisi on 7/8/20.
//  Copyright © 2020 Dante Puglisi. All rights reserved.
//

import UIKit

class LoadingView: UIView {

	var handView: UIView? = nil
	let handViewWidth = 4.0
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		createHandView()
		startAnimating()
	}
	
	fileprivate func createHandView() {
		/// We add a `CAGradientLayer` to `handView` so only half of it is visible and it when rotated 360 around it's center it looks like a clock hand
		guard handView == nil else { return }
		handView = UIView(frame: CGRect(x: (frame.size.width / 2) - CGFloat(handViewWidth / 2), y: 8, width: CGFloat(handViewWidth), height: frame.size.height - 16))
		configureCircles()
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = handView!.bounds
		gradientLayer.colors = [UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor]
		gradientLayer.locations = [NSNumber(value: 0.0), NSNumber(value: 0.5), NSNumber(value: 0.5), NSNumber(value: 1.0)]
		handView!.layer.addSublayer(gradientLayer)
		addSubview(handView!)
	}
	
	fileprivate func startAnimating() {
		if handView?.layer.animation(forKey: "rotationKey") == nil {
			let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
			
			rotationAnimation.fromValue = 0.0
			rotationAnimation.toValue = Float.pi * 2.0
			rotationAnimation.duration = 4
			rotationAnimation.repeatCount = Float.infinity
			
			handView?.layer.add(rotationAnimation, forKey: "rotationKey")
		}
	}
	
	func stopAnimating() {
		if handView?.layer.animation(forKey: "rotationKey") != nil {
			handView?.layer.removeAnimation(forKey: "rotationKey")
		}
	}
	
	fileprivate func configureCircles() {
		for i in 0..<4 {
			if let rect = rectForCircleInPosition(pos: i) {
				let newView = UIView(frame: rect)
				newView.layer.cornerRadius = 2
				newView.backgroundColor = UIColor.blue
				addSubview(newView)
			}
		}
	}
	
	fileprivate func rectForCircleInPosition(pos: Int) -> CGRect? {
		switch pos {
		case 0:
			return CGRect(x: (frame.size.width / 2) - CGFloat(2.0), y: 0, width: 4, height: 4)
		case 1:
			return CGRect(x: frame.size.width - 4, y: (frame.size.height / 2) - CGFloat(2), width: 4, height: 4)
		case 2:
			return CGRect(x: (frame.size.width / 2) - CGFloat(2.0), y: frame.size.height - 4, width: 4, height: 4)
		case 3:
			return CGRect(x: 0, y: (frame.size.height / 2) - CGFloat(2), width: 4, height: 4)
		default:
			return nil
		}
	}

}
