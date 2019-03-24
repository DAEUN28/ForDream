//
//  StarStoragePVC.swift
//  ForDream
//
//  Created by baby1234 on 24/03/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class StarStorageDetailPVC: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pageVC : UIPageViewController!
    
    var currentDream: Dream!
    var currentIndex: Int!
    var starStorageDreams: [Dream]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageVC = (storyboard!.instantiateViewController(withIdentifier: "StarStorageDetailPageVC") as! UIPageViewController)
        
        pageVC.dataSource = self
        pageVC.delegate = self
        
        let startVC = viewControllerAtIndex()
        let viewControllers = NSArray(object: startVC)
        
        pageVC.setViewControllers(viewControllers as? [UIViewController], direction: .forward, animated: true, completion: nil)
        pageVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        self.addChild(self.pageVC)
        self.view.addSubview(self.pageVC.view)
    }
    
    func viewControllerAtIndex () -> StarStorageDetailVC{
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StarStorageDetailVC") as! StarStorageDetailVC
        
        vc.pageIndex = currentIndex
        vc.pageCount = starStorageDreams.count
        vc.pageDream = starStorageDreams[currentIndex]
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if currentIndex == 0 || currentIndex == NSNotFound {
            return nil
        }
        
        currentIndex -= 1
        
        return self.viewControllerAtIndex()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if currentIndex == NSNotFound || currentIndex == starStorageDreams.count - 1{
            return nil
        }
        
        currentIndex += 1
        
        return viewControllerAtIndex()
    }
}
