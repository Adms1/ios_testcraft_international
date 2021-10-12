//
//  BaseTabBarViewController.swift
//  MMTabBarAnimation
//
//  Created by Millman YANG on 2016/12/17.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import MMTabBarAnimation


//let kAPPKEY = "100f13569"


class BaseTabBarViewController: MMTabBarAnimateController,ISImpressionDataDelegate,ISBannerDelegate{

    var strtemo_Selected = ""

    var checkAdsVideoShow = ""

    var isFacingError:String = ""

    var isFirstTime:String = ""




//
   // var bannerView: ISBannerView! = nil
//        ,ISImpressionDataDelegate,ISBannerDelegate
    @IBOutlet weak var bannerView:ISBannerView!

    func impressionDataDidSucceed(_ impressionData: ISImpressionData!) {

    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        AppUtility.lockOrientation(.portraitUpsideDown)

        // .iconExpand  type dont set select Image or you will not animation
//        super.setAnimate(index: 0, animate: .iconExpand(image: #imageLiteral(resourceName: "Home__1")), duration: 0.2)
//        super.setAnimate(index: 1, animate: .icon(type: .rotation(type: .left)))
//        super.setAnimate(index: 2, animate: .icon(type: .scale(rate: 1.2)))
//        super.setAnimate(index: 3, animate: .label(type: .shake))
//        super.setAnimate(index: 4, animate: .icon(type: .jump))
        
//        super.setBadgeAnimate(index: 0, animate: .jump)
//        super.setBadgeAnimate(index: 1, animate: .rotation(type: .left))
//        super.setBadgeAnimate(index: 2, animate: .scale(rate: 1.2))
//        super.setBadgeAnimate(index: 3, animate: .shake)
        
        self.navigationController?.isNavigationBarHidden = true
        print("selectedIndex_______________________________: ",self.selectedIndex,strtemo_Selected)
//        if strtemo_Selected == "0"{self.selectedIndex = 0}else{self.selectedIndex = 0}
        if UserDefaults.standard.object(forKey: "isLogin") != nil{
            let result = UserDefaults.standard.value(forKey: "isLogin")! as! NSString
            if(result == "1")
            {
                self.selectedIndex = 1
            }else{
                self.selectedIndex = 1
            }


        }else{
            self.selectedIndex = 1
        }


        setupIronSourceSdk()




//        isFacingError = UserDefaults.standard.string(forKey: "isError") ?? ""
//        isFirstTime = UserDefaults.standard.string(forKey: "isAdsInintalization") ?? ""
//        if "facingError"  == isFacingError
//        {
//           if "isFirstTime" == UserDefaults.standard.string(forKey: "isAdsInintalization") ?? ""
//           {
////                UserDefaults.standard.setValue("FirstTime", forKey: "isAdsInintalization")
//                setupIronSourceSdk()
//           }
//            UserDefaults.standard.setValue("", forKey: "isAdsInintalization")
//            newTabAdsView.removeFromSuperview()
//            newTabAdsView.frame = CGRect(x: 0, y: view.frame.size.height - 50, width: view.frame.size.width, height: 50)
//            view.addSubview(newTabAdsView)
//            newTabAdsView.backgroundColor = .white
//            self.tabBar.frame = CGRect(x: 0, y: 50, width: view.frame.size.width, height: 49)
//        //    newTabAdsView.bringSubviewToFront(self.tabBar)
//
//
//            var customeView = ISBannerView(frame: CGRect(x: 0, y:0 , width: view.frame.size.width, height: 50))
//                print("customeView frame",customeView.frame)
//            bannerView.frame = CGRect(x: 0, y:0 , width: view.frame.size.width, height: 50)
//                customeView = bannerView
//            newTabAdsView.bringSubviewToFront(customeView)

//        }else{
//            UserDefaults.standard.setValue("isFirstTime", forKey: "isAdsInintalization")
//        }



//        if checkAdsVideoShow == "videoShow"
//        {
//            let newTabAdsView = UIView()
//                newTabAdsView.frame = CGRect(x: 0, y: view.frame.size.height - 99, width: view.frame.size.width, height: 99)
//                self.view.addSubview(newTabAdsView)
//
//                self.tabBar.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50)
//            newTabAdsView.addSubview(self.tabBar)
//
//
//            let customeView = ISBannerView(frame: CGRect(x: 0, y:50 , width: view.frame.size.width, height: 50))
////                print("customeView frame",customeView.frame)
////            bannerView.frame = CGRect(x: 0, y:50 , width: view.frame.size.width, height: 50)
////                customeView = bannerView
//
//            newTabAdsView.addSubview(customeView)
//
//        }else{
//
//        }




//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let secondViewController = storyboard.instantiateViewController(withIdentifier: "SelectExamVC") as? SelectExamVC {
////        if let secondViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SubCategory1VC") as? SubCategory1VC
////        {
//            let navgitaionController1 = UINavigationController(rootViewController: secondViewController)
//            navgitaionController1.title = "Second"
//            navgitaionController1.tabBarItem.image = UIImage.init(named: "Home__1.png")
////            var array = self.viewControllers
//            self.viewControllers = [navgitaionController1]
////            self.viewControllers = array
//        }
    }

