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
