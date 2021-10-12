//
//  SecondAnimationVC.swift
//  AnimationDemo
//
//  Created by ADMS on 08/07/21.
//

import UIKit

class SecondAnimationVC: UIViewController {


    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var smallimageView1:UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!

    var images:[String] = ["First","second","third","71"]

//    var vwController = ThirdAnimationVC()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.smallimageView1.isHidden = true
        print("second page x", self.imageView.frame.origin.x)
        print("second page y", self.imageView.frame.origin.x)


        self.pageControl.numberOfPages = images.count
        self.pageControl.currentPage = 1
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 8/255, green: 167/255, blue: 227/255, alpha: 1)

        self.imageView.transform = CGAffineTransform(rotationAngle: -(.pi/7))

        UIView.animate(withDuration: 0.0, delay: 0.0, options: [.curveEaseIn],
                       animations: {
                        self.imageView.layer.cornerRadius = 6
                        self.imageView.layer.masksToBounds = true
                       }, completion: { _ in
                        UIView.transition(with: self.smallimageView1, duration: 3.0, options: .transitionCrossDissolve, animations: { [self] in

                            self.smallimageView1.isHidden = false

                            self.smallimageView1.image = UIImage.init(named: "image_5")


                        }, completion: nil)
                       })
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
