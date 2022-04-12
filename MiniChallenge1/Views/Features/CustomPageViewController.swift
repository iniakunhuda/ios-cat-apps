//
//  CustomPageViewController.swift
//  MiniChallenge1
//
//  Created by Miftahul Huda on 12/04/22.
//

import UIKit

class CustomPageViewController: UIPageViewController {
    var listOfPageView = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        listOfPageView = [
            FeaturesInfoDetailController.getInstance(index: 0),
            FeaturesInfoDetailController.getInstance(index: 1),
            FeaturesInfoDetailController.getInstance(index: 2),
            FeaturesInfoDetailController.getInstance(index: 3)
        ]

        setViewControllers([listOfPageView[0]], direction: .forward, animated: true, completion: nil)
    }
}

extension CustomPageViewController: UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
      let indexOfCurrentPageViewController = listOfPageView.firstIndex(of: viewController)!
    if indexOfCurrentPageViewController == 0 {
     return nil // To show there is no previous page
    } else {
      // Previous UIViewController instance
      return listOfPageView[indexOfCurrentPageViewController - 1]
    }
  }

  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
      let indexOfCurrentPageViewController = listOfPageView.firstIndex(of: viewController)!
    if indexOfCurrentPageViewController == listOfPageView.count - 1 {
      return nil // To show there is no next page
    } else {
      // Next UIViewController instance
      return listOfPageView[indexOfCurrentPageViewController + 1]
    }
  }
}
