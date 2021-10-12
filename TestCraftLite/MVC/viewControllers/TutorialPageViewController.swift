////
////  TutorialPageViewController.swift
////  UIPageViewController Post
////
////  Created by Jeffrey Burt on 12/11/15.
////  Copyright © 2015 Atomic Object. All rights reserved.
////
//
//import UIKit
//
//class TutorialPageViewController: UIPageViewController {
//
//    weak var tutorialDelegate: TutorialPageViewControllerDelegate?
//
//    private(set) lazy var orderedViewControllers: [UIViewController] = {
//        // The view controllers will be shown in this order
//        return [self.newColoredViewController("FirstAnimationVC"),
//            self.newColoredViewController("SecondAnimationVC")]
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        dataSource = self
//        delegate = self
//
//        if let initialViewController = orderedViewControllers.first {
//            scrollToViewController(viewController: initialViewController)
//        }
//
//        tutorialDelegate?.tutorialPageViewController(tutorialPageViewController: self, didUpdatePageCount: orderedViewControllers.count)
//    }
//
//    /**
//     Scrolls to the next view controller.
//     */
//    func scrollToNextViewController() {
//        if let visibleViewController = viewControllers?.first,
//            let nextViewController = pageViewController(self, viewControllerAfter: visibleViewController) {
//                    scrollToViewController(viewController: nextViewController)
//        }
//    }
//
//    /**
//     Scrolls to the view controller at the given index. Automatically calculates
//     the direction.
//
//     - parameter newIndex: the new index to scroll to
//     */
//    func scrollToViewController(index newIndex: Int) {
//        if let firstViewController = viewControllers?.first,
//            let currentIndex = orderedViewControllers.firstIndex(of: firstViewController) {
//            let direction: UIPageViewController.NavigationDirection = newIndex >= currentIndex ? .forward : .reverse
//                let nextViewController = orderedViewControllers[newIndex]
//                scrollToViewController(viewController: nextViewController, direction: direction)
//        }
//    }
//
//    func newColoredViewController(_ color: String) -> UIViewController {
//        return UIStoryboard(name: "Main", bundle: nil) .
//            instantiateViewController(withIdentifier: "\(color)")
//    }
//
//    /**
//     Scrolls to the given 'viewController' page.
//
//     - parameter viewController: the view controller to show.
//     */
//    private func scrollToViewController(viewController: UIViewController,
//                                        direction: UIPageViewController.NavigationDirection = .forward) {
//        setViewControllers([viewController],
//            direction: direction,
//            animated: true,
//            completion: { (finished) -> Void in
//                // Setting the view controller programmatically does not fire
//                // any delegate methods, so we have to manually notify the
//                // 'tutorialDelegate' of the new index.
//                self.notifyTutorialDelegateOfNewIndex()
//        })
//    }
//
//    /**
//     Notifies '_tutorialDelegate' that the current page index was updated.
//     */
//    private func notifyTutorialDelegateOfNewIndex() {
//        if let firstViewController = viewControllers?.first,
//            let index = orderedViewControllers.firstIndex(of: firstViewController) {
//                tutorialDelegate?.tutorialPageViewController(tutorialPageViewController: self, didUpdatePageIndex: index)
//        }
//    }
//
//}
//
//// MARK: UIPageViewControllerDataSource
//
//extension TutorialPageViewController: UIPageViewControllerDataSource {
//
//    func pageViewController(_ pageViewController: UIPageViewController,
//                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
//            guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
//                return nil
//            }
//
//            let previousIndex = viewControllerIndex - 1
//
//            // User is on the first view controller and swiped left to loop to
//            // the last view controller.
//            guard previousIndex >= 0 else {
//                return orderedViewControllers.last
//            }
//
//            guard orderedViewControllers.count > previousIndex else {
//                return nil
//            }
//
//            return orderedViewControllers[previousIndex]
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController,
//                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
//            guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
//                return nil
//            }
//
//            let nextIndex = viewControllerIndex + 1
//            let orderedViewControllersCount = orderedViewControllers.count
//
//            // User is on the last view controller and swiped right to loop to
//            // the first view controller.
//            guard orderedViewControllersCount != nextIndex else {
//                return orderedViewControllers.first
//            }
//
//            guard orderedViewControllersCount > nextIndex else {
//                return nil
//            }
//
//            return orderedViewControllers[nextIndex]
//    }
//
//}
//
//extension TutorialPageViewController: UIPageViewControllerDelegate {
//
//    func pageViewController(pageViewController: UIPageViewController,
//        didFinishAnimating finished: Bool,
//        previousViewControllers: [UIViewController],
//        transitionCompleted completed: Bool) {
//        notifyTutorialDelegateOfNewIndex()
//    }
//
//}
//
//protocol TutorialPageViewControllerDelegate: class {
//
//    /**
//     Called when the number of pages is updated.
//
//     - parameter tutorialPageViewController: the TutorialPageViewController instance
//     - parameter count: the total number of pages.
//     */
//    func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
//        didUpdatePageCount count: Int)
//
//    /**
//     Called when the current index is updated.
//
//     - parameter tutorialPageViewController: the TutorialPageViewController instance
//     - parameter index: the index of the currently visible page.
//     */
//    func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
//        didUpdatePageIndex index: Int)
//
//}
//

import UIKit

class TutorialPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pages = [UIViewController]()
    var index = 0
    var identifiers: NSArray = ["FirstAnimationVC", "SecondAnimationVC","ThirdAnimationVC","FourthAnimationVC"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.dataSource = self

        let p1: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "FirstAnimationVC")
        let p2: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "SecondAnimationVC")
        let p3: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "ThirdAnimationVC")
        let p4: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "FourthAnimationVC")

//        let p3: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "id3")

        // etc ...

        pages.append(p1)
        pages.append(p2)
        pages.append(p3)
        pages.append(p4)

        // etc ...

        setViewControllers([p1], direction: UIPageViewController.NavigationDirection.reverse, animated: false, completion: nil)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController)-> UIViewController? {

        var cur = pages.firstIndex(of: viewController)!

        // if you prefer to NOT scroll circularly, simply add here:
        // if cur == 0 { return nil }

//        var prev = (cur - 1) % pages.count
//        if prev < 0 {
//            prev = pages.count - 1
//        }
//
//        if prev == 0{
//           // return pages[cur]
//        }else{
//            return pages[prev]
//        }

        if cur > 0{
           // return pages[cur]

            cur = cur - 1
            return pages[cur]

        }else{

        }

        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController)-> UIViewController? {

        var cur = pages.firstIndex(of: viewController)!

        // if you prefer to NOT scroll circularly, simply add here:
        // if cur == (pages.count - 1) { return nil }

       // let nxt = abs((cur + 1) % pages.count)


        if cur == pages.count - 1{
           // return pages[cur]
        }else{
            cur = cur + 1
            return pages[cur]

            
        }

        return nil


    }

    func presentationIndex(for pageViewController: UIPageViewController)-> Int {
        return pages.count
    }
}
