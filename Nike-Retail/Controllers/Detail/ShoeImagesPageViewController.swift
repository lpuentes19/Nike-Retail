//
//  ShoeImagesPageViewController.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 1/17/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class ShoeImagesPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    // MARK: - Properties
    var images: [UIImage]? = Product.fetchProducts().first?.images
    
    lazy var controllers: [UIViewController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var controllers = [UIViewController]()
        
        if let images = self.images {
            for image in images {
                let shoeImageVC = storyboard.instantiateViewController(withIdentifier: "shoeImagesViewController")
                controllers.append(shoeImageVC)
            }
        }
        return controllers
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        self.turnToPage(index: 0)
    }
    
    func turnToPage(index: Int) {
        let controller = controllers[index]
        var direction = UIPageViewControllerNavigationDirection.forward
        
        if let currentVC = viewControllers?.first {
            let currentIndex = controllers.index(of: currentVC)!
            
            if currentIndex > index {
                direction = .reverse
            }
        }
        self.configureDisplaying(viewController: controller)
        setViewControllers([controller], direction: direction, animated: true, completion: nil)
    }
    
    func configureDisplaying(viewController: UIViewController) {
        
        for (index, vc) in controllers.enumerated() {
            if viewController === vc {
                if let shoeImageVC = viewController as? ShoeImageViewController {
                    shoeImageVC.image = self.images?[index]
                }
            }
        }
    }
    
    // MARK: - UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let index = controllers.index(of: viewController) {
            if index > 0 {
                return controllers[index - 1]
            }
        }
        return controllers.last
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let index = controllers.index(of: viewController) {
            if index < controllers.count - 1 {
                return controllers[index + 1]
            }
        }
        return controllers.first
    }
    
    // MARK: - UIPageViewControllerDelegate
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        configureDisplaying(viewController: pendingViewControllers.first as! ShoeImageViewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed {
            configureDisplaying(viewController: previousViewControllers.first as! ShoeImageViewController)
        }
    }
}
