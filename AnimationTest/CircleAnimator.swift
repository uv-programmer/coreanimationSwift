

import UIKit

class CircleAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    enum TransitionMode {
        case present, dismiss
    }
    
    // MARK:- variables for the Animator
    var mode: TransitionMode = .present
    
    var circle = UIView()
    var circleColor: UIColor
    
    var circleOrigin: CGPoint = CGPoint.zero
    
    var animationDuration: TimeInterval
    
    
    // MARK:- initializers for the circleAnimator
    init(view: UIView, color: UIColor, duration: TimeInterval) {
        self.circleOrigin = view.center
        self.circleColor = color
        self.animationDuration = duration
    }
    
    // MARK:- functions for the circleAnimator
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    /// returns the frame the circle is supposed to occupy while transitioning
    func frameForCircle(center: CGPoint, size: CGSize, start: CGPoint) -> CGRect{
        let lengthX = fmax(start.x, size.width - start.x)
        let lengthY = fmax(start.y, size.height - start.y)
        let offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2
        let size = CGSize(width: offset, height: offset)
        return CGRect(origin: CGPoint.zero, size: size)
    }
    
    /// the function for transitioning between the viewControllers
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if mode == .present {
            guard let presentedView = transitionContext.view(forKey: .to) else { return }
            let viewCenter = presentedView.center
            let viewSize = presentedView.frame.size
            
            /// set a circle in place of the selectedButton
            circle = UIView(frame: frameForCircle(center: viewCenter, size: viewSize, start: circleOrigin))
            circle.roundCorners(cornerRadius: circle.frame.width / 2.0)
            circle.center = circleOrigin
            
            /// make the circle small so that we can animate
            circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            circle.backgroundColor = circleColor
            
            /// container view is where the action transition takes place
            containerView.addSubview(circle)
            
            /// presentedView is the view we will transition to
            presentedView.center = circleOrigin
            presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            presentedView.backgroundColor = circleColor
            
            /// add the presentedView to container so that we can animate it too
            containerView.addSubview(presentedView)
            
            /// animate the circle and the presentedView and remove it after completion
            UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
                self.circle.transform = CGAffineTransform.identity
                presentedView.transform = CGAffineTransform.identity
                presentedView.center = viewCenter
            }, completion: { (finished) in
                self.circle.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        } else {
            guard let returnController = transitionContext.view(forKey: .from) else { return }
            let viewCenter = returnController.center
            let viewSize = returnController.frame.size
            
            /// set a circle in place of the selectedButton
            circle.frame = frameForCircle(center: viewCenter, size: viewSize, start: circleOrigin)
            circle.roundCorners(cornerRadius: circle.frame.width / 2.0)
            circle.center = circleOrigin
            circle.backgroundColor = circleColor
            
            /// container view is where the action transition takes place
            containerView.addSubview(circle)
            
            /// animate the circle and the returningController and remove it after completion
            UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
                self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                returnController.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                returnController.center = self.circleOrigin
                returnController.alpha = 0
                
            }, completion: {finished in
                returnController.removeFromSuperview()
                self.circle.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        }
    }
}
