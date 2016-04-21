//
//  RegisterViewController.swift
//  Alzheimer
//
//  Created by Fahn on 4/8/16.
//  Copyright © 2016 Fahn. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var usernameRTF: UITextField!
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
        
        if ( email.isEqualToString("") || password.isEqualToString("") || repassword.isEqualToString("") ) {
            
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameRTF.resignFirstResponder()
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
    
    // function ใช้ซ่อนคีย์บอร์ดเวลาแตะที่อื่นของหน้าจอ
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        usernameRTF.resignFirstResponder()
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

}
