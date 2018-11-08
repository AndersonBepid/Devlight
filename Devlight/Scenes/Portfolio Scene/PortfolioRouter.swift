//
//  PortfolioRouter.swift
//  Devlight
//
//  Created by Anderson Oliveira on 08/11/18.
//  Copyright (c) 2018 Anderson Oliveira. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//  https://github.com/HelmMobile/clean-swift-templates

import UIKit

protocol PortfolioRouterInput {
    
}

protocol PortfolioRouterDataSource: class {
    
}

protocol PortfolioRouterDataDestination: class {
    
}

class PortfolioRouter: PortfolioRouterInput {
    
    weak var viewController: PortfolioViewController!
    weak private var dataSource: PortfolioRouterDataSource!
    weak var dataDestination: PortfolioRouterDataDestination!
    
    init(viewController: PortfolioViewController, dataSource: PortfolioRouterDataSource, dataDestination: PortfolioRouterDataDestination) {
        self.viewController = viewController
        self.dataSource = dataSource
        self.dataDestination = dataDestination
    }
    
    // MARK: Navigation
    
    // MARK: Communication
    
    func passDataToNextScene(for segue: UIStoryboardSegue) {
        // NOTE: Teach the router which scenes it can communicate with
        
    }
}