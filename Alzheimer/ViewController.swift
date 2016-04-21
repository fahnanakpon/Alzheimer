import UIKit

class ViewController: UIViewController, UITextFieldDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBAction func loginButton(sender: UIButton) {
        //Action เข้าสู่ระบบ นำช่อง User&Pass เช็คว่ากรอกครบรึป่าวถ้าครบก็ส่งไปเช็คกับฐานข้อมูล
        
        let username: NSString = usernameTF.text!
        let password: NSString = passwordTF.text!
        
        if ( username.isEqualToString("") || password.isEqualToString("") ) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "การเข้าสู่ระบบไม่สำเร็จ!"
            alertView.message = "กรุณาใส่ชื่อผู้ใช้และรหัสผ่าน"
            alertView.delegate = self
            alertView.addButtonWithTitle("ตกลง")
            alertView.show()
            
        }else {
            
            do {
                let post:NSString = "username=\(username)&password=\(password)"
                
                NSLog("PostData: %@",post);
                
                let url:NSURL = NSURL(string:"https://www.surasak.io/alz/api/ios/auth.php")!
                
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
                            NSLog("Login SUCCESS");
                            
                            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                            prefs.setObject(username, forKey: "USERNAME")
                            prefs.setInteger(1, forKey: "ISLOGGEDIN")
                            prefs.synchronize()
                    
                            //let vc = MainPageViewController(nibName: nil, bundle: nil)
                            //self.presentViewController(vc, animated: true, completion: nil)
                        
                            
                            
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = "เข้าสู่ระบบสำเร็จ!"
                            alertView.message = ""
                            alertView.delegate = self
                            alertView.addButtonWithTitle("ตกลง")
                            alertView.show()
                            //เคลียร์ช่อง text เมื่อเข้าสู่ระบบแล้วกดกลับมาให้เป็นช่องว่าง
                            usernameTF.text = ("")
                            passwordTF.text = ("")
                        
                            
                        } else {
                            var error_msg:NSString
                            
                            if jsonData["error_message"] as? NSString != nil {
                                error_msg = jsonData["error_message"] as! NSString
                            } else {
                                error_msg = "Unknown Error"
                            }
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = "การเข้าสู่ระบบผิดพลาด!"
                            alertView.message = error_msg as String
                            alertView.delegate = self
                            alertView.addButtonWithTitle("ตกลง")
                            alertView.show()
                            
                        }
                        
                    } else {
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign in Failed!"
                        alertView.message = "Connection Failed"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                    }
                } else {
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
                alertView.title = "Sign in Failed!"
                alertView.message = "Server Error"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        }
    }

    
    func transition(Sender: UIButton!) {
        let secondViewController:MainPageViewController = MainPageViewController()
        
        self.presentViewController(secondViewController, animated: false, completion: nil)
    }
    
    
    // function ใช้ซ่อนคีย์บอร์ดเมื่อกด return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        
        return true
    }
    
    // function ใช้ซ่อนคีย์บอร์ดเวลาแตะที่อื่นของหน้าจอ
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        usernameTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
    }
}