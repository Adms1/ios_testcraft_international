import UIKit
import ObjectiveC.runtime
import Foundation

class AnimationVC: UIViewController,UIScrollViewDelegate,ISRewardedVideoDelegate,ISImpressionDataDelegate,ISOfferwallDelegate, ISInterstitialDelegate, ISBannerDelegate
{


    let imagelist = ["bb2","bb3","bb7","71"]
    var scrollView = UIScrollView()
    var bannerView: ISBannerView! = nil

    // var pageControl : UIPageControl = UIPageControl(frame:CGRect(x: 50, y: 300, width: 200, height: 50))

    var yPosition:CGFloat = 0
    var scrollViewContentSize:CGFloat = 0
    var photoCount:Int = 0


    @IBOutlet weak var pageControl:UIPageControl!


    @IBOutlet weak var smallimageView:UIImageView!

    @IBOutlet weak var smallimageView1:UIImageView!

    @IBOutlet weak var smallimageView2:UIImageView!

    @IBOutlet weak var smallimageView3:UIImageView!

    @IBOutlet weak var smallimageView4:UIImageView!

    @IBOutlet weak var imageView:UIImageView!


    @IBOutlet weak var btnSkip:UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

      //  self.btnSkip.isHidden = true
      //  self.btnSkip.isUserInteractionEnabled = true


      //  self.btnSkip.backgroundColor = .red

        self.navigationController?.navigationBar.isHidden = true


        self.smallimageView1.isHidden = true
        self.smallimageView.isHidden = true
        self.smallimageView2.isHidden = true
        self.smallimageView3.isHidden = true
        self.smallimageView4.isHidden = true

        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width , height: self.view.frame.height))

        //        configurePageControl()
      //  scrollView.showsHorizontalScrollIndicator = true
        scrollView.delegate = self
        pageControl.isEnabled = true
