//
//  ViewController.swift
//  Basic Loading Screen
//
//  Created by Margels on 16/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    // STORYBOARD
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var circleA: UIView!
    @IBOutlet var circleB: UIView!
    @IBOutlet var circleC: UIView!
    @IBOutlet var circleD: UIView!
    
    @IBOutlet var exampleButton: UIButton!
    
    /* PROGRAMMATICALLY
    
    lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        v.center.x = self.view.center.x
        v.center.y = self.view.center.y * 0.83
        return v
    }()

    var circleA: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return v
    }()

    var circleB: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.frame = CGRect(x: 100-40, y: 0, width: 40, height: 40)
        return v
    }()

    var circleC: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.frame = CGRect(x: 100-40, y: 100-40, width: 40, height: 40)
        return v
    }()

    var circleD: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.frame = CGRect(x: 0, y: 100-40, width: 40, height: 40)
        return v
    }() */
    
    
    lazy var circles: [UIView] = [circleA, circleB, circleC, circleD]
    var circle = 0
    var colors: [UIColor] = [#colorLiteral(red: 0.32390064, green: 0.4138930738, blue: 0.9091263413, alpha: 0.5), #colorLiteral(red: 0.8235835433, green: 0.5749723315, blue: 0, alpha: 0.5), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 0.5), #colorLiteral(red: 0.09879464656, green: 0.3816201091, blue: 0.2502036691, alpha: 0.5), #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 0.5), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 0.5), #colorLiteral(red: 1, green: 0.2204911709, blue: 0.2471658289, alpha: 0.5), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 0.5), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0.5), #colorLiteral(red: 1, green: 0.71805197, blue: 1, alpha: 0.5)]
    lazy var random = Int.random(in: 0...colors.count-1)
    var loading = false
    lazy var blurry: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* PROGRAMMATICALLY, pt.2
         
        self.view.addSubview(containerView)
        for circle in circles {
            containerView.addSubview(circle) } */
        
        setUpCircles()
        exampleButton.layer.cornerRadius = exampleButton.frame.height / 2 }
    
    
    func setUpCircles() {
        
        containerView.isUserInteractionEnabled = false
        circles.forEach { circle in
            circle.layer.cornerRadius = circle.frame.height / 2
            circle.backgroundColor = .clear
            circle.isUserInteractionEnabled = false }}
    
    
    func blurView(completion: @escaping (_ success: Bool) -> ()) {
        
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.view.addSubview(blurry)
            self.view.bringSubviewToFront(blurry)
            self.view.bringSubviewToFront(containerView)
            UIView.animate(withDuration: 0.6) {
                self.blurry.alpha = 0.5
                completion(true) }}}
    
    func nextCircle() {
        
        random = Int.random(in: 0...colors.count-1)
        if circle == circles.count-1 {
            circle = 0
        } else {
            circle += 1 }}
    
    func circlesAnimation() {
        
        circles[circle].backgroundColor = colors[random].withAlphaComponent(0)
        UIView.animate(withDuration: 0.50) {
            self.circles[self.circle].backgroundColor = self.colors[self.random].withAlphaComponent(0.70)
        } completion: { success in
            self.circles[self.circle].backgroundColor = self.colors[self.random].withAlphaComponent(0)
            self.nextCircle()
            if self.loading == true {
                self.circlesAnimation() }}}
    
    func loadingView() {
        
        if loading == true {
            blurView { success in
                self.circlesAnimation() }
        } else {
            if self.view.contains(blurry) {
                setUpCircles()
                blurry.removeFromSuperview() }}}
    
    

    @IBAction func exampleButtonTapped(_ sender: Any) {
        
        loading = true
        loadingView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10)) {
            self.loading = false
            self.loadingView() }}
    
    
}

