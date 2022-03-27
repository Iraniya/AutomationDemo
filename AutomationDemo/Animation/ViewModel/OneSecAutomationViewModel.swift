//
//  OneSecAutomationViewModel.swift
//  AutomationDemo
//
//  Created by Iraniya Naynesh on 28/03/22.
//

import Foundation

enum SupportedApp: String {
    case instagram = "Instagram"
    case twitter = "Twitter"
}

struct Constants {
    static let userDetailsKey = "userDetailsKey"
    static let currentAppName = "currentAppName"
}

class OneSecAutomationViewModel {
    let oneSecModel: OneSecModel
    
    init(oneSecModel: OneSecModel) {
        self.oneSecModel = oneSecModel
    }
    
    var launchCountText: String {
        return "\(oneSecModel.launchCount ?? 1)"
    }
    
    var noteMessage: String {
        return "Attempts to open \(oneSecModel.appName?.rawValue ?? "") today."
    }
    
    var navigationUrl: URL? {
        switch oneSecModel.appName {
        case .instagram:
            if let urlScheme = URL(string: "instagram://") { return urlScheme }
            return nil
        case .twitter:
            if let urlScheme = URL(string: "twitter://") { return urlScheme }
            return nil
        
        default:
            return nil
        }
    }
}
