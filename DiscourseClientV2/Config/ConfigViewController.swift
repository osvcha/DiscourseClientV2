//
//  ConfigViewController.swift
//  DiscourseClientV2
//
//  Created by Osvaldo Chaparro on 21/03/2021.
//

import UIKit

class ConfigViewController: UIViewController {
    
    
    private let usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        usernameLabel.textColor = .blackColorOfLabels
        usernameLabel.text = "Nombre de usuario"
        return usernameLabel
    }()
    
    lazy var usernameField: UITextField = {
        let usernameField = UITextField()
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        usernameField.borderStyle = .line
        return usernameField
    }()
    
    private let apikeyLabel: UILabel = {
        let apikeyLabel = UILabel()
        apikeyLabel.translatesAutoresizingMaskIntoConstraints = false
        apikeyLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        apikeyLabel.textColor = .blackColorOfLabels
        apikeyLabel.text = "API KEY"
        return apikeyLabel
    }()
    
    lazy var apikeyField: UITextField = {
        let apikeyField = UITextField()
        apikeyField.translatesAutoresizingMaskIntoConstraints = false
        apikeyField.borderStyle = .line
        return apikeyField
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.tangerine, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var configStackView: UIStackView = {
        let configStackView = UIStackView(arrangedSubviews: [usernameLabel, usernameField, apikeyLabel, apikeyField, submitButton])
        configStackView.translatesAutoresizingMaskIntoConstraints = false
        configStackView.axis = .vertical
        configStackView.alignment = .leading
        configStackView.distribution = .equalSpacing
        configStackView.spacing = 8
        return configStackView
    }()
    
    let viewModel: ConfigViewModel
    
    init(viewModel: ConfigViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        configureTheView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }
    
    func configureTheView() {
        //background
        view.backgroundColor = .fondoClaro
        
        //vistas
        view.addSubview(configStackView)
        
        //constraints
        NSLayoutConstraint.activate([
            usernameField.widthAnchor.constraint(equalToConstant: 200),
            apikeyField.widthAnchor.constraint(equalToConstant: 200),
            
            configStackView.widthAnchor.constraint(equalToConstant: 200),
            configStackView.heightAnchor.constraint(equalToConstant: 200),
            configStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            configStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        //Nav Bar
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.backgroundColor = .fondoClaro
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        
    }
    
    fileprivate func updateUI() {
        usernameField.text = viewModel.usernameLabelText
        apikeyField.text = viewModel.apikeyLabelText
    }
    
    @objc func submitButtonTapped() {
        viewModel.submitButtonTapped(username: usernameField.text ?? "", apikey: apikeyField.text ?? "")
    }
}

extension ConfigViewController: ConfigViewDelegate {
    func configDataFetched() {
        updateUI()
    }
    
    
}
