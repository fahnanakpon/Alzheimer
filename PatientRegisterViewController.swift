//
//  PatientRegisterViewController.swift
//  Alzheimer
//
//  Created by Fahn on 4/21/16.
//  Copyright © 2016 Fahn. All rights reserved.
//

import UIKit

class PatientRegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var namePTF: UITextField!
    @IBOutlet weak var lastnamePTF: UITextField!
    @IBOutlet weak var citenzenidPTF: UITextField!
    @IBOutlet weak var bloodtypePTF: UITextField!
    @IBOutlet weak var diseasePTF: UITextField!
    @IBOutlet weak var heightPTF: UITextField!
    @IBOutlet weak var birthdatePTF: UITextField!
    
    @IBAction func patientSubmitButton(sender: UIButton) {
    }

}
