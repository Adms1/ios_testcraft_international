//
//  TutorRatingVC.swift
//  TestCraftLite
//
//  Created by ADMS on 31/05/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift
import SDWebImage
import Cosmos
import KMPlaceholderTextView


class TutorRatingVC: UIViewController ,ActivityIndicatorPresenter, UITextViewDelegate{

    @IBOutlet var tblRatingList:UITableView!
    @IBOutlet var lblTutorName:UILabel!

    @IBOutlet var vwStarEdit:CosmosView!
    @IBOutlet var txtComment:KMPlaceholderTextView!
    @IBOutlet var btnSubmit:UIButton!
    @IBOutlet var btnClosePopUp:UIButton!

    @IBOutlet var btnWrite:UIButton!

    @IBOutlet var vwMainPopUp:UIView!


    @IBOutlet weak var lblNoDataFound:UILabel!

    @IBOutlet weak var vwSubMain:UIView!

    var isWritePopUp:Bool = false


    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()

    var tutorId:Int = -1
    var tutorName:String = ""

    var arrTutorList = [arrTutorListModel]()

//    let placeholder = "Enter your review here..."

    override func viewDidLoad() {


        vwStarEdit.settings.fillMode = .half

        self.tabBarController?.tabBar.isHidden = true

        super.viewDidLoad()

        self.vwMainPopUp.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        btnWrite.layer.cornerRadius = btnWrite.layer.frame.height/2
        btnWrite.layer.masksToBounds = true


        btnSubmit.layer.cornerRadius = btnSubmit.layer.frame.height/2
        btnSubmit.layer.masksToBounds = true

        txtComment.layer.borderWidth = 1
        txtComment.layer.borderColor = UIColor.lightGray.cgColor

        vwSubMain.layer.cornerRadius = 6.0
        vwSubMain.layer.masksToBounds = true

        txtComment.layer.cornerRadius = 6.0
        txtComment.layer.masksToBounds = true
//        txtComment.delegate = self

//        txtComment.insertTextPlaceholder(with: <#T##CGSize#>)
//        txtComment.toolbarPlaceholder = "Enter your review here..."

//        txtComment.text = "Enter your review here..."
//        txtComment.textColor = UIColor.lightGray


        vwMainPopUp.isHidden = true

        tblRatingList.register(UINib(nibName: "RatingCell", bundle: nil), forCellReuseIdentifier: "RatingCell")

//        tblRatingList.rowHeight = UITableView.automaticDimension;
//        tblRatingList.estimatedRowHeight = 107; // set to whatever your "average" cell height is

        self.tblRatingList.estimatedRowHeight = 107
        self.tblRatingList.rowHeight = UITableView.automaticDimension


        lblTutorName.text = tutorName
        self.api_call_tutor_rating_list()
    }
    
    @IBAction func btnBack(){
        self.dismiss(animated: true, completion: nil)
    }


