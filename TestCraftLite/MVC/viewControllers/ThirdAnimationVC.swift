//
//  ThirdAnimationVC.swift
//  AnimationDemo
//
//  Created by ADMS on 08/07/21.
//

import UIKit

class ThirdAnimationVC: UIViewController {


    @IBOutlet weak var imageView:UIImageView!

    @IBOutlet weak var smallimageView2:UIImageView!

    @IBOutlet weak var smallimageView3:UIImageView!

//    @IBOutlet weak var vwimage:UIView!

    var images:[String] = ["First","second","third","71"]
    @IBOutlet weak var pageControl: UIPageControl!


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        print("third page x", self.smallimageView3.frame.origin.x)
        print("third page y", self.smallimageView3.frame.origin.x)

        self.smallimageView3.transform = CGAffineTransform(rotationAngle: -(.pi/7))

        self.pageControl.numberOfPages = images.count
        self.pageControl.currentPage = 2
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 8/255, green: 167/255, blue: 227/255, alpha: 1)

       // self.smallimageView3.isHidden = true
//        self.vwimage.isHidden = true
        self.smallimageView2.isHidden = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {


            self.smallimageView3.isHidden = false
            self.smallimageView3.alpha = 1
            self.imageView.isHidden = false
//            self.vwimage.alpha = 1
//            self.vwimage.isHidden = false

            UIView.animate(withDuration: 0.0, delay: 0.0, options: [.curveEaseIn],
                           animations: {
                            self.imageView.layer.cornerRadius = 6
                            self.imageView.layer.masksToBounds = true
                           }, completion: { _ in


                            UIView.transition(with: self.smallimageView3, duration: 1.0, options: .transitionCrossDissolve, animations: { [self] in

//                                self.vwimage.alpha = 0
                                self.smallimageView3.alpha = 0

                            }, completion: nil)
                            UIView.transition(with: self.smallimageView2, duration: 3.0, options: .transitionCrossDissolve, animations: { [ self] in

                                self.smallimageView2.isHidden = false
                                self.smallimageView2.image = UIImage.init(named: "image_6")

                            }, completion: nil)

                           })
//        }

    }
    @IBAction func btnClickSkip(){
        let appdelegate = UIApplication.shared.delegate as! AppDelegate

        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController

        let frontNavigationController = UINavigationController(rootViewController: rootVC)
        appdelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appdelegate.window?.rootViewController = frontNavigationController
        appdelegate.window?.makeKeyAndVisible()

    }

}
