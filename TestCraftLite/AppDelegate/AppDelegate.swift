//
//  AppDelegate.swift
//  TestCraftLite
//
//  Created by ADMS on 24/03/21.
//

import UIKit
import GoogleSignIn
import Firebase
import FacebookCore
import FBSDKCoreKit
import IQKeyboardManager
import FirebaseAnalytics
import AppTrackingTransparency
import AdSupport


import Firebase
import FirebaseMessaging
import FirebaseInstanceID
import UserNotifications
//import FirebaseDynamicLinks
//import FirebaseDynamicLinks
//import FirebaseInstanceID
//import UserNotifications
//import FirebaseMessaging

var strcellulerNetworkGloble = ""

@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate
{


   // var isAppLunach:Bool = true
    var window: UIWindow?
    var orientationLock = UIInterfaceOrientationMask.all
    var storyboard:UIStoryboard!
    let gcmMessageIDKey = "gcm.message_id"

    var newView = UIView()

    var newTabAdsView:UIView!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


        // new code

//        newTabAdsView.frame = CGRect(x: 0, y: self.window!.frame.size.height - 99, width: self.window!.frame.size.width, height: 99)
//        self.window!.addSubview(newTabAdsView)
 //       newTabAdsView.backgroundColor = .yellow

//        self.tabba.frame = CGRect(x: 0, y: 0, width: self.window!.frame.size.height, height: 50)
//        newTabAdsView.addSubview(self.tabBar)


//        var customeView = ISBannerView(frame: CGRect(x: 0, y:50 , width: self.window.frame.size.width, height: 50))
//        print("customeView frame",customeView.frame)
//        bannerView.frame = CGRect(x: 0, y:50 , width: self.window.frame.size.width, height: 50)
//        customeView = bannerView
//        newTabAdsView.addSubview(customeView)





        // Override point for customization after application launch.
//        GIDSignIn.sharedInstance().clientID = "67592456911-ek8fp3bv0on8i6h10vhkikgfh30bog6d.apps.googleusercontent.com"
        IQKeyboardManager.shared().isEnabled = true
//        GIDSignIn.sharedInstance().clientID = "605427668841-hnktldni8qv7h4fj8bjgp1o8c9gl3eb4.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().clientID = "1019001765891-of9s52hilme0ei89a6e0n19mmrf4354d.apps.googleusercontent.com"
        FirebaseApp.configure()

      //  requestPermission()

        if #available(iOS 10.0, *) {

            UNUserNotificationCenter.current().delegate = self


//                    Messaging.messaging().delegate = self
//                    Messaging.messaging().shouldEstablishDirectChannel = true

                    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                    UNUserNotificationCenter.current().requestAuthorization(
                        options: authOptions,
                        completionHandler: { authorized, error in
                            print("authorized",authorized)
                            print(error)
//                            UNUserNotificationCenter.current().delegate = self

                        })
                } else {
                    let settings: UIUserNotificationSettings =
                        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                    application.registerUserNotificationSettings(settings)
                }


                // request permission from user to send notification
//                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { authorized, error in
//                    if authorized {
//                        DispatchQueue.main.async(execute: {
//                            application.registerForRemoteNotifications()
//                        })
//                    }
//                    else{
//                        print("Notification access denied")
//                    }
//                })
        application.registerForRemoteNotifications()

        Messaging.messaging().delegate = self



//        setupIronSourceSdk()
//        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
//
//        NSSetUncaughtExceptionHandler { exception in
//            //Bhargav Hide
//            ////print(exception)
//        }
        let UUIDValue = UIDevice.current.identifierForVendor!.uuidString
        print("UUID: \(UUIDValue)")
        UserDefaults.standard.set(UUIDValue, forKey: "UUID")
//
//       // NetworkManager.shared.startNetworkReachabilityObserver()
//        Settings.isAutoInitEnabled = true
//        ApplicationDelegate.initializeSDK(nil)
//        Settings.isAutoLogAppEventsEnabled = true