    func setupIronSourceSdk() {


//        ISIntegrationHelper.validateIntegration()
//
//
//
//        IronSource.setRewardedVideoDelegate(self)
//        IronSource.initWithAppKey(kAPPKEY, adUnits:[IS_REWARDED_VIDEO])



//        ISIntegrationHelper.validateIntegration()
//        IronSource.setRewardedVideoDelegate(self)
//        IronSource.add(self)
//        IronSource.initWithAppKey(kAPPKEY, adUnits:[IS_REWARDED_VIDEO])


        isFacingError = UserDefaults.standard.string(forKey: "isError") ?? ""
        isFirstTime = UserDefaults.standard.string(forKey: "isAdsInintalization") ?? ""
        if "facingError"  == isFacingError
        {
            IronSource.shouldTrackReachability(true)
    //        IronSource.setRewardedVideoDelegate(self)
            IronSource.setBannerDelegate(self)
            IronSource.initWithAppKey(kAPPKEY, adUnits:[IS_BANNER])
            ISIntegrationHelper.validateIntegration()

            let BNSize: ISBannerSize = ISBannerSize(description: "BANNER",width:Int(view.frame.size.width) ,height:50)
           IronSource.loadBanner(with: self, size: BNSize)
        }else{
            if "FirstTime"  == isFirstTime
            {
                            newTabAdsView.removeFromSuperview()
                            newTabAdsView.frame = CGRect(x: 0, y: view.frame.size.height - 50, width: view.frame.size.width, height: 50)
                            view.addSubview(newTabAdsView)
                            newTabAdsView.backgroundColor = .white
                            self.tabBar.frame = CGRect(x: 0, y: 50, width: view.frame.size.width, height: 49)
                        //    newTabAdsView.bringSubviewToFront(self.tabBar)


                            var customeView = ISBannerView(frame: CGRect(x: 0, y:0 , width: view.frame.size.width, height: 50))
                                print("customeView frame",customeView.frame)
                            bannerView.frame = CGRect(x: 0, y:0 , width: view.frame.size.width, height: 50)
                                customeView = bannerView
                            newTabAdsView.bringSubviewToFront(customeView)

            }else{
                IronSource.shouldTrackReachability(true)
        //        IronSource.setRewardedVideoDelegate(self)
                IronSource.setBannerDelegate(self)
                IronSource.initWithAppKey(kAPPKEY, adUnits:[IS_BANNER])
                ISIntegrationHelper.validateIntegration()

                let BNSize: ISBannerSize = ISBannerSize(description: "BANNER",width:Int(view.frame.size.width) ,height:50)
               IronSource.loadBanner(with: self, size: BNSize)

            }

        }






    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillLayoutSubviews() {

        let font = UIFont.systemFont(ofSize: 12)
        let text_attribute = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): font]

