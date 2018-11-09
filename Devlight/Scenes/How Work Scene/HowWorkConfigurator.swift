//
//  HowWorkConfigurator.swift
//  Devlight
//
//  Created by Anderson Oliveira on 09/11/18.
//  Copyright (c) 2018 Anderson Oliveira. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//  https://github.com/HelmMobile/clean-swift-templates

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension HowWorkInteractor: HowWorkViewControllerOutput, HowWorkRouterDataSource, HowWorkRouterDataDestination {
}

extension HowWorkPresenter: HowWorkInteractorOutput {
}

class HowWorkConfigurator {
    // MARK: Object lifecycle
    
    static let sharedInstance = HowWorkConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: HowWorkViewController) {
        
        let presenter = HowWorkPresenter()
        presenter.output = viewController
        
        let interactor = HowWorkInteractor()
        interactor.output = presenter
        
        let router = HowWorkRouter(viewController: viewController, dataSource: interactor, dataDestination: interactor)
        
        viewController.output = interactor
        viewController.router = router
    }
}