    func textViewDidBeginEditing(_ textView: UITextView) {

        if txtComment.textColor == UIColor.lightGray {
            txtComment.text = ""
            txtComment.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {

        if txtComment.text == "" {

            txtComment.text = "Enter your review here..."
            txtComment.textColor = UIColor.lightGray
        }
    }




    @IBAction func btnClosePopUpClick(){
        vwMainPopUp.isHidden = true
    }

    @IBAction func btnSubmitClick(){
        if vwStarEdit.rating == 0
        {
            self.view.makeToast("Please give rating", duration: 3.0, position: .bottom)
        }else{
            // api call

            api_Cal_submit_rating()
        }
    }

    @IBAction func btnWriteComment(){
        vwMainPopUp.isHidden = false
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary

        if btnWrite.titleLabel?.text == "Write a Review"
        {
            vwStarEdit.rating = 0.0
            txtComment.text = ""

        }else{
            let filteredIndices = self.arrTutorList.firstIndex {String($0.StudentID) == "\(result["StudentID"] ?? "")"}

            txtComment.text = self.arrTutorList[filteredIndices ?? 0].Remarks
            txtComment.textColor = UIColor.black
            vwStarEdit.rating = Double(self.arrTutorList[filteredIndices ?? 0].Rating) ?? 0.0
            vwStarEdit.settings.updateOnTouch = true
            vwStarEdit.settings.starMargin = 1


        }
    }

}
extension TutorRatingVC{
    func api_call_tutor_rating_list()
    {
                showActivityIndicator()
        self.arrTutorList.removeAll()
       // self.SearchData.removeAll()

        // let params = [:]
        var params = ["":""]
       // var int_count = 0
        params = ["TutorID":"\(tutorId)"]

      //  btnFilter.isHidden = false
       // lblFilterCount.isHidden = false
//            Get_TutorNameBy_Criteria_Lite(string CourseTypeID, string BoardID, string CourseID, string StandardID, string SubjectID)



        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        //        print("API, Params: \n",API.Get_Course_ListApi,params)
        if !Connectivity.isConnectedToInternet() {
            //            self.AlertPopupInternet()

            // show Alert
                                       self.hideActivityIndicator()
            print("The network is not reachable")
            self.tblRatingList.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }
//        Get_TutorNameBy_Criteria_Lite(string CourseTypeID, string BoardID, string CourseID, string StandardID, string SubjectID)
        Alamofire.request(API.Get_TutorRating, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)
             //   self.arrPreferenceList.removeAll()
                if(json["Status"] == "true" || json["Status"] == "1") {


                    if let arrData = json["data"].array{
                        for (_,value) in arrData.enumerated() {

                            let objdict = arrTutorListModel(StudentID: value["StudentID"].intValue, Rating: value["Rating"].stringValue, StudentName: value["StudentName"].stringValue, Remarks: value["Remarks"].stringValue, DateTime: value["DateTime"].stringValue)
                            self.arrTutorList.append(objdict)
                        }
                    }
                    let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
                    let filtered = self.arrTutorList.filter { String($0.StudentID) == "\(result["StudentID"] ?? "")" }




                    if filtered.count != 0{
                        self.btnWrite.setTitle("Edit Review", for: .normal)
                    }else{
                        self.btnWrite.setTitle("Write a Review", for: .normal)
                    }


                    self.tblRatingList.isHidden = false
                    self.lblNoDataFound.isHidden = true


                    DispatchQueue.main.async {
                        self.tblRatingList.reloadData()
                    }
                }
                else
                {
                    self.tblRatingList.isHidden = true
                    self.lblNoDataFound.isHidden = false
                    self.lblNoDataFound.text = "No Review"

                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
            }
        }
    }

    func api_Cal_submit_rating()
    {
                showActivityIndicator()
            //    self.arrTutorList.removeAll()
       // self.SearchData.removeAll()
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary

        // let params = [:]
        var params = ["":""]
       // var int_count = 0
        params = ["StudentID":"\(result["StudentID"] ?? "")","TutorID":"\(tutorId)","Remarks":txtComment.text,"Rating":"\(vwStarEdit.rating)"]

      //  btnFilter.isHidden = false
       // lblFilterCount.isHidden = false
//            Get_TutorNameBy_Criteria_Lite(string CourseTypeID, string BoardID, string CourseID, string StandardID, string SubjectID)



        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
                print("API, Params: \n",API.Insert_TutorRating,params)
        if !Connectivity.isConnectedToInternet() {
            //            self.AlertPopupInternet()

            // show Alert
                                       self.hideActivityIndicator()
            print("The network is not reachable")
          //  self.tblRatingList.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }
//        Get_TutorNameBy_Criteria_Lite(string CourseTypeID, string BoardID, string CourseID, string StandardID, string SubjectID)
        Alamofire.request(API.Insert_TutorRating, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)
             //   self.arrPreferenceList.removeAll()
                if(json["Status"] == "true" || json["Status"] == "1") {
                    self.vwStarEdit.rating = 0.0
                    self.txtComment.text = ""
                    self.vwMainPopUp.isHidden = true
                    self.api_call_tutor_rating_list()
                }
                else
                {
                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
            }
        }
    }
}
extension TutorRatingVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTutorList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "RatingCell", for: indexPath) as! RatingCell

        cell.vwStarTutor.rating = Double(self.arrTutorList[indexPath.row].Rating) ?? 0.0
        cell.vwStarTutor.settings.updateOnTouch = false
        cell.vwStarTutor.settings.starMargin = 1

        cell.vwStarTutor.backgroundColor = .clear

        cell.lblMsg.text = self.arrTutorList[indexPath.row].Remarks
        cell.lblDate.text = self.arrTutorList[indexPath.row].DateTime
        cell.lblUserName.text = self.arrTutorList[indexPath.row].StudentName

        let str = self.arrTutorList[indexPath.row].StudentName.uppercased()

        cell.lblUname.text = String(str.prefix(1))
        cell.lblUname.backgroundColor = .clear

        cell.lblUname.backgroundColor = GetColor.themeBlueColor

        cell.lblUname.layer.cornerRadius = cell.lblUname.frame.height/2
        cell.lblUname.layer.masksToBounds = true


        cell.selectionStyle  = .none

        return cell
    }


    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}
