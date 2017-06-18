//
//  ViewController.swift
//  naverPractice
//
//  Created by Minwoo Park on 6/18/17.
//  Copyright © 2017 MWdev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginID: UITextField!
    @IBOutlet weak var loginPW: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginPW.text! = ""
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        
        if checking(for: loginID.text!, for: loginPW.text!) {
    
                responseFromServer(for: loginID.text!, for: loginPW.text!)
            
        }
        
    }
    
    
    func checking(for email: String, for pw: String) -> Bool{
        
        if loginID.text!.isEmpty || loginPW.text!.isEmpty {
        
            loginID.attributedPlaceholder = NSAttributedString(string: "userID@email.com", attributes: [NSForegroundColorAttributeName:UIColor.red])
            loginPW.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName:UIColor.red])
            
            
            let alertController = UIAlertController(title: "Login Error", message:
                "No empty entries allowed", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return false
        }
        
       return true
    }
    
    func responseFromServer(for email: String, for pw: String) {
        
        let email = loginID.text!
        let pw = loginPW.text!
        let urlString = "http://cgi.soic.indiana.edu/~team40/iosLogin.php?EmailAddress=\(email)&Password=\(pw)"
        //print(urlString)
        let loginURL = URL(string: urlString)!
        let request = URLRequest(url: loginURL)
        
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            
            func displayError(_ error: String) {
                print(error)
                print("URL at time of error: \(loginURL)")
                
            }
            if error == nil {
                if let data = data {
                    
                    let parsedResult: [String : String]!
                    do{
                        parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:String]
                    } catch {
                        displayError("Could not parse the data as JSON: '\(data)'")
                        return
                    }
                    if parsedResult["message"] == "Incorrect Password" {
                       
                        
                        performUIUpdatesOnMain{
                            
                            let alertController = UIAlertController(title: "Login Error", message:
                                "Incorrect Password", preferredStyle:.alert)
                            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                        }
                        
                        
                        
                    }
                    else if parsedResult["message"] == "Email Address does not exist." {
                        
                        
                        performUIUpdatesOnMain {
                            
                            let alertController = UIAlertController(title: "Login Error", message:
                                "Email Does not Exist", preferredStyle:.alert)
                            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                            self.present(alertController, animated: true, completion: nil)
                        }
                        
                    }
                        else {
                        performUIUpdatesOnMain {
                            self.performSegue(withIdentifier: "loginButton", sender: self.loginID.text!)
                        }
                    }
                    
                }
            
            }
        }
        task.resume()
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginButton" {
            let nextVC = segue.destination as! SecondViewController
            let sendingID = sender as! String
            nextVC.loginID = sendingID
            
        
        }
    }

}

