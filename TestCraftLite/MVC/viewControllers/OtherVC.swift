//
//  OtherVC.swift
//  TestCraft
//
//  Created by ADMS on 19/06/19.
//  Copyright © 2019 ADMS. All rights reserved.
//

import UIKit
//import SJSwiftSideMenuController
import SDWebImage
import FirebaseAnalytics

class OtherVC: UIViewController, ActivityIndicatorPresenter ,ISRewardedVideoDelegate,ISImpressionDataDelegate,ISBannerDelegate{
    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()

    @IBOutlet var tblList:UITableView!
    @IBOutlet var lblTitle:UILabel!
    var strPackageID = ""
    var arrList = [String]()
    
    @IBOutlet var lbl_Full_Name:UILabel!
    @IBOutlet var lbl_Email:UILabel!
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var btnUserEdit: UIButton!
    @IBOutlet var btnOtherUsing: UIButton!

    @IBOutlet var vwProfileHideShow: UIView!
    @IBOutlet var vwProfileHeight: NSLayoutConstraint!
    @IBOutlet var lblHeight: NSLayoutConstraint!
    @IBOutlet var imgHeight: NSLayoutConstraint!
    var bannerView: ISBannerView! = nil


    func impressionDataDidSucceed(_ impressionData: ISImpressionData!) {

    }

    override func viewDidLoad() {
        super.viewDidLoad()
      //  setupIronSourceSdk()
        // Do any additional setup after loading the view.
        lblTitle.text = "Profile"
        btnOtherUsing.setTitle("signin/signup to change user", for: .normal)
        btnOtherUsing.setTitleColor(GetColor.signInText, for: .normal)
        btnOtherUsing.backgroundColor = UIColor.clear
        btnOtherUsing.isHidden = true
        // arrList = ["Edit Profile","Packages","Add Coin","Change Password","Logout"]
    }
    func logFunctionName(string: String = #function) {
        print("IronSource Swift Demo App: "+string)
    }

    func setupIronSourceSdk() {
      //  UserDefaults.standard.set(true, forKey: "isTestCraftt")
        IronSource.shouldTrackReachability(true)
//            IronSource.setRewardedVideoDelegate(self)
        IronSource.setBannerDelegate(self)
        IronSource.initWithAppKey(kAPPKEY, adUnits:[IS_BANNER])
        ISIntegrationHelper.validateIntegration()


        let BNSize: ISBannerSize = ISBannerSize(description: "BANNER",width:Int(view.frame.size.width) ,height:50)
       IronSource.loadBanner(with: self, size: BNSize)

    }

