//
//  LoginViewController.swift
//  Nextcloud
//
//  Created by Sebastian Pollex on 19.12.20.
//

import UIKit
import LocalAuthentication
import SwiftKeychainWrapper
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginURLTextField: UITextField!
    @IBOutlet weak var loginUsernameTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var ErrorLabel: UILabel!
    
    
    
    
    
    //@IBOutlet weak var DebugButton: UIButton!
    
    struct GlobalVariables {
        static let APIURL = "/index.php/apps/passwords/api/1.0"
    }
    
/*//  Declare Variables
    let KeyChainURL = KeychainWrapper.standard.string(forKey: "LoginURL")!
    let KeyChainUsername = KeychainWrapper.standard.string(forKey: "LoginUsername")!
    let KeyChainPassword = KeychainWrapper.standard.string(forKey: "LoginPassword")!
*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//      Proof if User has logged in before
        
        if KeychainWrapper.standard.string(forKey: "LoginURL") != nil && KeychainWrapper.standard.string(forKey: "LoginUsername") != nil && KeychainWrapper.standard.string(forKey: "LoginPassword") != nil{
//            print("Keychain is full")
            let context:LAContext = LAContext()
                
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
                context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "For secure login") { (Successfull, error) in
                        if Successfull {
                            print("Successfully logged in")
//                          If Touch/FaceID successfull, it will open the MainViewController
                            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                            let viewcontroller = storyBoard.instantiateViewController(identifier: "MainView")
                            viewcontroller.modalPresentationStyle = .fullScreen
                            self.present(viewcontroller, animated: true)
                        }
                        else{
                            print("Please try again")
                        }
                    }
            }
        }
        else{
//            print("KeyChain is emtpy")
        }
    }
    
    
        
        // Do any additional setup after loading the view
    

    
    @IBAction func loginTapped(_ sender: Any) {
        print("Button was pressed!")
        self.ErrorLabel.text = ""
        self.ErrorLabel.backgroundColor = UIColor.black.withAlphaComponent(0)
        KeychainWrapper.standard.set(loginURLTextField.text ?? "", forKey: "LoginURL")
        KeychainWrapper.standard.set(loginUsernameTextField.text ?? "", forKey: "LoginUsername")
        KeychainWrapper.standard.set(loginPasswordTextField.text ?? "", forKey: "LoginPassword")

        //      Build API Call
        let headers: HTTPHeaders = [
            .authorization(username: KeychainWrapper.standard.string(forKey: "LoginUsername")!, password: KeychainWrapper.standard.string(forKey: "LoginPassword")!),
            .accept("application/json")
        ]
        
        AF.request(KeychainWrapper.standard.string(forKey: "LoginURL")! + LoginViewController.GlobalVariables.APIURL + "/session/request", headers: headers).response { response in
//            debugPrint(response)
            let statusCode = response.response?.statusCode
            print(statusCode as Any)
            
            if statusCode != 200 {
                self.ErrorLabel.backgroundColor = UIColor.red
                self.ErrorLabel.text = "Can not sign in! Please verify if your URL, Username or Password is correct!"
            }
            else{
//
//                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//                let viewcontroller = storyBoard.instantiateViewController(identifier: "MainView")
//                viewcontroller.modalPresentationStyle = .fullScreen
//                self.present(viewcontroller, animated: true)
                self.ErrorLabel.backgroundColor = UIColor.green
                self.ErrorLabel.text = "Login successfull!"
                let mainView: UIStoryboard = UIStoryboard(name: "MainScreen", bundle: nil)
                let MainViewVC = mainView.instantiateViewController(identifier: "MainScreen") as! MainScreenViewController
                MainViewVC.modalPresentationStyle = .fullScreen
                self.present(MainViewVC, animated: false, completion: nil)
            } // End of if/else Block
            
        }// End of API Call
    } // End of Button Tap
} //End of Class