//        if let gai = GAI.sharedInstance(),
//            let gaConfigValues = Bundle.main.infoDictionary?["GoogleAnalytics"] as? [String: String],
//            let trackingId = gaConfigValues["TRACKING_ID"]
//        {
//            gai.logger.logLevel = .error
//            gai.trackUncaughtExceptions = false
//            gai.tracker(withTrackingId: trackingId)
//        } else {
//            assertionFailure("Google Analytics not configured correctly")
//        }


        self.PushDashbord()
        return true
    }

    func requestPermission() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    // Tracking authorization dialog was shown
                    // and we are authorized
                    print("Authorized")

                    // Now that we are authorized we can get the IDFA
                    print(ASIdentifierManager.shared().advertisingIdentifier)
                case .denied:
                    // Tracking authorization dialog was
                    // shown and permission is denied
                    print("Denied")
                case .notDetermined:
                    // Tracking authorization dialog has not been shown
                    print("Not Determined")
                case .restricted:
                    print("Restricted")
                @unknown default:
                    print("Unknown")
                }
            }
        }
    }


    // [START receive_message]
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
//
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//        }
//
//        print(userInfo)
//
//
//        completionHandler(UIBackgroundFetchResult.newData)
//
//    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        print(userInfo)

        completionHandler(UIBackgroundFetchResult.newData)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }


    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Token:",token)
        UserDefaults.standard.set(token, forKey: "DeviceToken")
    }





//    func application(_ application: UIApplication,
//                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
//                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult)
//                       -> Void) {
//      // If you are receiving a notification message while your app is in the background,
//      // this callback will not be fired till the user taps on the notification launching the application.
//      // TODO: Handle data of notification
//
//      // With swizzling disabled you must let Messaging know about the message, for Analytics
//      // Messaging.messaging().appDidReceiveMessage(userInfo)
//
//      // Print message ID.
//      if let messageID = userInfo[gcmMessageIDKey] {
//        print("Message ID: \(messageID)")
//      }
//
//      // Print full message.
//      print(userInfo)
//
//      completionHandler(UIBackgroundFetchResult.newData)
//    }
//    func setupIronSourceSdk() {
//
//
//
//        // Before initializing any of our products (Rewarded video, Offerwall or Interstitial) you must set
//        // their delegates. Take a look at these classes and you will see that they each implement a product
//        // protocol. This is our way of letting you know what's going on, and if you don't set the delegates
//        // we will not be able to communicate with you.
//        // We're passing 'self' to our delegates because we want
//        // to be able to enable/disable buttons to match ad availability.
//
//
//
//
//
//        IronSource.shouldTrackReachability(true)
//        IronSource.setRewardedVideoDelegate(self)
////        IronSource.setOfferwallDelegate(self)
////        IronSource.setInterstitialDelegate(self)
////        IronSource.setBannerDelegate(self)
////        IronSource.add(self)
//
////        IronSource.initWithAppKey(kAPPKEY, adUnits:[IS_REWARDED_VIDEO])
//
//        IronSource.initWithAppKey(kAPPKEY, adUnits:[IS_REWARDED_VIDEO])
//
//       // IronSource.initWithAppKey(kAPPKEY)
//
//        ISIntegrationHelper.validateIntegration()
//
//
//
//
//
////        IronSource.setRewardedVideoDelegate(self)
////
////        let userID = IronSource.advertiserId() // Ironsource generates a userID automatically for each user
////        IronSource.setUserId(userID)
////
////        let appKey = "100f13569" // from my Ironsource dashboard
////        IronSource.initWithAppKey(appKey, adUnits: [IS_REWARDED_VIDEO])
//
//
//
//        // To initialize specific ad units:
//    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//            if (GIDSignIn.sharedInstance().handle(url)) {
//                return true
//            } else
        if (ApplicationDelegate.shared.application(app, open: url, options: options)) {
                return true
            }
            return false
        }
//    func application(_ application: UIApplication,
//                  open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//     if GIDSignIn.sharedInstance().handle(url) {
//         return true
//     } else if ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation) {
//         return true
//     }
//
//     return false
// }
//
// @available(iOS 9.0, *)
// func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//     if GIDSignIn.sharedInstance().handle(url) {
//         return true
//     } else if ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation]
//         ) {
//         return true
//     }
//     return false
// }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    func applicationWillTerminate(_ application: UIApplication) {
        UserDefaults.standard.setValue("", forKey: "isAdsInintalization")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
