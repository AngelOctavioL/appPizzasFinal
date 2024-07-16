//
//  AuthenticationViewController.swift
//  PizzasAppOne
//
//  Created by Angel Octavio Lopez Cruz on 15/07/24.
//

import UIKit
import LocalAuthentication

class AuthenticationViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        isModalInPresentation = true
        view.backgroundColor = .systemBackground
        
        let containerStackView = UIStackView()
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.axis = .vertical
        containerStackView.spacing = 8
        
        let authenticationLabel = UILabel()
        authenticationLabel.translatesAutoresizingMaskIntoConstraints = false
        authenticationLabel.text = "please authenticat to view the favorite pokemon"
        authenticationLabel.adjustsFontForContentSizeCategory = true
        authenticationLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        authenticationLabel.numberOfLines = 0
        
        var authenticationButtonConfiguration = UIButton.Configuration.filled()
        authenticationButtonConfiguration.title = "Authenticate"

       let authenticationButton = UIButton(configuration: authenticationButtonConfiguration)
        authenticationButton.translatesAutoresizingMaskIntoConstraints = false
        authenticationButton.addTarget(self, action: #selector(authenticateButtonTapped), for: .touchUpInside)
        
        view.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(authenticationLabel)
        containerStackView.addArrangedSubview(authenticationButton)
        
        NSLayoutConstraint.activate([
            containerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc
    private func authenticateButtonTapped() {
        let context = LAContext()
        
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "we need to verify iy's you"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                success, error in
                
                if success {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                }
            }
        }
    }
}
