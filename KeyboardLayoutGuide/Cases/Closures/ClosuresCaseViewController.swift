//
//  ClosuresCaseViewController.swift
//  KeyboardLayoutGuide
//
//  Created by Patryk Kaczmarek on 03/01/2020.
//  Copyright © 2020 Patryk Kaczmarek. All rights reserved.
//

import UIKit

/// Confetti like particle effects inspired by:
/// https://medium.com/@prabhu_irl/particle-effects-in-swift-using-caemitterlayer-79fb88452724
final class ClosuresCaseViewController: ViewController<ClosuresCaseView> {
    
    private enum Colors {
        static let red = UIColor(red: 1.0, green: 0.0, blue: 77.0/255.0, alpha: 1.0)
        static let blue = UIColor.blue
        static let green = UIColor(red: 35.0/255.0 , green: 233/255, blue: 173/255.0, alpha: 1.0)
        static let yellow = UIColor(red: 1, green: 209/255, blue: 77.0/255.0, alpha: 1.0)
    }
    
    private enum Images {
        static let box = UIImage(named: "Box")!
        static let triangle = UIImage(named: "Triangle")!
        static let circle = UIImage(named: "Circle")!
        static let swirl = UIImage(named: "Spiral")!
    }
    
    // MARK: Properties
    
    private var emitter = CAEmitterLayer()
    
    private var colors: [UIColor] = [
        Colors.red,
        Colors.blue,
        Colors.green,
        Colors.yellow
    ]
    
    private var images: [UIImage] = [
        Images.box,
        Images.triangle,
        Images.circle,
        Images.swirl
    ]
    
    private var velocities: [Int] = [
        100,
        90,
        150,
        200
    ]
    
    var animate: Bool = false {
        didSet {
            if animate {
                emitter.emitterPosition = CGPoint(x: view.frame.size.width / 2, y: -10)
                emitter.emitterShape = .line
                emitter.emitterSize = CGSize(width: view.frame.size.width, height: 2.0)
                emitter.emitterCells = generateEmitterCells()
                view.layer.addSublayer(emitter)
            } else {
                emitter.removeFromSuperlayer()
            }
        }
    }
    
    // MARK: Initializer
    
    init() {
        super.init(view: ClosuresCaseView())
    }
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.textField.delegate = self
        automaticallyAdjustKeyboardLayoutGuide = true
        onKeyboardWillAppear = { [weak self] _ in
            self?.animate = true
        }
        onKeyboardWillDisappear = { [weak self] _ in
            self?.animate = false
        }
    }
}

// MARK: UITextFieldDelegate

extension ClosuresCaseViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

// MARK: Private

private extension ClosuresCaseViewController {
    
    func generateEmitterCells() -> [CAEmitterCell] {
        var cells:[CAEmitterCell] = [CAEmitterCell]()
        for index in 0..<16 {
            let cell = CAEmitterCell()
            cell.birthRate = 4.0
            cell.lifetime = 14.0
            cell.lifetimeRange = 0
            cell.velocity = CGFloat(getRandomVelocity())
            cell.velocityRange = 0
            cell.emissionLongitude = CGFloat(Double.pi)
            cell.emissionRange = 0.5
            cell.spin = 3.5
            cell.spinRange = 0
            cell.color = getNextColor(i: index)
            cell.contents = getNextImage(i: index)
            cell.scaleRange = 0.25
            cell.scale = 0.1
            cells.append(cell)
        }
        return cells
    }
    
    func getRandomVelocity() -> Int {
        velocities[getRandomNumber()]
    }
    
    func getRandomNumber() -> Int {
        Int(arc4random_uniform(4))
    }
    
    func getNextColor(i: Int) -> CGColor {
        if i <= 4 {
            return colors[0].cgColor
        } else if i <= 8 {
            return colors[1].cgColor
        } else if i <= 12 {
            return colors[2].cgColor
        } else {
            return colors[3].cgColor
        }
    }
    
    func getNextImage(i: Int) -> CGImage {
        images[i % 4].cgImage!
    }
}