    func updateData()
    {
        btnUserEdit.isHidden = false

                if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
                {
                    if arrList.count > 0 { arrList.removeAll() }
                    let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
                    print("___result",result)
                    let strAccountTypeID = "\(result.value(forKey: "AccountTypeID") ?? "")"
//                    if strAccountTypeID == "1" // Login with Email
//                    {
                        //                arrList = ["Packages","Change Password","Change Preferences","About us","Contact Us!","Logout"]
        //                arrList = ["Packages","Change Password","Change Preferences", "Refer a Friend", "Redeem Coupon","Privacy Policy","Contact Us","Logout"]

                        // mehul hide
//                        arrList = ["Packages", "Subscription", "Change Password", "Change Preferences", "Privacy Policy","Contact Us","Sign Out"]//,"Change User"]"Curators",

//                        arrList = ["My Subscription","Privacy Policy","Contact Us","Sign Out"]
//
//                    }
//                    else if strAccountTypeID == "5"
//                    {
                        // mehul hide
//                        arrList = ["My Subscription","Privacy Policy","Contact Us","Sign Out"]
//                        arrList = ["Packages", "Subscription", "Change Preferences","Privacy Policy","Contact Us","Sign Out"]//,"Change User"]//,"Login"]"Curators",
//                        btnUserEdit.isHidden = true
//                    }
//                    else
//                    {
                        //                arrList = ["Packages","Change Preferences", "Redeem Coupon","Privacy Policy","Contact Us","Logout"]

                        // mehul hide
                        arrList = ["My Subscription","Privacy Policy","Contact Us","Sign Out"]
//                        arrList = ["Packages", "Subscription", "Change Preferences","Privacy Policy","Contact Us","Sign Out"]//,"Change User"]"Curators",
                   // }


                    if strAccountTypeID == "7" || strAccountTypeID == "12" || strAccountTypeID == "8" || strAccountTypeID == "13" || strAccountTypeID == "14" || strAccountTypeID == "9"
                    {
                        self.lbl_Email.text = "\(result.value(forKey: "StudentEmailAddress") ?? "")"
                    }else{
                                            self.lbl_Email.text = "\(result.value(forKey: "StudentMobile") ?? "")"

                    }

                    self.lbl_Full_Name.text = "\(result.value(forKey: "StudentFirstName") ?? "")" + " " + "\(result.value(forKey: "StudentLastName") ?? "")"


//                    let strAccountTypeID = "\(result.value(forKey: "AccountTypeID") ?? "")""Curators",
//                    if strAccountTypeID == "4"
//                    {
//                        self.lbl_Email.isHidden = true
//                    }

//                }
                imgProfile.clipsToBounds = true

                imgProfile.addShadowWithRadius(0,imgProfile.frame.width/2,0,color: UIColor.darkGray)
//        self.imgProfile.setImageForName("\(self.lbl_Full_Name.text ?? "")", backgroundColor: GetColor.themeBlueColor, circular: true, textAttributes: nil, gradient: false)
        if ((UserDefaults.standard.value(forKey: "ProfilePhoto")) != nil) //&& strAccountTypeID != "5"
        {
            let result : String = UserDefaults.standard.value(forKey: "ProfilePhoto") as! String
            let url = URL.init(string: result + ("").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)

            imgProfile?.sd_setImage(with: url, placeholderImage: UIImage(named: "person_placeholder.jpg"), options: .transformAnimatedImage){ (fetchedImage, error, cacheType, url) in
                if error != nil {
                    //Bhargav Hide
                    ////print("Error loading Image from URL: \(String(describing: url))\n(error?.localizedDescription)")
                    self.imgProfile.setImageForName("\(self.lbl_Full_Name.text ?? "")", backgroundColor: GetColor.themeBlueColor, circular: true, textAttributes: nil, gradient: false)
                    return
                }
                self.imgProfile.image = fetchedImage
            }

        }
        else
        {
            self.imgProfile.setImageForName("\(self.lbl_Full_Name.text ?? "")", backgroundColor: GetColor.themeBlueColor, circular: true, textAttributes: nil, gradient: false)
        }
        }
        tblList.reloadData()


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

       // Analytics.logEvent("ProfileScreen", parameters:nil)
      //  setupIronSourceSdk()

        Analytics.logEvent("ProfileScreen", parameters: [
            "My_Profile": "812" as NSObject
            ])

        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "812", comment: "My Profile", isFirstTime: "0")

