//
//  LoginViewController.swift
//  DaWordUp
//
//  Created by Dameion on 1/24/23.
//

import UIKit
import FirebaseAuth
import Firebase
import JGProgressHUD

class LoginViewController: UIViewController {
    
    private let spinner = JGProgressHUD(style: .dark)
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBOutlet weak var backButton: UIButton!
    
    // maybe ill add the functionality of being able to login after the user hits enter on the key pad https://www.youtube.com/watch?v=g7ipElQVpgU 29:00

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        
        //making error label invisible
        errorLabel.alpha = 0
        
        //stylin on dem Elements, hommie!
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        
        Utilities.styleFilledButton(loginButton)
        
    }

    func validateFields() -> String? {
        
        //checks if all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        //checks if its secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        if (Utilities.isPasswordValid(cleanedPassword) == false){
            
            return "Please make sure your password is at least 8 characters, contains special character and a number. "
            
        }
        
        return nil
        
    }
    
    var deeznutz = 0
    @IBAction func loginTapped(_ sender: Any) {
        //validate fields
        let error = validateFields()
        if error != nil {
            //there's something wrong with the fields
            showError(error!)
        }
        else {
            
            //create cleaned versions of the data
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //stop failing the signin
            
            spinner.show(in: view)
            // sign in the user
                FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                
                    DispatchQueue.main.async {
                        self.spinner.dismiss()
                    }
                //check for errors
                if err != nil {
                    
                    self.deeznutz += 1
                    //couldn't sign in
                    switch self.deeznutz {
                    case 1:
                        self.showError("That name's not on the list")
                    case 2:
                        self.showError("The name's NOT on the list")
                    case 3:
                        self.showError("What are you doing?")
                    case 4...6:
                        self.showError("Stop It!")
                    case 7...10:
                        self.showError("Security is on its way")
                    case 11:
                        self.showError("Do it one more time.. see what happens")
                    case 12:
                        self.transitionToSignUp()
                    default:
                        self.showError("Try it again")
                    }
                }
                    
                else {
                    let user = result!.user
                    print("Logged in User: \(user)")
                    
                    self.navigationController?.dismiss(animated: true, completion: nil)
                    // transition to the home screen
                    self.transitionToHome()
                    
                }
            }
        }
    }
    
    func showError(_ message: String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome(){
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    func transitionToSignUp(){
        
        let signUpViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.signUpViewController) as? SignUpViewController
        
        view.window?.rootViewController = signUpViewController
        view.window?.makeKeyAndVisible()
        
    }
    

}
