//
//  TitlesViewController.swift
//  Fictive Kin Project
//
//  Created by Dante Puglisi on 7/8/20.
//  Copyright © 2020 Dante Puglisi. All rights reserved.
//

import UIKit

class TitlesViewController: UIViewController {
	
	@IBOutlet weak var backgroundView: UIView!
	@IBOutlet weak var collectionView: UICollectionView!
	
	var webService: WebService! = nil
	
	var posts = [Post]() {
		didSet {
			collectionView.reloadData()
		}
	}
	
	var loadingView = LoadingView()
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupCollectionView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		addBackgroundGradient()
		
		addLoadingAnimation()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
			self.fetchPosts()
		}
	}
	
	// MARK: - UI
	fileprivate func setupCollectionView() {
		let size = NSCollectionLayoutSize(
			widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
			heightDimension: NSCollectionLayoutDimension.estimated(44)
		)
		let item = NSCollectionLayoutItem(layoutSize: size)
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
		
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
		section.interGroupSpacing = 10
		
		let layout = UICollectionViewCompositionalLayout(section: section)
		collectionView.collectionViewLayout = layout
		collectionView.register(UINib(nibName: "PostCell", bundle: nil), forCellWithReuseIdentifier: "PostCell")
	}
	
	fileprivate func addLoadingAnimation() {
		view.addSubview(loadingView)
		
		loadingView.translatesAutoresizingMaskIntoConstraints = false
		let horizontalConstraint = NSLayoutConstraint(item: loadingView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
		let verticalConstraint = NSLayoutConstraint(item: loadingView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
		let widthConstraint = NSLayoutConstraint(item: loadingView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 120)
		let heightConstraint = NSLayoutConstraint(item: loadingView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 120)
		view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
	}
	
	fileprivate func addBackgroundGradient() {
		let layer = CAGradientLayer()
		layer.frame = backgroundView.bounds
		layer.colors = [
			UIColor.GradientColors.topLeft.cgColor,
			UIColor.GradientColors.bottomRight.cgColor
		]
		layer.startPoint = CGPoint(x: 0, y: 0)
		layer.endPoint = CGPoint(x: 1, y: 1)
		backgroundView.layer.addSublayer(layer)
	}
	
	fileprivate func pushPostViewController(withPost post: Post) {
		let newVC = PostViewController(nibName: "PostViewController", bundle: nil)
		newVC.post = post
		present(newVC, animated: true, completion: nil)
	}
	
	// MARK: - Fetch
	fileprivate func fetchPosts() {
		webService.get(endpoint: .posts, onSuccess: { [weak self] (posts: [Post]) in
			self?.posts = posts
			self?.loadingView.stopAnimating()
			self?.loadingView.removeFromSuperview()
		}) { [weak self] error in
			self?.showErrorAlert(message: "An error happened: \(error.localizedDescription)")
		}
	}
	
	// MARK: - View Transition Handling
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		coordinator.animate(alongsideTransition: { context in
			self.collectionView.collectionViewLayout.invalidateLayout()
			self.addBackgroundGradient()
		}, completion: nil)
	}
	
	// MARK: - Show Error Message
	fileprivate func showErrorAlert(message: String) {
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] _ in
			self?.fetchPosts()
		}))
		present(alert, animated: true, completion: nil)
	}
}

// MARK: - CollectionView DataSource
extension TitlesViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return posts.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
		cell.setupCell(withPost: posts[indexPath.item])
		return cell
	}
}

// MARK: - CollectionView Delegate
extension TitlesViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		pushPostViewController(withPost: posts[indexPath.item])
	}
}