        if UserDefaults.standard.object(forKey: "isLogin") != nil{
            let result = UserDefaults.standard.value(forKey: "isLogin")! as! NSString
            if(result == "1")
            {
                vwProfileHeight.constant = 80.0
                lblHeight.constant = 27.0
                imgHeight.constant = 60.5
                lbl_Email.isHidden = false
                btnUserEdit.isHidden = false

                updateData()

                self.tabBarController?.tabBar.isHidden = false
                if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()
                    // show Alert
                    print("The network is not reachable")
                    // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
                    return
                }

            }
        }else{
            vwProfileHeight.constant = 0.0
            lblHeight.constant = 0.0
            imgHeight.constant =  0.0
            lbl_Email.isHidden = true
            btnUserEdit.isHidden = true
            //"Curators",
            arrList = ["Privacy Policy","Contact Us","Sign In"]
            tblList.reloadData()
        }

        self.tabBarController?.tabBar.isHidden = false
        newTabAdsView.isHidden = false


    }
    
    @IBAction func BackClicked(_ sender: AnyObject) {
//        SJSwiftSideMenuController.toggleLeftSideMenu()
        //        arrPath.removeLast()
        //        navigationController?.popViewController(animated: true)
    }
        @IBAction func OtherUserClicked(_ sender: AnyObject) {
    //        SJSwiftSideMenuController.toggleLeftSideMenu()
            //        arrPath.removeLast()
            //        navigationController?.popViewController(animated: true)
            self.tabBarController?.tabBar.isHidden = true
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IntroVC") as? IntroVC
            vc?.isSelectExam = "1000"
            self.navigationController?.pushViewController(vc!, animated: false)


        }

    @IBAction func logoutClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to Logout?", preferredStyle: .alert)
        // Add actions
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in
            self.tabBarController?.tabBar.isHidden = true
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IntroVC") as? IntroVC
            vc?.isSelectExam = "1000"
            UserDefaults.standard.set("0", forKey: "isLogin")
            let prefs = UserDefaults.standard
            prefs.removeObject(forKey:"isLogin")
            prefs.removeObject(forKey:"isFirstTimeShow")
            prefs.removeObject(forKey:"logindata")
            prefs.removeObject(forKey:"exam_preferences")
            prefs.removeObject(forKey:"filter_price")
            prefs.removeObject(forKey:"isAdsInintalization")


            self.navigationController?.pushViewController(vc!, animated: false)
        }))
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func EditProfileClicked(_ sender: AnyObject) {
        Analytics.logEvent("EditIconClick", parameters: nil)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileEditVC") as? ProfileEditVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}


extension OtherVC:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    //My heightForRowAtIndexPath method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension//indexPath.section == selectedIndex ? UITableViewAutomaticDimension : 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "MyPackageSubscriptionCell"
        var cell: MyPackageSubscriptionCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? MyPackageSubscriptionCell
        if cell == nil {
            tableView.register(UINib(nibName: "MyPackageSubscriptionCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MyPackageSubscriptionCell
        }
        cell.lblPackageName.text = arrList[indexPath.row]
        //        cell.lblPackageName.text = arrMyPackageList[indexPath.row].TestPackageName ?? ""
        //        cell.lblStartDate.text = arrMyPackageList[indexPath.row].packageStartDate ?? ""
        //        cell.lblEndDate.text = arrMyPackageList[indexPath.row].packageEndDate ?? ""
        //        cell.lblPrice.text = "₹" + "\(arrMyPackageList[indexPath.row].TestPackageSalePrice ?? "")"
        //
        cell.topbgView1.addShadowWithRadius(0,8,0,color: UIColor.lightGray)
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {

        if arrList[indexPath.row] == "Edit Profile"
        {
//            self.tabBarController?.tabBar.isHidden = true
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "3301", comment: "Edit Profile", isFirstTime: "0")


        Analytics.logEvent("Edit Profile", parameters: [
                "Edit_Profile": "3301" as NSObject
                ])

        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileEditVC") as? ProfileEditVC
        self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if arrList[indexPath.row] == "Packages"
        {
//            self.tabBarController?.tabBar.isHidden = true
            api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "3302", comment: "Packages", isFirstTime: "0")
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PaymentListVC") as? PaymentListVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if arrList[indexPath.row] == "My Subscription"
        {
            //            self.tabBarController?.tabBar.isHidden = true
            api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "3306", comment: "subscriptions", isFirstTime: "0")
            Analytics.logEvent("MySubscriptionClick", parameters: [
                    "subscriptions": "3306" as NSObject
                    ])
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PaymentListVC") as? PaymentListVC
            vc!.isSub = "1"
            self.navigationController?.pushViewController(vc!, animated: true)
        }

//        else if indexPath.row == 2
//        {
//        self.tabBarController?.tabBar.isHidden = true
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddCoinVC") as? AddCoinVC
//            self.navigationController?.pushViewController(vc!, animated: true)
//        }
        else if arrList[indexPath.row] == "Change Password"
        {
            api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "3303", comment: "Change Password", isFirstTime: "0")
//            self.tabBarController?.tabBar.isHidden = true
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChangePasswordVC") as? ChangePasswordVC
//            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if arrList[indexPath.row] == "Change Preferences"
        {
            api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "3305", comment: "Change Prefernces", isFirstTime: "0")
            self.tabBarController?.tabBar.isHidden = true
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SelectExamVC") as? SelectExamVC
//            self.navigationController?.pushViewController(vc!, animated: true)

        }
        else if arrList[indexPath.row] == "Refer a Friend"
        {
            //                api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "3305", comment: "Change Prefernces", isFirstTime: "0")
//            self.tabBarController?.tabBar.isHidden = true
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReferaFriendVC") as? ReferaFriendVC
//            vc?.strTitle = "Refer a Friend"
//            self.navigationController?.pushViewController(vc!, animated: true)

        }
        else if arrList[indexPath.row] == "Redeem Coupon"
        {
            //                api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "3305", comment: "Change Prefernces", isFirstTime: "0")
//                            self.tabBarController?.tabBar.isHidden = true
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RedeemCouponVC") as? RedeemCouponVC
//            vc?.strTitle = "Redeem Coupon"
////            SJSwiftSideMenuController.pushViewController(vc!, animated: true)
//            self.navigationController?.pushViewController(vc!, animated: true)

        }
        else if arrList[indexPath.row] == "Privacy Policy"
        {
//            //"Privacy & Policy"
            //Analytics.logEvent("ViewInvoiceLinkClick", parameters: nil)
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InvoiceListVC") as? InvoiceListVC
            vc?.strTitle = "Privacy Policy"
            vc?.strLoadUrl = "\(API.hostName1)\(API.PrivacyPolicy)"
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if arrList[indexPath.row] == "Contact Us"
        {
//            //"Contact Us"
            api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "3307", comment: "contact us", isFirstTime: "0")
            Analytics.logEvent("ContactUsClick", parameters: [
                    "contact_us": "3307" as NSObject
                    ])

            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ContactUsVC") as? ContactUsVC
            self.navigationController?.pushViewController(vc!, animated: true)

        }
        else if arrList[indexPath.row] == "Curators"
        {
//            //"Contact Us"
//            api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "3307", comment: "contact us", isFirstTime: "0")

            UserDefaults.standard.set(false, forKey: "isFilterApply")
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TutorVC") as? TutorVC
            self.navigationController?.pushViewController(vc!, animated: true)

        }
        else if arrList[indexPath.row] == "Logout"
        {
            Logout()
        }
        else if arrList[indexPath.row] == "Sign In"
        {
            UserDefaults.standard.setValue("", forKey: "isFirstTimeShow")
                            self.tabBarController?.tabBar.isHidden = true

//                            for controller in self.navigationController!.viewControllers as Array {
//                                //Bhargav Hide
//                                print(controller)
//                                if controller.isKind(of: SelectExamVC.self) {
//                                    self.navigationController!.popToViewController(controller, animated: false)
//                                    break
//                                }
//            //                    else if controller.isKind(of: LoginVC.self) {
//            //                        self.navigationController!.popToViewController(controller, animated: false)
//            //                        break
//            //                    }
//                            }
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IntroVC") as? IntroVC
//            vc?.isSelectExam = "1000"
//            self.navigationController?.pushViewController(vc!, animated: false)



            let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IntroVC") as UIViewController
            rootVC.logFBEvent(Event_Name: "Facebook_user_install", device_Name: "iOS", valueToSum: 1)
            if ((UserDefaults.standard.value(forKey: "TrackTokenID")) == nil)
            {
                rootVC.api_Activity_Action(Type: "0", gameid: API.strGameID, gamesessionid: "", actionid: "", comment: "", isFirstTime: "1")
            }
            else{
                //            if UserDefaults.standard.object(forKey: "isLogin") != nil{
                // exist
                rootVC.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "101", comment: "Spalsh Screen", isFirstTime: "0")
                //            }
            }

            self.navigationController?.pushViewController(rootVC, animated: true)


        }
        else if arrList[indexPath.row] == "Change User"
        {
            self.tabBarController?.tabBar.isHidden = true
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IntroVC") as? IntroVC
            vc?.isSelectExam = "1000"
            self.navigationController?.pushViewController(vc!, animated: false)
        }
        else if  arrList[indexPath.row] == "Sign Out"
        {

            Logout()
//            self.tabBarController?.tabBar.isHidden = true
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IntroVC") as? IntroVC
//            vc?.isSelectExam = "1000"
//            self.navigationController?.pushViewController(vc!, animated: false)
        }
        else if arrList[indexPath.row] == "Subscription"
        {
                        self.tabBarController?.tabBar.isHidden = true
//                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SelectExamVC") as? SelectExamVC
//            vc!.isSubscription = "true"
            //            SJSwiftSideMenuController.pushViewController(vc!, animated: false)
//                        self.navigationController?.pushViewController(vc!, animated: true)

        }
    }


    func Logout()
    {
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "3304", comment: "Logout", isFirstTime: "0")

        Analytics.logEvent("Logout", parameters: [
            "Logout": "3304" as NSObject
            ])

        Analytics.logEvent("SignOutClick", parameters: nil)
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to Logout?", preferredStyle: .alert)
        // Add actions
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in
            self.tabBarController?.tabBar.isHidden = false
        })
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in
            self.tabBarController?.tabBar.isHidden = true
            UserDefaults.standard.set("0", forKey: "isLogin")
            let prefs = UserDefaults.standard
            prefs.removeObject(forKey:"isLogin")
            prefs.removeObject(forKey:"logindata")
            prefs.removeObject(forKey:"exam_preferences")
            prefs.removeObject(forKey:"filter_price")
            prefs.removeObject(forKey:"ProfilePhoto")
            prefs.removeObject(forKey:"isFirstTimeShow")
           // prefs.removeObject(forKey:"isTestCraftt")
            prefs.removeObject(forKey:"isAppLunach")
            prefs.removeObject(forKey:"isError")
            prefs.removeObject(forKey:"isAdsInintalization")





            for controller in self.navigationController!.viewControllers as Array {
                //Bhargav Hide
                print(controller)
                if controller.isKind(of: IntroVC.self) {
                    self.navigationController!.popToViewController(controller, animated: false)
                    break
                }
            }

            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IntroVC") as? IntroVC

            self.navigationController?.pushViewController(vc!, animated: false)
        }))
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)

    }
}

