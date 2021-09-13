//
//  SignUpViewController.swift
//  TikTok
//
//  Created by Ling Xie on 7/24/21.
//

import UIKit
import SafariServices

class SignUpViewController: UIViewController,  UITextFieldDelegate {
    
    public var completion: (() -> Void)?
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private let usernameField = AuthField(type: .username)
    
    private let emailField = AuthField(type: .email)
    
    private let passwordField = AuthField(type: .password)
    
    private let signUpButton = AuthButton(type: .signUp, title: nil)
    
    private let termsButton = AuthButton(type: .plain, title: "Terms of Service")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "CREATE ACCOUNT"
        view.addSubview(logoImageView)
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signUpButton)
        view.addSubview(termsButton)
        configureFields()
        configureButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageSize: CGFloat = 100
        logoImageView.frame = CGRect(x: (view.width - imageSize)/2, y: view.safeAreaInsets.top + 5, width: imageSize, height: imageSize)

        usernameField.frame = CGRect(x: 20, y: logoImageView.botton+20, width: view.width-40, height: 55)
        emailField.frame = CGRect(x: 20, y: usernameField.botton+15, width: view.width-40, height: 55)
        passwordField.frame = CGRect(x: 20, y: emailField.botton+15, width: view.width-40, height: 55)

        signUpButton.frame = CGRect(x: 20, y: passwordField.botton+20, width: view.width-40, height: 55)
        termsButton.frame = CGRect(x: 20, y: signUpButton.botton+40, width: view.width-40, height: 55)
    }
    
    func configureFields(){
        emailField.delegate = self
        passwordField.delegate = self
        usernameField.delegate = self
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.width, height: 50))
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapKeyboardDone))
        ]
        toolBar.sizeToFit()
        emailField.inputAccessoryView = toolBar
        passwordField.inputAccessoryView = toolBar
        usernameField.inputAccessoryView = toolBar
    }
    
    func configureButtons(){
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTerms), for: .touchUpInside)
    }
    
    @objc func didTapSignIn(){
        didTapKeyboardDone()
        guard let email = emailField.text,
              let password = passwordField.text,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6 else {

            let alert = UIAlertController(title: "Error", message: "Please enter a valid email and password to sign in.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        AuthManager.shared.signIn(with: email, password: password){ loggedIn in
            if loggedIn {
                //dismiss sign in page
            }
        }
    }
    
    @objc func didTapSignUp(){
        didTapKeyboardDone()
        
        guard let username = usernameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6,
              !username.contains(" "),
              !username.contains(".") //firebase does not like "."
              else {
            let alert = UIAlertController(title: "Oh no", message: "Please fill in username and email address. Password must be at least 6 characters long", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        AuthManager.shared.signUp(with: username, emailAddress: email, password: password){ success in
            
        }
    }
    
    @objc func didTapTerms(){
        didTapKeyboardDone()
        guard let url = URL(string: "https://www.tiktok.com/legal/terms-of-service?lang=en") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc func didTapKeyboardDone() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        usernameField.resignFirstResponder()
    }
}
