//
//  SignInViewController.swift
//  TikTok
//
//  Created by Ling Xie on 7/24/21.
//

import UIKit
import SafariServices

class SignInViewController: UIViewController, UITextFieldDelegate {

    public var completion: (() -> Void)?
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private let emailField = AuthField(type: .email)
    
    private let passwordField = AuthField(type: .password)
    
    private let signInButton = AuthButton(type: .signIn, title: nil)
    
    private let forgotPasswordButton = AuthButton(type: .plain, title: "Forgot Password")
    
    private let signUpButton = AuthButton(type: .plain, title: "Create Account")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "SIGN IN"
        view.addSubview(logoImageView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.addSubview(forgotPasswordButton)
        configureFields()
        configureButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageSize: CGFloat = 100
        logoImageView.frame = CGRect(x: (view.width - imageSize)/2, y: view.safeAreaInsets.top + 5, width: imageSize, height: imageSize)

        emailField.frame = CGRect(x: 20, y: logoImageView.botton + 20, width: view.width - 40, height: 55)
        passwordField.frame = CGRect(x: 20, y: emailField.botton + 15, width: view.width - 40, height: 55)

        signInButton.frame = CGRect(x: 20, y: passwordField.botton + 20, width: view.width - 40, height: 55)
        forgotPasswordButton.frame = CGRect(x: 20, y: signInButton.botton + 40, width: view.width - 40, height: 55)
        signUpButton.frame = CGRect(x: 20, y: forgotPasswordButton.botton + 20, width: view.width - 40, height: 55)
    }
    
    func configureFields(){
        emailField.delegate = self
        passwordField.delegate = self
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.width, height: 50))
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapKeyboardDone))
        ]
        toolBar.sizeToFit()
        emailField.inputAccessoryView = toolBar
        passwordField.inputAccessoryView = toolBar
    }
    
    func configureButtons(){
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
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
        
        AuthManager.shared.signIn(with: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    HapticsManager.shared.vibrate(for: .success)
                    self?.dismiss(animated: true, completion: nil)

                case .failure:
                    HapticsManager.shared.vibrate(for: .error)
                    let alert = UIAlertController(
                        title: "Sign In Failed",
                        message: "Please check your email and password to try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self?.present(alert, animated: true)
                    self?.passwordField.text = nil
                }
            }
        }
    }
    
    @objc func didTapSignUp(){
        didTapKeyboardDone()
        let vc = SignUpViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapForgotPassword(){
        didTapKeyboardDone()
        guard let url = URL(string: "https://support.tiktok.com/en/log-in-troubleshoot/log-in/reset-password") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc func didTapKeyboardDone() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
}
