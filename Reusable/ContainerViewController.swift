//
//  ContainerViewController.swift
//  Reusable
//
//  Created by Ross Kimes on 1/28/18.
//  Copyright © 2018 rosskimes.net. All rights reserved.
//


open class ContainerViewController: UIViewController {
	
	public var contentViewController: UIViewController? {
		didSet {
			remove(contentViewController: oldValue)
			add(contentViewController: contentViewController)
		}
	}
}

private extension ContainerViewController {
	
	func add(contentViewController: UIViewController?) {
		
		guard let contentViewController = contentViewController else { return }
		
		view.addSubview(contentViewController.view)
		addChildViewController(contentViewController)
		contentViewController.didMove(toParentViewController: self)
		
		contentViewController.view.translatesAutoresizingMaskIntoConstraints = true
		contentViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		contentViewController.view.frame = view.bounds
	}
	
	func remove(contentViewController: UIViewController?) {
		guard let contentViewController = contentViewController else { return }
		
		contentViewController.view.removeFromSuperview()
		contentViewController.removeFromParentViewController()
		contentViewController.didMove(toParentViewController: nil)
	}
}
