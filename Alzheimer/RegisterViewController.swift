import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate {
    
    //var kbHeight: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordRTF.delegate = self // ใช้ร่วมกับฟังก์ชัน textField
        
        //เลื่อนวิวขึ้นเมื่อพิมพ์คีย์บอร์ด 2
        /*
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RegisterViewController.keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RegisterViewController.keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
        */
 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var imagePicked: UIImageView!
    
    
    //สร้าง alertView
    @IBAction func openPhotoLibraryButton(sender: AnyObject) {
        let alertView = UIAlertView(title: "เลือกรูป", message: "โปรดเลือกว่าต้องการถ่ายรูปใหม่จากกล้องหรือใช้รูปที่มีอยู่ในอัลบั้ม", delegate: self, cancelButtonTitle: "กล้อง", otherButtonTitles: "อัลบั้ม")
        
        alertView.tag = 1
        
        alertView.show()
    }
    
    //กำหนดค่าให้ตัวเลือกของ alertView
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 1 {
            //ถ้ากด ถ่ายรูปจากกล้อง
            if buttonIndex == 0 {
                print("ผู้ใช้กด ถ่ายรูปจากกล้อง")
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                    var imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
                    imagePicker.allowsEditing = false
                    self.presentViewController(imagePicker, animated: true, completion: nil)
                }
                
            }
            //ถ้ากด เลือกรูปจากอัลบั้ม
            else {
                print("ผู้ใช้กด เลือกรูปจากอัลบั้ม")
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                    var imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
                    imagePicker.allowsEditing = true
                    self.presentViewController(imagePicker, animated: true, completion: nil)
                }
            }
        }
    }
    
    //เอารูปที่เลือก ใส่ลงใน  imageView
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imagePicked.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    
    
    //กำหนดว่า text field แต่ละช่องสามารถใส่อักษรได้ไม่เกินกี่ตัวบ้าง
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newLength = textField.text!.characters.count + string.characters.count - range.length
        if textField == passwordRTF {
            return newLength <= 15 // Bool
        } else if textField == repasswordRTF {
            return newLength <= 15 // Bool
        } else if textField == firstmobilenoRTF {
            return newLength <= 10 // Bool
        } else if textField == secondmobilenoRTF {
            return newLength <= 10 // Bool
        }
        
        return true
    }
    
    /*func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool
    {
        let maxLength = 15
        //let minLength = 4
        let currentString: NSString = textField.text!
        let newString: NSString =
            currentString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength //&& newString.length >= minLength
    }*/
    
    @IBOutlet weak var passwordRTF: UITextField!
    @IBOutlet weak var repasswordRTF: UITextField!
    @IBOutlet weak var nameRTF: UITextField!
    @IBOutlet weak var lastnameRTF: UITextField!
    @IBOutlet weak var firstmobilenoRTF: UITextField!
    @IBOutlet weak var secondmobilenoRTF: UITextField!
    @IBOutlet weak var housenoRTF: UITextField!
    @IBOutlet weak var streetRTF: UITextField!
    @IBOutlet weak var subdistrictRTF: UITextField!
    @IBOutlet weak var districtRTF: UITextField!
    @IBOutlet weak var provinceRTF: UITextField!
    @IBOutlet weak var emailRTF: UITextField!
    @IBOutlet weak var lineidRTF: UITextField!
    
    @IBAction func registerButton(sender: UIButton) {
        
        let password: NSString = passwordRTF.text!
        let repassword: NSString = repasswordRTF.text!
        let name: NSString = nameRTF.text!
        let lastname: NSString = lastnameRTF.text!
        let firstmobileno: NSString = firstmobilenoRTF.text!
        let secondmobileno: NSString = secondmobilenoRTF.text!
        let houseno: NSString = housenoRTF.text!
        let street: NSString = streetRTF.text!
        let subdistrict: NSString = subdistrictRTF.text!
        let district: NSString = districtRTF.text!
        let province: NSString = provinceRTF.text!
        let email: NSString = emailRTF.text!
        let lineid: NSString = lineidRTF.text!
        
        
        
        if ( email.isEqualToString("") || password.isEqualToString("") || repassword.isEqualToString("") || name.isEqualToString("") || lastname.isEqualToString("")) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "การสมัครสมาชิกไม่สำเร็จ!"
            alertView.message = "กรุณากรอกข้อมูลให้ครบถ้วน"
            alertView.delegate = self
            alertView.addButtonWithTitle("ตกลง")
            alertView.show()
            
        } else if ( !password.isEqual(repassword) ) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "การสมัครสมาชิกไม่สำเร็จ!"
            alertView.message = "รหัสผ่านที่ใส่ไม่ตรงกัน"
            alertView.delegate = self
            alertView.addButtonWithTitle("ตกลง")
            alertView.show()
        }else {
            do {
                
                let post:NSString = "sEmail=\(email)&sPassword=\(password)&sFirstname=\(name)&sLastname=\(lastname)&sFirstMobileNo=\(firstmobileno)&sSecondMobileNo=\(secondmobileno)&sHouseNo=\(houseno)&sStreet=\(street)&sSubdistrict=\(subdistrict)&sDistrict=\(district)&sProvince=\(province)&sLineID=\(lineid)"
                
                NSLog("PostData: %@",post);
                
                let url:NSURL = NSURL(string: "https://www.surasak.io/alz/api/ios/register.php")!
                
                let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
                
                let postLength:NSString = String( postData.length )
                
                let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
                request.HTTPMethod = "POST"
                request.HTTPBody = postData
                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                
                
                var reponseError: NSError?
                var response: NSURLResponse?
                
                var urlData: NSData?
                do {
                    urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
                } catch let error as NSError {
                    reponseError = error
                    urlData = nil
                }
                
                if ( urlData != nil ) {
                    let res = response as! NSHTTPURLResponse!;
                    
                    NSLog("Response code: %ld", res.statusCode);
                    
                    if (res.statusCode >= 200 && res.statusCode < 300)
                    {
                        let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                        
                        NSLog("Response ==> %@", responseData);
                        
                        //var error: NSError?
                        
                        let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                        
                        
                        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                        
                        //[jsonData[@"success"] integerValue];
                        
                        NSLog("Success: %ld", success);
                        
                        if(success == 1)
                        {
                            NSLog("Sign Up SUCCESS");
                            
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = "สมัครสมาชิกสำเร็จ!"
                            alertView.message = ""
                            alertView.delegate = self
                            alertView.addButtonWithTitle("ตกลง")
                            alertView.show()
                            
                            self.dismissViewControllerAnimated(true, completion: nil)
                            
                        } else {
                            var error_msg:NSString
                            
                            if jsonData["error_message"] as? NSString != nil {
                                error_msg = jsonData["error_message"] as! NSString
                            } else {
                                error_msg = "Unknown Error"
                            }
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = "Sign Up Failed!"
                            alertView.message = error_msg as String
                            alertView.delegate = self
                            alertView.addButtonWithTitle("OK")
                            alertView.show()
                            
                        }
                        
                    } else {
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign Up Failed!"
                        alertView.message = "Connection Failed"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                    }
                }  else {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign in Failed!"
                    alertView.message = "Connection Failure"
                    if let error = reponseError {
                        alertView.message = (error.localizedDescription)
                    }
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
            } catch {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign Up Failed!"
                alertView.message = "Server Error!"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        }
        
    }
    
    // function ซ่อนคีย์บอร์ดเวลากดที่อื่นนอกคีย์บอร์ด
    @IBAction func onBackround(sender: AnyObject) {
        passwordRTF.resignFirstResponder()
        repasswordRTF.resignFirstResponder()
        nameRTF.resignFirstResponder()
        lastnameRTF.resignFirstResponder()
        firstmobilenoRTF.resignFirstResponder()
        secondmobilenoRTF.resignFirstResponder()
        housenoRTF.resignFirstResponder()
        streetRTF.resignFirstResponder()
        subdistrictRTF.resignFirstResponder()
        districtRTF.resignFirstResponder()
        provinceRTF.resignFirstResponder()
        emailRTF.resignFirstResponder()
        lineidRTF.resignFirstResponder()
    }
    
    
    // function ซ่อนคีย์บอร์ดเวลากด return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        passwordRTF.resignFirstResponder()
        repasswordRTF.resignFirstResponder()
        nameRTF.resignFirstResponder()
        lastnameRTF.resignFirstResponder()
        firstmobilenoRTF.resignFirstResponder()
        secondmobilenoRTF.resignFirstResponder()
        housenoRTF.resignFirstResponder()
        streetRTF.resignFirstResponder()
        subdistrictRTF.resignFirstResponder()
        districtRTF.resignFirstResponder()
        provinceRTF.resignFirstResponder()
        emailRTF.resignFirstResponder()
        lineidRTF.resignFirstResponder()
        
        return true
    }
    
    //เลื่อนวิวขึ้นเมื่อพิมพ์คีย์บอร์ด 2
    /*
    func keyboardWillShow(notification:NSNotification) {
        adjustingHeight(true, notification: notification)
    }
    
    func keyboardWillHide(notification:NSNotification) {
        adjustingHeight(false, notification: notification)
    }
    
    func adjustingHeight(show:Bool, notification:NSNotification) {
        // 1
        var userInfo = notification.userInfo!
        // 2
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        // 3
        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        // 4
        let changeInHeight = (CGRectGetHeight(keyboardFrame) + 40) * (show ? 1 : -1)
        //5
        UIView.animateWithDuration(animationDurarion, animations: { () -> Void in
            self.bottomConstraint.constant += changeInHeight
        })
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    */
    
    //เลื่อนวิวขึ้นเมื่อพิมพ์คีย์บอร์ด 1
    /*
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                kbHeight = 100//keyboardSize.height
                self.animateTextField(true)
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.animateTextField(false)
    }
    
    func animateTextField(up: Bool) {
        var movement = (up ? -kbHeight : kbHeight)
        
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        })
    }
    */
    
    //ทำให้หน้าจอแอพเป็นแนวตั้งอย่างเดียว
    override func shouldAutorotate() -> Bool {
        return false
    }
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
 
}
