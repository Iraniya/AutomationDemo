//
//  ViewController.swift
//  AutomationDemo
//
//  Created by Iraniya Naynesh on 27/03/22.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - UI Components
    @IBOutlet weak var testButton: UIButton!
    
    
    //MARK: - Properties
    var animationView = AnimationViewController()
    var isAnimated: Bool = false
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if !isAnimated {
            presentAnimationView()
            isAnimated = true
        }
        
    }
    
    //MARK: - Private methods
    private func presentAnimationView() {
        
        let testing: [String:String] = [Constants.currentAppName: SupportedApp.instagram.rawValue,
                       SupportedApp.instagram.rawValue: "1"]
        
        UserDefaults.standard.set(testing, forKey: Constants.userDetailsKey)
        
        if let oneSecData = UserDefaults.standard.object(forKey: Constants.userDetailsKey) as? [String : String] {
            if let currentApp = oneSecData[Constants.currentAppName] {
                if let appsOpenCount = oneSecData[currentApp],
                   let supportedApp = SupportedApp(rawValue: currentApp),
                   let appsOpenCountInt = Int(appsOpenCount) {
                    let oneSecModel = OneSecModel(appName: supportedApp, launchCount: appsOpenCountInt)
                    let vm = OneSecAutomationViewModel(oneSecModel: oneSecModel)
                    animationView.oneSecViewModel = vm
                    animationView.modalPresentationStyle = .fullScreen
                    self.present(animationView, animated: true)
                }
            }
        }
    }
    
    
    //MARK: - Actions
    @IBAction func presentButton() {
        presentAnimationView()
    }

}

