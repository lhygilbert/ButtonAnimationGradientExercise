//
//  ViewController.swift
//  ButtonAnimationGradientExercise
//
//  Created by Gilbert Lo on 10/29/17.
//  Copyright © 2017 Gilbert Lo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var pulseButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handlePulse(_:)), for: .touchUpInside)
        button.setTitle("Pulse", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var flashButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleFlash), for: .touchUpInside)
        button.setTitle("Flash", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var shakeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleShake), for: .touchUpInside)
        button.setTitle("Shake", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .green
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = .white
        setupView()
    }

    private func setupView() {
        let stackView = UIStackView(arrangedSubviews: [pulseButton, flashButton, shakeButton])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            pulseButton.widthAnchor.constraint(equalToConstant: 200),
            pulseButton.heightAnchor.constraint(equalToConstant: 45),
            
            flashButton.widthAnchor.constraint(equalToConstant: 200),
            flashButton.heightAnchor.constraint(equalToConstant: 45),
            
            shakeButton.widthAnchor.constraint(equalToConstant: 200),
            shakeButton.heightAnchor.constraint(equalToConstant: 45),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            stackView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    @objc func handlePulse(_ sender: UIButton) {
        sender.plusate()
    }
    
    @objc func handleFlash(_ sender: UIButton) {
        sender.flash()
    }
    
    @objc func handleShake(_ sender: UIButton) {
        sender.shake()
    }
}

extension UIButton {
    
    func plusate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95 // From 100% to 95 %
        pulse.toValue = 1
        pulse.autoreverses = true // reverse animation once done
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1
        
        layer.add(pulse, forKey: nil)
    }
    
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.autoreverses = true
        flash.repeatCount = 3
        
        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        layer.add(flash, forKey: nil)
    }
    
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        shake.fromValue = CGPoint(x: center.x - 5, y: center.y)
        shake.toValue = CGPoint(x: center.x + 5, y: center.y)
        
        layer.add(shake, forKey: nil)
    }
}
