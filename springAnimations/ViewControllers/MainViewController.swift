//
//  MainViewController.swift
//  springAnimations
//
//  Created by Руслан Арыстанов on 15.12.2024.
//

import Spring

class MainViewController: UIViewController {
    var animations: [AboutAnimation] = []

    @IBOutlet var presetLabel: UILabel!
    @IBOutlet var curveLabel: UILabel!
    @IBOutlet var forceLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var delayLabel: UILabel!
    
    @IBOutlet var nextButton: SpringButton!
    
    @IBOutlet var animationView: SpringView!
    
    let animationPresets = Spring.AnimationPreset.allCases
    let animationCurves = Spring.AnimationCurve.allCases
    
    let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
    
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.setTitle("Run", for: .normal)
        nextButton.title(for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        generatingAnArrayOfAnimations()
        settingAnimationAttributeName()
    }

    @IBAction func animationСhange() {
        if counter < animations.count {
            impactFeedback.impactOccurred()
            settingAnimationAttributeName()
            
            animationView.animation = animations[counter].preset
            animationView.curve = animations[counter].curve
            animationView.force = animations[counter].force
            animationView.duration = animations[counter].duration
            animationView.delay = animations[counter].delay
            animationView.animate()
            
            counter += 1
        } else {
            counter = 0
            generatingAnArrayOfAnimations()
        }
        
        if counter < animations.count {
            nextButton.setTitle("Run \(animations[counter].preset)", for: .normal)
        }
    }
}

extension MainViewController {
    private func generatingAnArrayOfAnimations() {
        for _ in Spring.AnimationPreset.allCases {
            let force = Double.random(in: 0.7...1.2)
            let duration = Double.random(in: 0.7...1.2)
            let delay = Double.random(in: 0.7...1.2)
            
            let animation = AboutAnimation(
                preset: Spring.AnimationPreset.allCases[Int.random(in: 0..<animationPresets.count)].rawValue,
                curve: Spring.AnimationCurve.allCases[Int.random(in: 0..<animationCurves.count)].rawValue,
                force: force,
                duration: duration,
                delay: delay
            )
        
            animations.append(animation)
        }
    }
    
    private func settingAnimationAttributeName() {
        presetLabel.text = animations[counter].preset
        curveLabel.text = animations[counter].curve
        forceLabel.text = String(format: "%.2f", animations[counter].force)
        durationLabel.text = String(format: "%.2f", animations[counter].duration)
        delayLabel.text = String(format: "%.2f", animations[counter].delay)
    }
}

