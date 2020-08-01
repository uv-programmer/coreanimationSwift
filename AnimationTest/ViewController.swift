//
//  ViewController.swift
//  AnimationTest
//
//  Created by macOS on 30/07/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIViewControllerTransitioningDelegate  {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var ironManImageView: UIImageView!
    
      var circleAnimator: CircleAnimator?
    override func viewDidLoad() {
        super.viewDidLoad()

         self.ironManImageView.transform = CGAffineTransform(translationX: 0, y: -1000 )
        //Button Setup
        
        loginButton.backgroundColor = UIColor(red: 194/255, green: 30/255, blue: 85/255, alpha: 1.0)
        // Shadow and Radius
        loginButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        loginButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        loginButton.layer.shadowOpacity = 1.0
        loginButton.layer.shadowRadius = 0.0
        loginButton.layer.masksToBounds = false
        loginButton.layer.cornerRadius = 4.0
        
        signUpButton.backgroundColor = UIColor(red: 194/255, green: 30/255, blue: 85/255, alpha: 1.0)
               // Shadow and Radius
               signUpButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
               signUpButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
               signUpButton.layer.shadowOpacity = 1.0
               signUpButton.layer.shadowRadius = 0.0
               signUpButton.layer.masksToBounds = false
               signUpButton.layer.cornerRadius = 4.0
        animateIronman()
                 flyIronman()
      //  #colorLiteral(red: 0.7607843137, green: 0.1176470588, blue: 0.3333333333, alpha: 1)
        // Do any additional setup after loading the view.
        
        
  
          
    
          
   
      
        }
    
    @IBAction func ping(_ sender: Any) {
        flyIronman()
    }
    
    
    @IBAction func loginBtnAction(_ sender: Any) {
        animateButtonOpacity()
       
        
        guard let buttonVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController,
                     let senderButton = sender as? UIButton else { return }
                           self.loginButton = senderButton
                  buttonVC.transitioningDelegate = self
                  buttonVC.modalPresentationStyle = .custom
                  self.present(buttonVC, animated: true, completion: nil)
        
    }
    
    
    @IBAction func signUpAction(_ sender: Any) {
        flyAway()
       
    }
    
    func animateButtonOpacity(){
        
        loginButton.layer.opacity = 0.0
        UIView.animate(withDuration:0.5){
            self.loginButton.layer.opacity = 0.8
        }
        
    }
    
    
    func flyIronman() {
        UIView.animate(withDuration: 1.0, delay: 0.0 , options: .curveEaseIn, animations:  {
            self.ironManImageView.transform = CGAffineTransform.identity
        })
    }
    
    func flyAway() {
          UIView.animate(withDuration: 1.0, delay: 0.0 , options: .curveEaseIn, animations:  {
              self.ironManImageView.transform = CGAffineTransform(translationX: 0, y: -1000 )
          })
      }
    
    
    
        
        
        private func animateIronman() {
            let options: UIView.AnimationOptions = [.curveEaseInOut,
                                                    .repeat,
                                                    .autoreverse]
            
            UIView.animate(withDuration: 2.9,
                           delay: 0,
                           options: options,
                           animations: { [weak self] in
                            self?.ironManImageView.frame.size.height *= 1.18
                            self?.ironManImageView.frame.size.width *= 1.18
            }, completion: nil)
        
        
        
        
        
        
    }

    
    
    
    
    
    // MARK:- UIViewControllerTrasitioningDelegates method
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let backgroundColor = loginButton.backgroundColor else { return circleAnimator }
        circleAnimator = CircleAnimator(view: loginButton, color: backgroundColor, duration: 0.4)
        circleAnimator?.mode = .dismiss
        return circleAnimator
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let backgroundColor = loginButton.backgroundColor else { return circleAnimator }
        circleAnimator = CircleAnimator(view: loginButton, color: backgroundColor, duration: 0.5)
        circleAnimator?.mode = .present
        
        return circleAnimator
    }
    

    
    
    
    

}

