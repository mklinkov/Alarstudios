//
//  LoginViewController.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 20.03.2022.
//

import UIKit

final class LoginViewController: BaseViewController, UITextFieldDelegate {
    let padding: CGFloat = 16
    var presenter: LoginPresenterInput?
    private lazy var loginTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "account"
        textField.customize()
        textField.returnKeyType = .done
        return textField
    }()
    
    private lazy var passwordTextField: TextField = {
        let textField = TextField()
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
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(self.loginTextField)
        
        NSLayoutConstraint.activate([
            loginTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                 constant: padding),
            loginTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                                  constant: -padding),
            loginTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                constant: padding),
            loginTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        loginTextField.delegate = self
        
        view.addSubview(self.passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                    constant: padding),
            passwordTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                                     constant: -padding),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor,
                                                   constant: padding),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
        passwordTextField.delegate = self
        
        view.addSubview(self.loginButton)
        NSLayoutConstraint.activate([
            loginButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                              constant: padding),
            loginButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                               constant: -padding),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
                                             constant: padding),
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        self.loginButton.addTarget(self, action: #selector(loginBtnPressed), for: .touchUpInside)
        
    }
    
    @objc func loginBtnPressed() {
        presenter?.loginAction(loginTextField.text, passwordTextField.text)
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
        
        shoAlert(titleAlert, textAlert)
    }
}
