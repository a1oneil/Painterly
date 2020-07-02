//
//  ViewController.swift
//  PaintApp
//
//  Created by Arianna O'Neil on 6/25/20.
//  Copyright © 2020 Arianna O'Neil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let canvas = CanvasView()
    
    override func loadView() {
        self.view = canvas
    }
    
    // setting up undo button
    let undoBtn: UIButton = {
        let button = UIButton(type: .custom)
        let btnImage = UIImage(named: "undobtn.png")
        button.setImage(btnImage, for: .normal)
        
        button.addTarget(self, action: #selector(undoBtnClick), for: .touchUpInside)
        return button
    }()
    
    // undo button function on click
    @objc fileprivate func undoBtnClick(){
        canvas.undoBtn()
    }
    
    // eraser button function on click
    let eraserBtn: UIButton = {
        let button = UIButton(type: .custom)
        let btnImage = UIImage(named: "eraser_80x80.png")
        button.setImage(btnImage, for: .normal)
        button.backgroundColor = .white
        
        button.addTarget(self, action:#selector(colorChange), for: .touchUpInside)
        return button
    }()
    
    // setting up clear button
    let clearBtn: UIButton = {
        let button = UIButton(type: .custom)
        let btnImage = UIImage(named: "clearbtn.png")
        button.setImage(btnImage, for: .normal)
        
        button.addTarget(self, action: #selector(clearBtnClick), for: .touchUpInside)
        return button
    }()
    
    // clear button function on click
    @objc fileprivate func clearBtnClick(){
        let alertMessage = UIAlertController(title: "Hold on a sec!", message: "Are you sure you want to clear your masterpiece?", preferredStyle: .alert)
        
        // create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("OK button tapped")
            self.canvas.clearBtn()
            
        })
        
        // create Cancel button with action handler
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        // add OK and Cancel button to msg
        alertMessage.addAction(ok)
        alertMessage.addAction(cancel)
        
        // present alert msg to user
        self.present(alertMessage, animated: true, completion: nil)
    }
    
    // painterly label display at top center of app
    func painterlyLabel() -> UILabel {
        let label: UILabel = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.text = "Painterly"
        label.font = UIFont(name: "Vibur", size: 40)
        label.textColor = UIColor(red: 159/255, green: 196/255, blue: 255/255, alpha: 1.0)
        return label
    }
    
    // set up options button
    let optionsBtn: UIButton = {
        let button = UIButton(type: .custom)
        let btnImage = UIImage(named: "ellipsis_prpl.png")
        button.setImage(btnImage, for: .normal)
        
        button.addTarget(self, action: #selector(optionsBtnClick), for: .touchUpInside)
        return button
    }()
    
    // options button function on click
    // displays save button option & help option
    // option to cancel function as well
    @objc fileprivate func optionsBtnClick(){
        let actionSheet = UIAlertController(title: "Pick your option:", message: "", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Save your drawing", style: .default, handler: { (_) in
                let image = self.canvas.saveImg()
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.imgSaved(_:didFinishSavingWithError:contextType:)), nil)
            }))
            actionSheet.addAction(UIAlertAction(title: "Help", style: .default, handler: { (_) in
                let alertController = UIAlertController(title: "Welcome to Painterly!", message: "Choose a color from the palette below and start painting! Stuck on ideas? Tap the lightbulb for a randomized prompt! Now draw some happy little trees :)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                           UIAlertAction in
                           print("OK Pressed")
                       }
                // add the actions
                alertController.addAction(okAction)

                // present the alert
                self.present(alertController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            present(actionSheet, animated: true, completion: nil)
    }
    
    // save button function on click
    @objc func imgSaved(_ image: UIImage, didFinishSavingWithError error: Error?, contextType: UnsafeRawPointer) {
        
    if let error = error {
        // we got back an error!
        let alertController = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    } else {
        let alertController = UIAlertController(title: "Saved!", message: "Your masterpiece has been saved to your photos!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
        }
    }
    
    // set up drawing prompt button
    let promptBtn: UIButton = {
        let button = UIButton(type: .custom)
        let btnImage = UIImage(named: "lightbulb_drkylw.png")
        button.setImage(btnImage, for: .normal)
        
        button.addTarget(self, action: #selector(promptBtnClick), for: .touchUpInside)
        return button
    }()
    
    // drawing prompt function on click
    @objc fileprivate func promptBtnClick(){
        let mashedAdjectives = ["a large", "a pink", "a silly", "chilly", "an angry", "a rainbow", "a funny", "a tiny", "a mysterious", "a nervous", "a crazy", "a happy","a prickly"]
        
        let mashedNouns = ["cat", "elephant", "man", "woman", "ghost", "dog", "fairy", "spaghetti", "boot", "computer", "shoe", "cactus", "racoon", "dinosaur", "chef", "monster", "elf", "pumpkin"]
        
        let alertController = UIAlertController(title: "Your prompt is...", message: "Draw \(String(describing: mashedAdjectives.randomElement()!)) \(String(describing: mashedNouns.randomElement()!))", preferredStyle: .alert)
        
        // create OK action
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            print("OK Pressed")
        }

        // add OK action
        alertController.addAction(okAction)

        // present the alert
        self.present(alertController, animated: true, completion: nil)
    }
    
    // set up color palette
    let redBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 0
        button.addTarget(self, action:#selector(colorChange), for: .touchUpInside)
        return button
    }()
    
    let orangeBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.layer.borderWidth = 0
        button.addTarget(self, action:#selector(colorChange), for: .touchUpInside)

        return button
    }()
    
    let greenBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .green
        button.layer.borderWidth = 0
        button.addTarget(self, action:#selector(colorChange), for: .touchUpInside)

        return button
    }()
    
    let blueBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderWidth = 0
        
        button.addTarget(self, action:#selector(colorChange), for: .touchUpInside)
        return button
    }()
    
    let yellowBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 0
        
        button.addTarget(self, action:#selector(colorChange), for: .touchUpInside)
        return button
    }()
    
    let purpleBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.layer.borderWidth = 0
        
        button.addTarget(self, action:#selector(colorChange), for: .touchUpInside)
        return button
    }()
    
    let pinkBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemPink
        button.layer.borderWidth = 0
        
        button.addTarget(self, action:#selector(colorChange), for: .touchUpInside)
        return button
    }()
    
    let brownBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .brown
        button.layer.borderWidth = 0
        
        button.addTarget(self, action:#selector(colorChange), for: .touchUpInside)
        return button
    }()
    
    let grayBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .gray
        button.layer.borderWidth = 0
        
        button.addTarget(self, action:#selector(colorChange), for: .touchUpInside)
        return button
    }()
    
    
    let blackBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.layer.borderWidth = 0
        
        button.addTarget(self, action:#selector(colorChange), for: .touchUpInside)
        return button
    }()
    
    // color change function on click
    @objc fileprivate func colorChange(button: UIButton){
        canvas.setStrokeColor(color: button.backgroundColor ?? .black)
    }
    
    // set up brush size slider
    let brushSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        
        slider.addTarget(self, action: #selector(brushSizeDidChange), for: .valueChanged)
        return slider
    }()
    
    // brush size slider function on click
    @objc fileprivate func brushSizeDidChange(slider: UISlider){
        canvas.setStrokeWidth(width: slider.value)
        print(slider.value)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        canvas.backgroundColor = .white
        displayLayout()
}

    // organizing the buttons/label at the top of the app screen
    fileprivate func displayLayout(){
        let topStackView = UIStackView(arrangedSubviews: [
            promptBtn,
            painterlyLabel(),
            optionsBtn
        ])
        
        topStackView.distribution = .fillEqually
        view.addSubview(topStackView)
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // left side
        topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        // top
        topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        // right side
        topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // organizing the buttons/functions at the bottom of the app screen
        let bottomStackView = UIStackView(arrangedSubviews: [
            undoBtn,
            clearBtn,
            eraserBtn,
            brushSlider
        ])
        bottomStackView.distribution = .fillEqually
        view.addSubview(bottomStackView)
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // left side
        bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        // bottom
        bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        // right side
        bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // organizing the color palette
        let paintStackView = UIStackView(arrangedSubviews: [
            redBtn,
            orangeBtn,
            greenBtn,
            blueBtn,
            yellowBtn,
            purpleBtn,
            pinkBtn,
            brownBtn,
            grayBtn,
            blackBtn
        ])
        
        paintStackView.axis = .horizontal
        paintStackView.distribution = .fillEqually
        view.addSubview(paintStackView)
        paintStackView.translatesAutoresizingMaskIntoConstraints = false
        
        paintStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        paintStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        paintStackView.spacing = 10
    }
}

// saving the app view into photos
extension UIView {
    
    func saveImg() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if (image != nil) {
            return image!
        }
        
        return UIImage()
    }
}


