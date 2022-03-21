//
//  LoginViewController.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 20.03.2022.
//

import UIKit

final class LoginViewController: BaseViewController, UITextFieldDelegate {
    let padding: CGFloat = 16
    weak var presenter: LoginPresenterInput?
    private lazy var loginTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "account"
        textField.text = "test"
        textField.customize()
        textField.returnKeyType = .done
        return textField
    }()
    
    private lazy var passwordTextField: TextField = {
        let textField = TextField()
        textField.text = "123"
        textField.placeholder = "password"
        textField.customize()
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("LOG IN", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "buttonColor")
        button.layer.cornerRadius = 7
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        return button
    }()
    
    let backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        
    }
    
    func setupUI() {
        view.backgroundColor = .white
        self.navigationItem.title = "Log in"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(self.loginTextField)
        
        loginTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        loginTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        loginTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginTextField.delegate = self
        
        view.addSubview(self.passwordTextField)
        self.passwordTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        self.passwordTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        self.passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: padding).isActive = true
        self.passwordTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        passwordTextField.delegate = self
        
        view.addSubview(self.loginButton)
        self.loginButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        self.loginButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        self.loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: padding).isActive = true
        self.loginButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.loginButton.addTarget(self, action: #selector(loginBtnPressed), for: .touchUpInside)
    
    }
    
    @objc func loginBtnPressed() {
        presenter?.loginAction(loginTextField.text, passwordTextField.text)
        print("dsdfs")
    }
}

extension LoginViewController: LoginPresenterOutput {
    func loginDidFail(_ error: LoginPresenter.DisplayFailure) {
        var titleAlert = "Ошибка"
        var textAlert = "Не известная ошибка"
        
        switch error {
        case .showAlert(let title, let message):
            titleAlert = title
            textAlert = message
        case .unownedError:
            break
        }
        
        let myAlert = UIAlertController(title: titleAlert, message: textAlert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        present(myAlert, animated: true, completion: nil)
    }
}
