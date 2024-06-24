//
//  LoginViewController.swift
//  PENN Code Challenge
//
//  Created by Tyler Edlin on 6/23/24.
//

import UIKit
import FirebaseAuth
import Combine

class LoginViewController: UIViewController {
    enum Login {
        case signIn
        case signUp
    }
    
    @IBOutlet weak var loginCard: CustomView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var primaryButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var accessoryButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var emailIsEmpty = true
    var passwordIsEmpty = true
    private var tokens: Set<AnyCancellable> = []
    
    var status: Login = .signUp {
        didSet {
            updateUIForStatus()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.setupUI()
        }
        checkIfLoggedIn()
    }
    
    private func setupUI() {
        animateLoginCard()
        setupTextFieldPublishers()
    }
    
    private func animateLoginCard() {
        guard let loginCard = loginCard else {
            print("loginCard is not connected")
            return
        }
        
        loginCard.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        loginCard.alpha = 0
        
        UIView.animate(withDuration: 0.6,
                       delay: 0.2,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
            self.loginCard.transform = CGAffineTransform.identity
            self.loginCard.alpha = 1
        }, completion: nil)
    }
    
    private func setupTextFieldPublishers() {
        emailTextField.publisher(for: \.text)
            .sink { [weak self] newValue in
                self?.emailIsEmpty = newValue?.isEmpty ?? true
            }
            .store(in: &tokens)
        
        passwordTextField.publisher(for: \.text)
            .sink { [weak self] newValue in
                self?.passwordIsEmpty = newValue?.isEmpty ?? true
            }
            .store(in: &tokens)
    }
    
    private func updateUIForStatus() {
        if status == .signIn {
            titleLabel.text = "Sign in"
            primaryButton.setTitle("Sign In", for: .normal)
            accessoryButton.setTitle("Don't have an account?", for: .normal)
            passwordTextField.textContentType = .password
        } else {
            titleLabel.text = "Sign up"
            primaryButton.setTitle("Create Account", for: .normal)
            accessoryButton.setTitle("Already have an account?", for: .normal)
            passwordTextField.textContentType = .newPassword
        }
    }
    
    @IBAction func primaryButtonAction(_ sender: Any) {
        print("Primary button action triggered")
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        guard !email.isEmpty, !password.isEmpty else {
            presentAlert(title: "Missing Information", message: "Please make sure to enter a valid email and password")
            return
        }
        
        if status == .signIn {
            signInUser(email: email, password: password)
        } else {
            checkEmailExistsAndCreateUser(email: email, password: password)
        }
    }
    
    private func signInUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.presentAlert(title: "Sign In Error", message: error.localizedDescription)
            } else {
                self?.goToHomeScreen()
            }
        }
    }
    
    private func checkEmailExistsAndCreateUser(email: String, password: String) {
        Auth.auth().fetchSignInMethods(forEmail: email) { [weak self] signInMethods, error in
            if let error = error {
                print("Error fetching sign in methods: \(error.localizedDescription)")
                return
            }
            
            if let signInMethods = signInMethods, !signInMethods.isEmpty {
                self?.presentAlert(title: "Email Exists", message: "The email is already registered. Please sign in.")
            } else {
                self?.createUser(email: email, password: password)
            }
        }
    }
    
    private func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.presentAlert(title: "Sign Up Error", message: error.localizedDescription)
            } else {
                self?.signInUser(email: email, password: password)
            }
        }
    }
    
    @IBAction func accessoryButtonAction(_ sender: Any) {
        status = (status == .signIn) ? .signUp : .signIn
    }
    
    private func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func checkIfLoggedIn() {
        if Auth.auth().currentUser != nil {
            goToHomeScreen()
        }
    }
    
    private func goToHomeScreen() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! CustomTabBarViewController
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
