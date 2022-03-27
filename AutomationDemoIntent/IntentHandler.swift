//
//  IntentHandler.swift
//  AutomationDemoIntent
//
//  Created by Iraniya Naynesh on 27/03/22.
//

import Intents
import UIKit

class AutomationDemoHandler: NSObject {
    let application: UIApplication
    
    init(application: UIApplication) {
        self.application = application
    }
    
    func handle(intent: AppOpenIntent) {
        
    }
    
}

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
