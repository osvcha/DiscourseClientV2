//
//  TopicsViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa un listado de topics
class TopicsViewController: UIViewController {
    
    private let refreshControl = UIRefreshControl()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(TopicCell.self, forCellReuseIdentifier: TopicCell.cellIdentifier)
        table.register(TopicWelcomeCell.self, forCellReuseIdentifier: TopicWelcomeCell.cellIdentifier)
        return table
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        if let imageButton = UIImage(named: "icoNew") {
            button.setImage(imageButton, for: .normal)
        }
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()

    let viewModel: TopicsViewModel

    init(viewModel: TopicsViewModel) {
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
        view.addSubview(tableView)
        view.addSubview(plusButton)
        
        tableView.layoutMargins = .zero
        tableView.separatorInset = .zero
        tableView.separatorColor = .greyColorOfLabels
                
        
        NSLayoutConstraint.activate([
            //tableview
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //plus button
            plusButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            plusButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -95),
            plusButton.widthAnchor.constraint(equalToConstant: 64),
            plusButton.heightAnchor.constraint(equalToConstant: 64),
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
        
        //Pull to refresh
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.tintColor = .tangerine
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.refreshLaunched()
    }

    @objc func plusButtonTapped() {
        viewModel.plusButtonTapped()
    }

    fileprivate func showErrorFetchingTopicsAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topics\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
}

extension TopicsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let topicCellViewModel = viewModel.viewModel(at: indexPath) as? TopicCellViewModel,
           let cell = tableView.dequeueReusableCell(withIdentifier: TopicCell.cellIdentifier, for: indexPath) as? TopicCell{
            cell.viewModel = topicCellViewModel
            return cell
        } else if let topicWelcomeCellViewModel = viewModel.viewModel(at: indexPath) as? TopicWelcomeCellViewModel,
                  let cell = tableView.dequeueReusableCell(withIdentifier: TopicWelcomeCell.cellIdentifier, for: indexPath) as? TopicWelcomeCell{
            cell.viewModel = topicWelcomeCellViewModel
            return cell
        }
    

        fatalError()
    }
}

extension TopicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let _ = viewModel.viewModel(at: indexPath) as? TopicWelcomeCellViewModel {
            return 151
        }
        
        return 96
    }
}

extension TopicsViewController: TopicsViewDelegate {
    func topicsFetched() {
        tableView.reloadData()
    }

    func errorFetchingTopics() {
        showErrorFetchingTopicsAlert()
    }
    
    func finishRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func topicsTableScrollToTop() {
        tableView.setContentOffset(CGPoint(x: 0, y: -143), animated: true)
    }
}