extension OtherVC{
    func rewardedVideoHasChangedAvailability(_ available: Bool) {
    }

    func didReceiveReward(forPlacement placementInfo: ISPlacementInfo!) {
    }

    func rewardedVideoDidFailToShowWithError(_ error: Error!) {
    }

    func rewardedVideoDidOpen() {
    }

    func rewardedVideoDidClose() {
//        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
//
//        let frontNavigationController = UINavigationController(rootViewController: rootVC)
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = frontNavigationController
//        self.window?.makeKeyAndVisible()
    }

    func rewardedVideoDidStart() {
    }

    func rewardedVideoDidEnd() {
    }

    func didClickRewardedVideo(_ placementInfo: ISPlacementInfo!) {
    }

}
extension OtherVC
{
    //MARK: ISBannerDelegate Functions
   func bannerDidLoad(_ bannerView: ISBannerView!) {

    print("working")

    self.bannerView = bannerView
    //view.frame.size.width/2 - bannerView.frame.size.width/2
        if #available(iOS 11.0, *) {
            bannerView.frame = CGRect(x: 0, y: view.frame.size.height - bannerView.frame.size.height-60, width: bannerView.frame.size.width, height: view.frame.size.height - self.view.safeAreaInsets.bottom * 2.5)
        } else {
                bannerView.frame = CGRect(x: 0, y: view.frame.size.height - bannerView.frame.size.height-60, width: bannerView.frame.size.width, height: bannerView.frame.size.height  * 2.5)
        }
        view.addSubview(self.bannerView)


//    self.tabBarController?.tabBar.frame = CGRect(x: 0, y: view.frame.size.height - 99, width: view.frame.size.width, height: 49)

//    print("tabBarController frame",self.tabBarController?.tabBar.frame)
//    print("supaerviewOftabbar",self.tabBarController?.tabBar.superview)
//    print("subviewOftabbar",self.tabBarController?.tabBar.subviews)

//   var customeView = ISBannerView(frame: CGRect(x: 0, y: ((self.tabBarController?.tabBar.frame.origin.y)!) + 49 , width: view.frame.size.width, height: 50))
//    print("customeView frame",customeView.frame)
//    customeView.backgroundColor = .red
//    customeView = bannerView

