//
//  SignUpViewController.swift
//  DaWordUp
//
//  Created by Dameion on 1/24/23.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore



class SignUpViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()

        
    }
    
    func setUpElements() {
        //profile picture clickable for setting profile picture
        profileImage.isUserInteractionEnabled = true
        let profGesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        profileImage.addGestureRecognizer(profGesture)
        
        //hiding error label
        errorLabel.alpha = 0
        
        //throwing some style on'num
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)

        Utilities.styleFilledButton(signUpButton)
        
        
        //profileImage.layer.masksToBounds = true
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        
        
    }
    
    //this is validating if the data is correct
    func validateFields() -> String? {
        
        //checks if all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
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

    @objc func didTapChangeProfilePic(){ //bringing up the picture selector and camera
        presentPhotoActionSheet()
    }
 
    @IBAction func signUpTapped(_ sender: Any){
        //validate fields
        let error = validateFields()
        if error != nil {
            //there's something wrong with the fields
            showError(error!)
        }
        else {
            
            
            
            
            //create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                //check for errors
                if err != nil {
                    //there was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    
                    //User created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstName":firstName, "lastName":lastName, "uid": result!.user.uid]){(error ) in
                        
                        if error != nil {
                            self.showError("error saving user data")
                        }
                    }
                }
            }
            // transition to the home screen
            self.transitionToHome()
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
    
    
}


extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Choose a time stasis unit", preferredStyle: .actionSheet)
        
        actionSheet .addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet .addAction(UIAlertAction(title: "Capture Photo", style: .default, handler: {[weak self]_ in self?.revealCamera()}))
        actionSheet .addAction(UIAlertAction(title: "Select Photo", style: .default, handler: {[weak self]_ in self?.revealPhotoSelector()}))
        
        present(actionSheet, animated: true)
    }
    
    func revealCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    func revealPhotoSelector(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.profileImage.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