//        pageControl.isHighlighted = true
        self.scrollView.isPagingEnabled = true
        self.view.addSubview(scrollView)
        scrollView.addSubview(pageControl)
        scrollView.addSubview(btnSkip)

        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseIn],
                       animations: {


                        self.imageView.backgroundColor  = .white
                        self.imageView.center.y -= self.imageView.bounds.height



                        self.imageView.contentMode = .scaleToFill


                        self.imageView.layer.cornerRadius = 6
                        self.imageView.layer.masksToBounds = true


                        self.imageView.image = UIImage.init(named: self.imagelist[0])

                        //  cell.layoutIfNeeded()
                       }, completion: { _ in

                  //  DispatchQueue.main.asyncAfter(deadline: .now() + 3) {

                        UIView.transition(with: self.smallimageView, duration: 3.0, options: .transitionCrossDissolve, animations: { [self] in

                            self.smallimageView.isHidden = false
                            self.smallimageView.image = UIImage.init(named: "image_4")

//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                            self.btnSkip.isHidden = false
//                            }


                        }, completion: nil)

                  //  }

                })


        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * CGFloat(imagelist.count), height: self.scrollView.frame.size.height)

        self.pageControl.numberOfPages = imagelist.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 8/255, green: 167/255, blue: 227/255, alpha: 1)


        // pageControl.addTarget(self, action: Selector(("changePage:")), for: UIControl.Event.valueChanged)

        setupIronSourceSdk()

    }


    //MARK: Private Functions
    func setupIronSourceSdk() {


        IronSource.shouldTrackReachability(true)
        IronSource.setRewardedVideoDelegate(self)
//        IronSource.setOfferwallDelegate(self)
//        IronSource.setInterstitialDelegate(self)
//        IronSource.setBannerDelegate(self)
//        IronSource.add(self)

//        IronSource.initWithAppKey(kAPPKEY, adUnits:[IS_REWARDED_VIDEO])

        IronSource.initWithAppKey(kAPPKEY, adUnits:[IS_REWARDED_VIDEO])

       // IronSource.initWithAppKey(kAPPKEY)

        ISIntegrationHelper.validateIntegration()
    }

    func impressionDataDidSucceed(_ impressionData: ISImpressionData!) {
        logFunctionName(string: #function+String(describing: impressionData))
    }

    func logFunctionName(string: String = #function) {
        print("IronSource Swift Demo App: "+string)
    }

    //MARK: ISInterstitialDelegate Functions
    /**
     Called after an interstitial has been clicked.
     */
     func didClickInterstitial() {
        logFunctionName()
    }

    /**
     Called after an interstitial has attempted to show but failed.

     @param error The reason for the error
     */
     func interstitialDidFailToShowWithError(_ error: Error!) {
        logFunctionName(string: String(describing: error.self))
    }

    /**
     Called after an interstitial has been displayed on the screen.
     */
     func interstitialDidShow() {
        logFunctionName()
    }

    /**
     Called after an interstitial has been dismissed.
     */
     func interstitialDidClose() {
        logFunctionName()
    }

    /**
     Called after an interstitial has been opened.
     */
     func interstitialDidOpen() {
        logFunctionName()
    }

    /**
     Called after an interstitial has attempted to load but failed.

     @param error The reason for the error
     */
     func interstitialDidFailToLoadWithError(_ error: Error!) {
        logFunctionName(string: #function+String(describing: error.self))
    }

    /**
     Called after an interstitial has been loaded
     */
     func interstitialDidLoad() {
        logFunctionName()
    }


    //MARK: ISOfferwallDelegate Functions
    /**
     Called after the 'offerwallCredits' method has attempted to retrieve user's credits info but failed.

     @param error The reason for the error.
     */
     func didFailToReceiveOfferwallCreditsWithError(_ error: Error!) {
        logFunctionName(string: #function+String(describing: error.self))
    }

    /**
     @abstract Called each time the user completes an offer.
     @discussion creditInfo is a dictionary with the following key-value pairs:

     "credits" - (int) The number of credits the user has Earned since the last didReceiveOfferwallCredits event that returned YES. Note that the credits may represent multiple completions (see return parameter).

     "totalCredits" - (int) The total number of credits ever earned by the user.

     "totalCreditsFlag" - (BOOL) In some cases, we won’t be able to provide the exact amount of credits since the last event (specifically if the user clears the app’s data). In this case the ‘credits’ will be equal to the "totalCredits", and this flag will be YES.

     @param creditInfo Offerwall credit info.

     @return The publisher should return a BOOL stating if he handled this call (notified the user for example). if the return value is NO, the 'credits' value will be added to the next call.
     */
     func didReceiveOfferwallCredits(_ creditInfo: [AnyHashable : Any]!) -> Bool {
        logFunctionName()

        return true;
    }

    /**
     Called after the offerwall has been dismissed.
     */
     func offerwallDidClose() {
        logFunctionName()
    }

    /**
     Called after the offerwall has attempted to show but failed.

     @param error The reason for the error.
     */
     func offerwallDidFailToShowWithError(_ error: Error!) {
        logFunctionName(string: #function+String(describing: Error.self))
    }

    /**
     Called after the offerwall has been displayed on the screen.
     */
     func offerwallDidShow() {
        logFunctionName()
    }

    /**
     Called after the offerwall has changed its availability.

     @param available The new offerwall availability. YES if available and ready to be shown, NO otherwise.
     */
     func offerwallHasChangedAvailability(_ available: Bool) {
        logFunctionName(string: #function+String(describing: available.self))
    }


    //MARK: ISRewardedVideoDelegate Functions
    /**
     Called after a rewarded video has changed its availability.

     @param available The new rewarded video availability. YES if available and ready to be shown, NO otherwise.
     */
     func rewardedVideoHasChangedAvailability(_ available: Bool) {
     //   logFunctionName(string: #function+String(available.self))
       // IronSource.hasRewardedVideo()
    }

    /**
     Called after a rewarded video has finished playing.
     */
     func rewardedVideoDidEnd() {
      //  logFunctionName()
    }

    /**
     Called after a rewarded video has started playing.
     */
     func rewardedVideoDidStart() {
      //  logFunctionName()
    }

    /**
     Called after a rewarded video has been dismissed.
     */
//     func rewardedVideoDidClose() {
//        logFunctionName()
//    }

    /**
     Called after a rewarded video has been opened.
     */
     func rewardedVideoDidOpen() {
      //  logFunctionName()
    }

    /**
     Called after a rewarded video has attempted to show but failed.

     @param error The reason for the error
     */
     func rewardedVideoDidFailToShowWithError(_ error: Error!) {
      //  logFunctionName(string: #function+String(describing: error.self))
    }

    /**
     Called after a rewarded video has been viewed completely and the user is eligible for reward.

     @param placementInfo An object that contains the placement's reward name and amount.
     */
     func didReceiveReward(forPlacement placementInfo: ISPlacementInfo!) {
       // logFunctionName(string: #function+String(describing: placementInfo.self))
    }
    /**
     Called after a rewarded video has been clicked.

     @param placementInfo An object that contains the placement's reward name and amount.
     */
    func didClickRewardedVideo(_ placementInfo: ISPlacementInfo!) {
       // logFunctionName(string: #function+String(describing: placementInfo.self))
    }


     //MARK: ISBannerDelegate Functions
    func bannerDidLoad(_ bannerView: ISBannerView!) {
        self.bannerView=bannerView
        if #available(iOS 11.0, *) {
            bannerView.frame = CGRect(x: view.frame.size.width/2 - bannerView.frame.size.width/2, y: view.frame.size.height - bannerView.frame.size.height, width: bannerView.frame.size.width, height: bannerView.frame.size.height - self.view.safeAreaInsets.bottom * 2.5)
        } else {
                bannerView.frame = CGRect(x: view.frame.size.width/2 - bannerView.frame.size.width/2, y: view.frame.size.height - bannerView.frame.size.height, width: bannerView.frame.size.width, height: bannerView.frame.size.height  * 2.5)
        }



         view.addSubview(bannerView)

        logFunctionName()
    }

    func bannerDidShow() {
        logFunctionName()
    }

    func bannerDidFailToLoadWithError(_ error: Error!) {
        logFunctionName(string: #function+String(describing: Error.self))

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
//    func impressionDataDidSucceed(_ impressionData: ISImpressionData!) {
//        logFunctionName(string: #function+String(describing: impressionData))
//
//    }


//    func rewardedVideoHasChangedAvailability(_ available: Bool) {
//     // showRVButton.isEnabled=true
//        logFunctionName(string: #function+String(available.self))
//    }
//
//    /**
//     Called after a rewarded video has finished playing.
//     */
//    func rewardedVideoDidEnd() {
//        logFunctionName()
//    }
//
//    /**
//     Called after a rewarded video has started playing.
//     */
//    func rewardedVideoDidStart() {
//        logFunctionName()
//    }
//
//    /**
//     Called after a rewarded video has been dismissed.
//     */
    func rewardedVideoDidClose() {
        //logFunctionName()
        let appdelegate = UIApplication.shared.delegate as! AppDelegate

        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController

        let frontNavigationController = UINavigationController(rootViewController: rootVC)
        appdelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appdelegate.window?.rootViewController = frontNavigationController
        appdelegate.window?.makeKeyAndVisible()

    }
//
//    /**
//     Called after a rewarded video has been opened.
//     */
//    func rewardedVideoDidOpen() {
//        logFunctionName()
//    }
//
//    /**
//     Called after a rewarded video has attempted to show but failed.
//
//     @param error The reason for the error
//     */
//    func rewardedVideoDidFailToShowWithError(_ error: Error!) {
//        logFunctionName(string: #function+String(describing: error.self))
//    }
//
//    /**
//     Called after a rewarded video has been viewed completely and the user is eligible for reward.
//
//     @param placementInfo An object that contains the placement's reward name and amount.
//     */
//    func didReceiveReward(forPlacement placementInfo: ISPlacementInfo!) {
//        logFunctionName(string: #function+String(describing: placementInfo.self))
//    }
//    /**
//     Called after a rewarded video has been clicked.
//
//     @param placementInfo An object that contains the placement's reward name and amount.
//     */
//    func didClickRewardedVideo(_ placementInfo: ISPlacementInfo!) {
//        logFunctionName(string: #function+String(describing: placementInfo.self))
//    }
//
//
//    func logFunctionName(string: String = #function) {
//        print("IronSource Swift Demo App: "+string)
//    }

    @IBAction func btnSkipClick(_ sender: UIButton)
    {

        if self.btnSkip.currentTitle == "Explore Testcraft"
        {
            IronSource.showRewardedVideo(with: self)
        }

        //IronSource.showRewardedVideo(with: self)
//        IronSource.showRewardedVideo(with:UIViewController(), placement: "DefaultRewardedVideo")

//        IronSource.showRewardedVideo(with: self)
    }

//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        targetContentOffset.pointee = scrollView.contentOffset
//    }



    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let translation = scrollView.translation(in: view)

        // Movement indication index
//        let movementOnAxis: CGFloat
//
//
//        let newX = min(max(view.frame.minX + scrollView.x, 0), view.frame.maxX)
//        movementOnAxis = newX / view.bounds.width
//        scrollView.frame.origin.x = newX


        let pageNumber = round(self.scrollView.contentOffset.x / self.scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)

        self.smallimageView1.isHidden = true
        self.smallimageView.isHidden = true
        self.smallimageView2.isHidden = true

        if pageNumber == 0{



            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseIn],
                           animations: {


                            self.imageView.contentMode = .scaleToFill


                            self.imageView.layer.cornerRadius = 6
                            self.imageView.layer.masksToBounds = true

                            //                            self.imageView.contentMode = .scaleToFill
                            self.imageView.image = UIImage.init(named: self.imagelist[0])

                            //  cell.layoutIfNeeded()
                           }, completion: { _ in

//                            DispatchQueue.main.asyncAfter(deadline: .now() + 3 ) {

                            UIView.transition(with: self.smallimageView, duration: 3.0, options: .transitionCrossDissolve, animations: { [self] in

                                self.smallimageView.isHidden = false


                                self.smallimageView.image = UIImage.init(named: "image_4")


                            }, completion: nil)
                           // }
                           })

        }


        else if pageNumber == 1{



            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseIn],
                           animations: {
                            //                            self.imageView.backgroundColor  = .white
                            //                            self.imageView.center.x -= self.imageView.bounds.width


                            self.imageView.layer.cornerRadius = 6
                            self.imageView.layer.masksToBounds = true

                            self.imageView.contentMode = .scaleToFill
                            self.imageView.image = UIImage.init(named: self.imagelist[1])




                           }, completion: { _ in

                            //  DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {

                            UIView.transition(with: self.smallimageView1, duration: 3.0, options: .transitionCrossDissolve, animations: { [self] in

                                self.smallimageView1.isHidden = false
                                self.smallimageView1.image = UIImage.init(named: "image_5")

                            }, completion: nil)

                            // }
                           })

        }


        else if pageNumber == 2{

            self.smallimageView3.isHidden = false
            self.smallimageView3.alpha = 1


//            if self.btnSkip.currentTitle == "Skip"
//            {
//
//            }else{
                self.btnSkip.layer.cornerRadius = 6
                self.btnSkip.layer.masksToBounds = true
                self.btnSkip.setTitle("Skip", for: .normal)
                self.btnSkip.setTitleColor(UIColor(red: 8/255, green: 167/255, blue: 227/255, alpha: 1), for: .normal)
                self.btnSkip.backgroundColor = .white
//            }

//            self.btnSkip.setTitleColor(.white, for: .normal)
//            self.btnSkip.backgroundColor = UIColor(red: 27/255, green: 145/255, blue: 239/255, alpha: 1)

            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseIn],
                           animations: {

                            self.imageView.contentMode = .scaleToFill

                            //                            self.imageView.backgroundColor  = .white
                            //                            self.imageView.center.x -= self.imageView.bounds.width

                            self.imageView.layer.cornerRadius = 6
                            self.imageView.layer.masksToBounds = true


                            self.imageView.image = UIImage.init(named: self.imagelist[2])




                           }, completion: { _ in


                            UIView.transition(with: self.smallimageView3, duration: 0.5, options: .transitionCrossDissolve, animations: { [self] in


                                self.smallimageView3.alpha = 0

                            }, completion: nil)




                            UIView.transition(with: self.smallimageView2, duration: 3.0, options: .transitionCrossDissolve, animations: { [self] in

                                self.smallimageView2.isHidden = false
                                self.smallimageView2.image = UIImage.init(named: "image_6")

                            }, completion: nil)

                           })

        }

        else if pageNumber == 3{

            self.smallimageView4.isHidden = false
            self.smallimageView3.isHidden = true
            self.smallimageView4.alpha = 1
            self.imageView.isHidden = true



            self.btnSkip.layer.cornerRadius = 6
            self.btnSkip.layer.masksToBounds = true
            self.btnSkip.setTitle("Explore Testcraft", for: .normal)
            self.btnSkip.setTitleColor(.white, for: .normal)
            self.btnSkip.backgroundColor = UIColor(red: 27/255, green: 145/255, blue: 239/255, alpha: 1)



            UIView.transition(with: self.smallimageView4, duration: 0.5, options: .transitionCrossDissolve, animations: { [self] in


                self.smallimageView4.alpha = 0

            }, completion: { _ in


                UIView.transition(with: self.imageView, duration: 3.0, options: .transitionCrossDissolve, animations: { [self] in

                    self.imageView.isHidden = false
                    self.imageView.contentMode = .scaleAspectFit

                    //                            self.imageView.backgroundColor  = .white
                    //                            self.imageView.center.x -= self.imageView.bounds.width

                    self.imageView.layer.cornerRadius = 6
                    self.imageView.layer.masksToBounds = true


                    self.imageView.image = UIImage.init(named: self.imagelist[3])


                }, completion: nil)


            })

        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

