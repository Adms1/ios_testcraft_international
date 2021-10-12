//
//  FourthAnimationVC.swift
//  AnimationDemo
//
//  Created by ADMS on 08/07/21.
//

import UIKit

class FourthAnimationVC: UIViewController ,ISRewardedVideoDelegate{

    var images:[String] = ["First","second","third","71"]
    @IBOutlet weak var pageControl: UIPageControl!

    @IBOutlet weak var imageView:UIImageView!

    @IBOutlet weak var smallimageView4:UIImageView!

    @IBOutlet weak var btnExpolreCraftTest:UIButton!

//    @IBOutlet weak var vwimage:UIView!


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnClickExploreCraftTest(){
//        IronSource.showRewardedVideo(with: self)


        let appdelegate = UIApplication.shared.delegate as! AppDelegate

        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController

        let frontNavigationController = UINavigationController(rootViewController: rootVC)
        appdelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appdelegate.window?.rootViewController = frontNavigationController
        appdelegate.window?.makeKeyAndVisible()

    }

    func setupIronSourceSdk() {
       // UserDefaults.standard.set(true, forKey: "isTestCraftt")
        IronSource.shouldTrackReachability(true)
        IronSource.setRewardedVideoDelegate(self)
        IronSource.initWithAppKey(kAPPKEY, adUnits:[IS_REWARDED_VIDEO])
        ISIntegrationHelper.validateIntegration()

       // IronSource.showRewardedVideo(with: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       // setupIronSourceSdk()
        self.navigationController?.navigationBar.isHidden = true
        btnExpolreCraftTest.backgroundColor = UIColor(red: 8/255, green: 167/255, blue: 227/255, alpha: 1)

        btnExpolreCraftTest.layer.cornerRadius = 10
        btnExpolreCraftTest.layer.masksToBounds = true
        
        self.pageControl.numberOfPages = images.count
        self.pageControl.currentPage = 3
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 8/255, green: 167/255, blue: 227/255, alpha: 1)


        self.smallimageView4.isHidden = false
        self.smallimageView4.alpha = 1
//        self.vwimage.alpha = 1
        self.imageView.isHidden = true
        self.imageView.alpha = 0



        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseIn],
                       animations: {

                        self.imageView.isHidden = true
                        self.smallimageView4.alpha = 0
//                        self.vwimage.alpha = 0

                       }, completion: { _ in


                        UIView.transition(with: self.imageView, duration: 3.0, options: .transitionCrossDissolve, animations: { [self] in

                            self.imageView.alpha = 1
                            self.imageView.isHidden = false
                          //  self.imageView.contentMode = .scaleAspectFit

                            self.imageView.layer.cornerRadius = 6
                            self.imageView.layer.masksToBounds = true


                            self.imageView.image = UIImage.init(named: self.images[3])


                        }, completion: nil)


                    })
    }

}
extension FourthAnimationVC{
    func rewardedVideoHasChangedAvailability(_ available: Bool) {
    }

    func didReceiveReward(forPlacement placementInfo: ISPlacementInfo!) {
    }

    func rewardedVideoDidFailToShowWithError(_ error: Error!) {
    }

    func rewardedVideoDidOpen() {
    }

    func rewardedVideoDidClose() {

        let appdelegate = UIApplication.shared.delegate as! AppDelegate

        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController

        let frontNavigationController = UINavigationController(rootViewController: rootVC)
        appdelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appdelegate.window?.rootViewController = frontNavigationController
        appdelegate.window?.makeKeyAndVisible()
    }

    func rewardedVideoDidStart() {
    }

    func rewardedVideoDidEnd() {
    }

    func didClickRewardedVideo(_ placementInfo: ISPlacementInfo!) {
    }

}