        tabBar.items![0].setTitleTextAttributes(text_attribute, for: .normal)
//        tabBar.items![1].setTitleTextAttributes(text_attribute, for: .normal)
        tabBar.items![1].setTitleTextAttributes(text_attribute, for: .normal)
        tabBar.items![2].setTitleTextAttributes(text_attribute, for: .normal)
        
//        tabBar.tintColor = UIColor.red
//        tabBar.barTintColor = UIColor.clear
        tabBar.items![0].image = UIImage(named: "home-icon")
//        tabBar.items![1].image = UIImage(named: "market-place-icon")
        tabBar.items![1].image = UIImage(named: "Testcraftunsel")
        tabBar.items![2].image = UIImage(named: "menu")
        

//        tabBarItem.image = tabBarImage.withRenderingMode(.alwaysOriginal)
        if let items = self.tabBar.items {
            for item in items {
                if let image = item.image {
                    item.image = image.withRenderingMode( .alwaysOriginal )
//                    item.selectedImage = UIImage(named: "(Imagename)-a")?.withRenderingMode(.alwaysOriginal)
//                    item.selectedImage = image.withRenderingMode( .alwaysOriginal )

                }
            }
        }
        tabBar.items![0].selectedImage = UIImage(named: "home-fill-icon")?.withRenderingMode(.alwaysOriginal)
//        tabBar.items![1].selectedImage = UIImage(named: "market-place-select")?.withRenderingMode(.alwaysOriginal)
        tabBar.items![1].selectedImage = UIImage(named: "Testcraftsel")?.withRenderingMode(.alwaysOriginal)
        tabBar.items![2].selectedImage = UIImage(named: "menu-selected")?.withRenderingMode(.alwaysOriginal)


//        5183 7501 8038 8397  450 2019/10/31
//                       7472  537

//        tabBar.items![0].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -2, right: 0)
//        tabBar.items![1].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -2, right: 0)
//        tabBar.items![2].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -2, right: 0)
//        tabBar.items![3].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -2, right: 0)
//
//        tabBar.items![0].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
//        tabBar.items![1].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
//        tabBar.items![2].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
//        tabBar.items![3].imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)

        var tabFrame = self.tabBar.frame
        let isFirstTime:String = UserDefaults.standard.string(forKey: "isError") ?? ""
        if isFirstTime  == "facingError"
        {
            self.tabBar.frame = CGRect(x: 0, y: view.frame.size.height - 60, width: view.frame.size.width, height: 49)

        }else{
            self.tabBar.frame = CGRect(x: 0, y: view.frame.size.height - 99, width: view.frame.size.width, height: 49)

        }
        



        if #available(iOS 11.0, *) {
            let bottomInset = self.view.safeAreaInsets.bottom
            if bottomInset > 0 && tabFrame.size.height < 61 && (tabFrame.height + bottomInset < 100) {
//                //                size.height += bottomInset + 10
                tabBar.items![0].titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: 3.0)
//                tabBar.items![1].titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: 3.0)
                tabBar.items![1].titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: 3.0)
                tabBar.items![2].titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: 3.0)

//                tabFrame.size.height = 60
//                tabFrame.origin.y = self.view.frame.size.height - tabFrame.size.height

//                tabFrame.size.height += bottomInset + 35

//                let isFirstTime:String = UserDefaults.standard.string(forKey: "isError") ?? ""
//                if isFirstTime  == "facingError"
//                {
//                    tabFrame.origin.y = self.view.frame.size.height-49
//                }else{
//                    tabFrame.origin.y = self.view.frame.size.height - 99
//                    //tabFrame.origin.y = self.view.frame.size.height - tabFrame.size.height// + 20)
//
//                }


            }
            else
            {
                tabBar.items![0].titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -3.0)
//                tabBar.items![1].titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -3.0)
                tabBar.items![1].titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -3.0)
                tabBar.items![2].titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -3.0)

              //  tabFrame.size.height = 60
              //  tabFrame.origin.y = self.view.frame.size.height - tabFrame.size.height

                let isFirstTime:String = UserDefaults.standard.string(forKey: "isError") ?? ""
                if isFirstTime  == "facingError"
                {
                    tabFrame.origin.y = self.view.frame.size.height-49

                }else{
                    tabFrame.origin.y = self.view.frame.size.height-99
                }


//                self.tabBar.frame = tabFrame
            }
        }
        self.tabBar.backgroundColor = UIColor(rgb: 0xF8FCFF)
        
        //                self.tabBar.frame = tabFrame
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
class TabBar: UITabBar {
    private var cachedSafeAreaInsets = UIEdgeInsets.zero
    
    @available(iOS 11.0, *)
    override var safeAreaInsets: UIEdgeInsets {
        let insets = super.safeAreaInsets
        
        if insets.bottom < bounds.height {
            cachedSafeAreaInsets = insets
        }
        
        return cachedSafeAreaInsets
    }
}