  //  bannerView.frame = CGRect(x: 0, y: ((self.tabBarController?.tabBar.frame.origin.y)!) + 49, width: view.frame.size.width, height: 50)
//    self.tabBarController?.tabBar.addSubview(customeView)








//    let tabSubView = UIView(frame: CGRect(x: 0, y: ((self.tabBarController?.tabBar.frame.origin.y)! + 49), width: view.frame.size.width, height: 50))
//    tabSubView.backgroundColor = .red
//    view.addSubview(tabSubView)

//
//    print("tabbar frame",self.tabBarController?.tabBar.frame)

      // self.bannerView = bannerView
//       if #available(iOS 11.0, *) {
//        bannerView.frame = CGRect(x: 0, y: ((self.tabBarController?.tabBar.frame.origin.y)! + 49), width: view.frame.size.width, height: 50)
//       } else {
//        bannerView.frame = CGRect(x: 0, y: ((self.tabBarController?.tabBar.height)! + 49), width: view.frame.size.width, height: 50)
//       }
  //  self.bannerView.backgroundColor = .darkGray
//    print("bannerView frame",bannerView.frame)
//    view.backgroundColor = .clear
//    self.tabBarController?.tabBar.backgroundColor = .red
//            view.addSubview(bannerView)
   // self.tabBarController?.tabBar.isHidden = true


//    self.bannerView=bannerView
//    if #available(iOS 11.0, *) {
//        bannerView.frame = CGRect(x: 0, y: view.frame.size.width/2 - bannerView.frame.size.width/2, width: bannerView.frame.size.width, height: bannerView.frame.size.height - self.view.safeAreaInsets.bottom * 2.5)
//    } else {
//            bannerView.frame = CGRect(x: 0, y: view.frame.size.width/2 - bannerView.frame.size.width/2, width: bannerView.frame.size.width, height: bannerView.frame.size.height  * 2.5)
//    }
//
////view.frame.size.width/2 - bannerView.frame.size.width/2
//
//    view.addSubview(bannerView)
//   // view.bringSubviewToFront(tabSubView)

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
//   func impressionDataDidSucceed(_ impressionData: ISImpressionData!) {
//       logFunctionName(string: #function+String(describing: impressionData))
//
//   }

}
