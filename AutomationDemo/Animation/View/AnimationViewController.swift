//
//  AnimationViewController.swift
//  AutomationDemo
//
//  Created by Iraniya Naynesh on 27/03/22.
//

import UIKit


class AnimationViewController: UIViewController {

    //MARK: - UI Components
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var noteLabel: UILabel!
    
    //MARK: - Properties
    var isAnimated: Bool = false
    var oneSecViewModel: OneSecAutomationViewModel?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.detailsView.alpha = 0.0
    }

    override func viewDidAppear(_ animated: Bool) {
        
        //breathAnimation()
        animateView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        resetUI()
    }
    
    
    //MARK: - Private function
    
    private func resetUI() {
        self.detailsView.alpha = 0.0
    }
    
    //Configuration
    private func configureUI() {
        closeButton.clipsToBounds = true
        closeButton.layer.cornerRadius = 10.0
        
        
        countLabel.text = oneSecViewModel?.launchCountText
        noteLabel.text = oneSecViewModel?.noteMessage
    }
    
    
    //Top to bottom/bottom to top Animation
    private func animateView() {
        let animationView1 = UIView(frame: CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: 0))
        animationView1.backgroundColor = .green
        self.view.addSubview(animationView1)
        
        UIView.animate(withDuration: 5.0, delay: 0.5, options: UIView.AnimationOptions.curveEaseInOut) {
            let newFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            animationView1.frame = newFrame
        } completion: { success in
            self.detailsView.alpha = 1.0
            let newFrame = CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: self.view.bounds.height)
           
            UIView.animate(withDuration: 5.0, delay: 0.5, options: UIView.AnimationOptions.curveEaseInOut) {
                animationView1.frame = newFrame
            } completion: { success in
                animationView1.removeFromSuperview()
            }
        }
    }
    
    
    //For breath Animation
    
    var animationView: UIView?
    
    private func breathAnimation() {
        animationView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        self.view.addSubview(animationView!)
        
        let breatheView: BreatheView!
        breatheView = BreatheView(frame: animationView!.frame)
        
        animationView!.addSubview(breatheView)
        breatheView.translatesAutoresizingMaskIntoConstraints = true
        breatheView.center = CGPoint(x: animationView!.bounds.midX, y: animationView!.bounds.midY)
        breatheView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        
        breatheView.startAnimations()
        breatheView.delegate = self
    }
    
    
    @IBAction func closeButtonTapped() {
        print("closeButtonTapped")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButtonTapped() {
        print("continueButtonTapped")
        if let urlScheme = oneSecViewModel?.navigationUrl {
            if UIApplication.shared.canOpenURL(urlScheme) {
                UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
            }
        }
    }
}

extension AnimationViewController: BreatheViewDelegate {
    func didCompletedAnimation() {
        animationView?.removeFromSuperview()
        
        animateView()
    }
}