//class SafeAreaFixTabBar: UITabBar {
//
//    var oldSafeAreaInsets = UIEdgeInsets.zero
//
//    @available(iOS 11.0, *)
//    override func safeAreaInsetsDidChange() {
//        super.safeAreaInsetsDidChange()
//
//        if oldSafeAreaInsets != safeAreaInsets {
//            oldSafeAreaInsets = safeAreaInsets
//
//            invalidateIntrinsicContentSize()
//            superview?.setNeedsLayout()
//            superview?.layoutSubviews()
//        }
//    }
//
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        var size = super.sizeThatFits(size)
////        if #available(iOS 11.0, *) {
////            let bottomInset = safeAreaInsets.bottom
////            if bottomInset > 0 && size.height < 50 && (size.height + bottomInset < 90) {
////                size.height += bottomInset + 10
////            }
////        }
//        if #available(iOS 11.0, *) {
//            let bottomInset = safeAreaInsets.bottom
//            if bottomInset > 0 && size.height < 50 && (size.height + bottomInset < 90) {
//                //                size.height += bottomInset + 10
//                size.height = 60 + bottomInset
////                tabFrame.origin.y = self.view.frame.size.height - tabFrame.size.height
//
//            }
//            else
//            {
//                size.height = 60
////                tabFrame.origin.y = self.view.frame.size.height - tabFrame.size.height
//
//            }
//        }
//        else
//        {
//            size.height = 60
//            //                tabFrame.origin.y = self.view.frame.size.height - tabFrame.size.height
//
//        }
//        return size
//    }
//
//    override var frame: CGRect {
//        get {
//            return super.frame
//        }
//        set {
//            var tmp = newValue
//            if let superview = superview, tmp.maxY !=
//                superview.frame.height {
//                tmp.origin.y = superview.frame.height - tmp.height
//                //        tabFrame.origin.y = self.view.frame.size.height - 60
//                //        self.tabBar.backgroundColor = UIColor(rgb: 0xF8FCFF)
//                //        self.tabBar.frame = tabFrame
//
//            }
//
//            super.frame = tmp
//        }
//    }
//}
extension BaseTabBarViewController
{
    //MARK: ISBannerDelegate Functions
   func bannerDidLoad(_ bannerView: ISBannerView!)
   {
//    self.bannerView = bannerView
//    self.bannerView.backgroundColor = .red
//    self.bannerView.frame = CGRect(x: 0, y:50 , width: view.frame.size.width, height: 50)
    //        customeView = bannerView
    UserDefaults.standard.setValue("FirstTime", forKey: "isAdsInintalization")

    UserDefaults.standard.setValue("", forKey: "isError")
    newTabAdsView.isHidden = false
//    let newTabAdsView = UIView()
    newTabAdsView.frame = CGRect(x: 0, y: view.frame.size.height - 50, width: view.frame.size.width, height: 50)
    view.addSubview(newTabAdsView)
    newTabAdsView.backgroundColor = .white
    self.tabBar.frame = CGRect(x: 0, y: 49-self.view.safeAreaInsets.bottom, width: view.frame.size.width, height: 49)
//    newTabAdsView.bringSubviewToFront(self.tabBar)


    var customeView = ISBannerView(frame: CGRect(x: 0, y:0, width: view.frame.size.width, height: 50))
        print("customeView frame",customeView.frame)
    bannerView.frame = CGRect(x: 0, y:0 , width: view.frame.size.width, height: 50)
        customeView = bannerView
    newTabAdsView.addSubview(customeView)
   }



    func logFunctionName(string: String = #function) {
        print("IronSource Swift Demo App: "+string)
    }

   func bannerDidShow() {
       logFunctionName()
   }

   func bannerDidFailToLoadWithError(_ error: Error!) {
       logFunctionName(string: #function+String(describing: Error.self))
       UserDefaults.standard.setValue("facingError", forKey: "isError")
    self.tabBar.frame = CGRect(x: 0, y: view.frame.size.height - 60, width: view.frame.size.width, height: 49)
    newTabAdsView.frame = CGRect(x: 0, y: view.frame.size.height - 50, width: view.frame.size.width, height: 0)
    newTabAdsView.isHidden = true

   }

   func didClickBanner() {
       logFunctionName()
   }

   func bannerWillPresentScreen() {
       logFunctionName()
   }

   func bannerDidDismissScreen() {
       logFunctionName()
   }

   func bannerWillLeaveApplication() {
       logFunctionName()
   }

   //MARK: ISImpressionData Functions
//   func impressionDataDidSucceed(_ impressionData: ISImpressionData!) {
//       logFunctionName(string: #function+String(describing: impressionData))
//
//   }

}
