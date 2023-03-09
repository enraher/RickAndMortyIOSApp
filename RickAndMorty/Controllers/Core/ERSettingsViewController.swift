//
//  ERSettingsViewController.swift
//  RickAndMorty
//
//  Created by Enrique Ramirez Hernandez on 24/2/23.
//

import UIKit
import SwiftUI
import SafariServices

final class ERSettingsViewController: UIViewController {
    
    private var settingsView: UIHostingController<ERSettingsView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .secondarySystemBackground
        title = "Settings"
        addController()
    }
    
    private func addController() {
        let settingsView = UIHostingController(rootView: ERSettingsView(
            viewModel: ERSettingsViewViewModel(
            cellViewModels: ERSettingsOption.allCases.compactMap({
                return ERSettingsCellViewModel(type: $0) { [weak self] option in
                    self?.handleTap(option: option)
                }
            }))))
        
        addChild(settingsView)
        settingsView.didMove(toParent: self)
        view.addSubview(settingsView.view)
        settingsView.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsView.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingsView.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingsView.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        self.settingsView = settingsView
    }

    private func handleTap(option: ERSettingsOption) {
        guard Thread.current.isMainThread else {
            return
        }
        if let url = option.targetUrl {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        } else {
            toBeCompleted()
        }
    }
    
    private func toBeCompleted() {
        let alert = UIAlertController(title: "Not implemented", message: "To be completed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                break
            case .cancel:
                break
            case .destructive:
                break
            @unknown default:
                break
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
