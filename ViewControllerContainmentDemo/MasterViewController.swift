//
//  ViewController.swift
//  ViewControllerContainmentDemo
//
//  Created by Saikumar Kankipati on 3/9/19.
//  Copyright © 2019 Saikumar Kankipati. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

	@IBOutlet var segmentedControl: UISegmentedControl!
	
	lazy var summaryChildVC: SummaryViewController = {
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		let vc = storyboard.instantiateViewController(withIdentifier: "SummaryViewController") as! SummaryViewController
		
		self.addViewControllerAsChildViewController(childViewController: vc)
		
		return vc
	}()
	
	lazy var sessionsChildVC: SessionsViewController = {
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		let vc = storyboard.instantiateViewController(withIdentifier: "SessionsViewController") as! SessionsViewController
		
		self.addViewControllerAsChildViewController(childViewController: vc)
		
		return vc
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupView()
	}

	private func setupView() {
		setupSegmentedControl()
		updateView()
	}

	func setupSegmentedControl() {
		segmentedControl.removeAllSegments()
		segmentedControl.insertSegment(withTitle: "Summary", at: 0, animated: false)
		segmentedControl.insertSegment(withTitle: "Sessions", at: 1, animated: false)
		
		segmentedControl.addTarget(self, action: #selector(selectionDidChange(sender:)), for: .valueChanged)
		segmentedControl.selectedSegmentIndex = 0
	}
	
	func updateView() {
		summaryChildVC.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
		sessionsChildVC.view.isHidden = (segmentedControl.selectedSegmentIndex == 0)
	}
	
	// MARK: - Actions
	@objc func selectionDidChange(sender: UISegmentedControl) {
		updateView()
	}
	
	// MARK: - helper methods for view containment apis
	func addViewControllerAsChildViewController(childViewController: UIViewController) {
		addChild(childViewController)
		self.view.addSubview(childViewController.view)
		childViewController.view.frame = self.view.bounds
		childViewController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
		childViewController.didMove(toParent: self)
	}
	
	func removeChildViewController(childViewController: UIViewController) {
		childViewController.willMove(toParent: nil)
		childViewController.view.removeFromSuperview()
		childViewController.removeFromParent()
	}
}

