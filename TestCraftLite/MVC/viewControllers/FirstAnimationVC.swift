//
//  FirstAnimationVC.swift
//  AnimationDemo
//
//  Created by ADMS on 08/07/21.
//

import UIKit

class FirstAnimationVC: UIViewController {

    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var smallimageView:UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!

    var isCheckAnimation:Bool = true

    var images:[String] = ["First","second","third","71"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.transform = CGAffineTransform(rotationAngle: (.pi/7))
    }
    override func viewWillAppear(_ animated: Bool) {

        self.navigationController?.navigationBar.isHidden = true

        self.smallimageView.isHidden = true
        self.pageControl.numberOfPages = images.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 8/255, green: 167/255, blue: 227/255, alpha: 1)



        if isCheckAnimation == true {
            isCheckAnimation = false
//            self.smallimageView.isHidden = true
//            self.pageControl.numberOfPages = images.count
//            self.pageControl.currentPage = 0
//            self.pageControl.tintColor = UIColor.red
//            self.pageControl.pageIndicatorTintColor = UIColor.lightGray
//            self.pageControl.currentPageIndicatorTintColor = UIColor(red: 8/255, green: 167/255, blue: 227/255, alpha: 1)

            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseIn],
                           animations: {

//                            self.vwimage.backgroundColor  = .white
//                            self.vwimage.center.y -= self.vwimage.bounds.height


                            self.imageView.backgroundColor  = .white
                            self.imageView.center.y -= self.imageView.bounds.height

                            self.imageView.layer.cornerRadius = 6
                            self.imageView.layer.masksToBounds = true

                           }, completion: { _ in
                            UIView.transition(with: self.smallimageView, duration: 3.0, options: .transitionCrossDissolve, animations: { [self] in
                                self.smallimageView.isHidden = false
                                self.smallimageView.image = UIImage.init(named: "image_4")
                            }, completion: nil)
                           })
        }else{

            UIView.animate(withDuration: 0.0, delay: 0.0, options: [.curveEaseIn],
                           animations: {
//                            self.imageView.transform = CGAffineTransform(rotationAngle: (.pi/7))

                            self.imageView.layer.cornerRadius = 6
                            self.imageView.layer.masksToBounds = true
                           }, completion: { _ in
                            UIView.transition(with: self.smallimageView, duration: 3.0, options: .transitionCrossDissolve, animations: { [self] in
                                self.smallimageView.isHidden = false
                                self.smallimageView.image = UIImage.init(named: "image_4")
                            }, completion: nil)
                           })
        }



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