//    func applicationDidBecomeActive(_ application: UIApplication) {
//        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//        #if DEBUG
//        //  self.tryCheckUpdate()
//        #else
//        //            self.tryCheckUpdate() //comment when send testing
//        #endif
//
//        //        self.birthday()
//        AppLinkUtility.fetchDeferredAppLink { (url, error) in
//            if let error = error {
//                print("fb_link____________Received error while fetching deferred app link %@", error)
//            }
//            if let url = url {
//                print("fb_link____________\n \(url)")
//
//                if #available(iOS 10, *) {
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                } else {
//                    UIApplication.shared.openURL(url)
//                }
//            }
//        }
//
//    }
    func PushDashbord() {

        storyboard = UIStoryboard(name: "Main", bundle: nil)

        if (UserDefaults.standard.object(forKey: "Deeplink") != nil)
        {
            isDeeplink = (UserDefaults.standard.value(forKey: "Deeplink")! as! NSString) as String
        }
        //        var params = ["":""]
        var result_AccountTypeID = ""

        if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
        {
            let result_logindata = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
            result_AccountTypeID = "\(result_logindata["AccountTypeID"] ?? "")"
        }
        print("isDeeplink: \(isDeeplink), AccountTypeID: \(result_AccountTypeID) ")
        if isDeeplink != "" //&& result_AccountTypeID == "5"
        {
            var deep_select_CV = ""

            if isDeeplink == "1"{ deep_select_CV = "SelectExamLangVC" }
            else if isDeeplink == "2"{ deep_select_CV = "DeeplinkTestListVC"}
            else { deep_select_CV = "DeeplinkTestListVC"}
            let rootVC = storyboard.instantiateViewController(withIdentifier: deep_select_CV) as UIViewController
            rootVC.logFBEvent(Event_Name: "Facebook_user_install", device_Name: "iOS", valueToSum: 1)
//            SJSwiftSideMenuController.setUpNavigation(rootController: rootVC, leftMenuController: sideVC_L, rightMenuController: sideVC_R, leftMenuType: .SlideOver, rightMenuType: .SlideView)

            let frontNavigationController = UINavigationController(rootViewController: rootVC)
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = frontNavigationController
            self.window?.makeKeyAndVisible()
        }
        else
        {
            var select_CV = ""
            if UserDefaults.standard.object(forKey: "isLogin") != nil{
                // exist
                //            if (key == 0)

                let result = UserDefaults.standard.value(forKey: "isLogin")! as! NSString
                if (result == "1")
                {
                    print("Store All DATA: ",result)
                    let dictPrice:[String:Any] = ["minPrice":"0", "maxPrice":"5000"]
                    UserDefaults.standard.set(dictPrice, forKey: "filter_price")
                    if ((UserDefaults.standard.value(forKey: "exam_preferences")) != nil)
                    {
                        let exam_preferences = UserDefaults.standard.value(forKey: "exam_preferences")! as! NSDictionary

                        //Bhargav Hide
                        print("exam_preferences",exam_preferences)
                        strCategoryID = "\(exam_preferences.value(forKey: "CategoryID") ?? "")"
                        strCategoryTitle = "\(exam_preferences.value(forKey: "CategoryTitle") ?? "")"
                        select_CV = "BaseTabBarViewController"
                        //                    select_CV = "SelectExamVC"

                        arrPath = exam_preferences.value(forKey: "arrPath") as! [String]
                        if strCategoryID == "1" //Exam
                        {
                            strCategoryID1 = "\(exam_preferences.value(forKey: "CategoryID1") ?? "")"//Board
                            strCategoryID2 = "\(exam_preferences.value(forKey: "CategoryID2") ?? "")"//Standard
                            strCategoryID3 = "\(exam_preferences.value(forKey: "CategoryID3") ?? "")"//Subject
                            strCategoryTitle1 = "\(exam_preferences.value(forKey: "CategoryTitle1") ?? "")"//Board
                            strCategoryTitle2 = "\(exam_preferences.value(forKey: "CategoryTitle2") ?? "")"//Standard
                            strCategoryTitle3 = "\(exam_preferences.value(forKey: "CategoryTitle3") ?? "")"//Subject
                        }
                        else
                        {
                            strCategoryID1 = "\(exam_preferences.value(forKey: "CategoryID1") ?? "")"//Exam
                            strCategoryID3 = "\(exam_preferences.value(forKey: "CategoryID3") ?? "")"//Subject
                            strCategoryTitle1 = "\(exam_preferences.value(forKey: "CategoryTitle1") ?? "")"//Exam
                            strCategoryTitle3 = "\(exam_preferences.value(forKey: "CategoryTitle3") ?? "")"//Subject
                        }
                        strTutorsId = "\(exam_preferences.value(forKey: "TutorID") ?? "")"
                        strTutorsTitle = "\(exam_preferences.value(forKey: "TutorTitle") ?? "")"
                        selectedPackages = 1


//                        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController

    //                    let rootVC = storyboard.instantiateViewController(withIdentifier: select_CV) as UIViewController
//                        rootVC.logFBEvent(Event_Name: "Facebook_user_install", device_Name: "iOS", valueToSum: 1)
//                        if ((UserDefaults.standard.value(forKey: "TrackTokenID")) == nil)
//                        {
//                            rootVC.api_Activity_Action(Type: "0", gameid: API.strGameID, gamesessionid: "", actionid: "", comment: "", isFirstTime: "1")
//                        }
//                        else{
//                            rootVC.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "101", comment: "Spalsh Screen", isFirstTime: "0")
//                        }

                        Analytics.logEvent("SpalshScreen", parameters: [
                            "Spalsh": "101" as NSObject
                            ])

//                        UserDefaults.standard.set(false, forKey: "isTestCraftt")
                        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController

                            let frontNavigationController = UINavigationController(rootViewController: rootVC)
                            self.window = UIWindow(frame: UIScreen.main.bounds)
                            self.window?.rootViewController = frontNavigationController
                            self.window?.makeKeyAndVisible()



//                        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AnimationVC") as! AnimationVC
//
//                        let frontNavigationController = UINavigationController(rootViewController: rootVC)
//                        self.window = UIWindow(frame: UIScreen.main.bounds)
//                        self.window?.rootViewController = frontNavigationController
//                        self.window?.makeKeyAndVisible()



//                        let frontNavigationController = UINavigationController(rootViewController: rootVC)
//                        self.window = UIWindow(frame: UIScreen.main.bounds)
//                        self.window?.rootViewController = frontNavigationController
//                        self.window?.makeKeyAndVisible()

                    }
                    else
                    {
//                        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
//
//    //                    let rootVC = storyboard.instantiateViewController(withIdentifier: select_CV) as UIViewController
//                        rootVC.logFBEvent(Event_Name: "Facebook_user_install", device_Name: "iOS", valueToSum: 1)
//                        if ((UserDefaults.standard.value(forKey: "TrackTokenID")) == nil)
//                        {
//                            rootVC.api_Activity_Action(Type: "0", gameid: API.strGameID, gamesessionid: "", actionid: "", comment: "", isFirstTime: "1")
//                        }
//                        else{
//            //            if UserDefaults.standard.object(forKey: "isLogin") != nil{
//                            // exist
//                            rootVC.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "101", comment: "Spalsh Screen", isFirstTime: "0")
//            //            }
//                        }

                        


                        Analytics.logEvent("SpalshScreen", parameters: [
                            "Spalsh": "101" as NSObject
                            ])

                      //  UserDefaults.standard.set(false, forKey: "isTestCraftt")
                        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController

                            let frontNavigationController = UINavigationController(rootViewController: rootVC)
                            self.window = UIWindow(frame: UIScreen.main.bounds)
                            self.window?.rootViewController = frontNavigationController
                            self.window?.makeKeyAndVisible()


//                        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AnimationVC") as! AnimationVC
//
//                        let frontNavigationController = UINavigationController(rootViewController: rootVC)
//                        self.window = UIWindow(frame: UIScreen.main.bounds)
//                        self.window?.rootViewController = frontNavigationController
//                        self.window?.makeKeyAndVisible()


                    }
                }
                else
                {
                   // select_CV = "IntroVC"


//                    let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
//
////                    let rootVC = storyboard.instantiateViewController(withIdentifier: select_CV) as UIViewController
//                    rootVC.logFBEvent(Event_Name: "Facebook_user_install", device_Name: "iOS", valueToSum: 1)
//                    if ((UserDefaults.standard.value(forKey: "TrackTokenID")) == nil)
//                    {
//                        rootVC.api_Activity_Action(Type: "0", gameid: API.strGameID, gamesessionid: "", actionid: "", comment: "", isFirstTime: "1")
//                    }
//                    else{
//        //            if UserDefaults.standard.object(forKey: "isLogin") != nil{
//                        // exist
//                        rootVC.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "101", comment: "Spalsh Screen", isFirstTime: "0")
//        //            }
//                    }
                    Analytics.logEvent("SpalshScreen", parameters: [
                        "Spalsh": "101" as NSObject
                        ])

                  //  UserDefaults.standard.set(false, forKey: "isTestCraftt")
                    let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController

                        let frontNavigationController = UINavigationController(rootViewController: rootVC)
                        self.window = UIWindow(frame: UIScreen.main.bounds)
                        self.window?.rootViewController = frontNavigationController
                        self.window?.makeKeyAndVisible()


//                    let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AnimationVC") as! AnimationVC
//
//
//
//                    let frontNavigationController = UINavigationController(rootViewController: rootVC)
//                    self.window = UIWindow(frame: UIScreen.main.bounds)
//                    self.window?.rootViewController = frontNavigationController
//                    self.window?.makeKeyAndVisible()
                }
            }
            else
            {
//                let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
//               // select_CV = "IntroVC"
////                let rootVC = storyboard.instantiateViewController(withIdentifier: select_CV) as UIViewController
//                rootVC.logFBEvent(Event_Name: "Facebook_user_install", device_Name: "iOS", valueToSum: 1)
//                if ((UserDefaults.standard.value(forKey: "TrackTokenID")) == nil)
//                {
//                    rootVC.api_Activity_Action(Type: "0", gameid: API.strGameID, gamesessionid: "", actionid: "", comment: "", isFirstTime: "1")
//                }
//                else{
//    //            if UserDefaults.standard.object(forKey: "isLogin") != nil{
//                    // exist
//                    rootVC.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "101", comment: "Spalsh Screen", isFirstTime: "0")
//    //            }
//                }


                Analytics.logEvent("SpalshScreen", parameters: [
                    "Spalsh": "101" as NSObject
                    ])
//                guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//                tracker.set("MarketPlaceScreen", value: "")
//
//                guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//                tracker.send(builder.build() as [NSObject : AnyObject])


//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {


             //   UserDefaults.standard.set(true, forKey: "isAppLunach")


              if  UIDevice.current.userInterfaceIdiom == .phone
              {
                if  UserDefaults.standard.bool(forKey: "isAppLunach") == false{

               //     UserDefaults.standard.set(false, forKey: "isTestCraftt")
                    UserDefaults.standard.set(true, forKey: "isAppLunach")
                    let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TutorialPageViewController") as! TutorialPageViewController

                    let frontNavigationController = UINavigationController(rootViewController: rootVC)
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    self.window?.rootViewController = frontNavigationController
                    self.window?.makeKeyAndVisible()

                }else{

                let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
               //     UserDefaults.standard.set(false, forKey: "isTestCraftt")
                    let frontNavigationController = UINavigationController(rootViewController: rootVC)
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    self.window?.rootViewController = frontNavigationController
                    self.window?.makeKeyAndVisible()

                }
              }else{
                let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
               //     UserDefaults.standard.set(false, forKey: "isTestCraftt")
                    let frontNavigationController = UINavigationController(rootViewController: rootVC)
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    self.window?.rootViewController = frontNavigationController
                    self.window?.makeKeyAndVisible()

              }
//                }


                //select_CV = "IntroVC"
            }

//            SJSwiftSideMenuController.setUpNavigation(rootController: rootVC, leftMenuController: sideVC_L, rightMenuController: sideVC_R, leftMenuType: .SlideOver, rightMenuType: .SlideView)

        }
//        AppUtility.lockOrientation(.portraitUpsideDown)

//        SJSwiftSideMenuController.enableDimbackground = true
//        SJSwiftSideMenuController.leftMenuWidth = 280
//        //=======================================
//        self.window?.rootViewController = mainVC
//        NetworkManager.shared.window = self.window
//        self.window?.makeKeyAndVisible()

    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//                return ApplicationDelegate.shared.application(app, open: url, options: options)
//        }



}

struct AppUtility {

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {

        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {

        self.lockOrientation(orientation)

        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
}

@available(iOS 10, *)
extension AppDelegate{

    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo

        print(userInfo)
         print("Message ID: \(userInfo["gcm.message_id"]!)")
        completionHandler([[.alert, .sound]])

    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo

        print("Do what ever you want")
        // Print full message.
        print("tap on on forground app",userInfo)


        completionHandler()
    }
}

extension AppDelegate : MessagingDelegate {

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        UserDefaults.standard.set(fcmToken, forKey: "fcmToken")
//        Messaging.messaging().subscribe(toTopic: "/topics/nutriewell_live")
//        Messaging.messaging().shouldEstablishDirectChannel = true

    }

//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//        print("Received data message: \(remoteMessage.appData)")
//    }


}










