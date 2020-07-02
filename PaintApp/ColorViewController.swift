//
//  ColorViewController.swift
//  PaintApp
//
//  Created by Arianna O'Neil on 7/2/20.
//  Copyright © 2020 Arianna O'Neil. All rights reserved.
//

import UIKit

protocol ColorViewControllerDelegate: class {
  func colorViewControllerFinished(_ colorViewController: ColorViewController)
}

class ColorViewController: UIViewController {
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    
    weak var delegate: ColorViewControllerDelegate?
    
    func colorPreview(red:CGFloat, green:CGFloat, blue:CGFloat){
        var colorView : UIImageView
        colorView = UIImageView(frame:CGRect(x: 100, y: 100, width: 100, height: 100));
        self.view.addSubview(colorView)
        
        colorView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func colorLabel() -> UILabel {
        let label: UILabel = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.text = "Color Settings"
        label.font = UIFont(name: "Vibur", size: 40)
        label.textColor = UIColor(red: 159/255, green: 196/255, blue: 255/255, alpha: 1.0)
        return label
    }
    
    var redLabel: UILabel = UILabel()
    var blueLabel: UILabel = UILabel()
    var greenLabel: UILabel = UILabel()
    
    var redSlider: UISlider = UISlider()
    var blueSlider: UISlider = UISlider()
    var greenSlider: UISlider = UISlider()
    
    @objc fileprivate func redSliderValueDidChange(sender: UISlider!)
    {
        let slider = sender!
        red = CGFloat(slider.value)
        colorPreview(red: red, green: green, blue: blue)
        redLabel.text = "\(Int(slider.value * 255))"
    }
    
    @objc fileprivate func blueSliderValueDidChange(sender: UISlider!)
    {
        let slider = sender!
        blue = CGFloat(slider.value)
        colorPreview(red: red, green: green, blue: blue)
        blueLabel.text = "\(Int(slider.value * 255))"
    }
    
    @objc fileprivate func greenSliderValueDidChange(sender: UISlider!)
    {
        let slider = sender!
        green = CGFloat(slider.value)
        colorPreview(red: red, green: green, blue: blue)
        greenLabel.text = "\(Int(slider.value * 255))"
    }
    
    let closeBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        
        button.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func closeBtnClick(){
        if delegate != nil {
            delegate?.colorViewControllerFinished(self)
        }
        dismiss(animated: true, completion: nil)
    }
    
    let paletteBtn: UIButton = {
        let button = UIButton(type: .custom)
        let btnImage = UIImage(named: "palettebtn.png")
        button.setImage(btnImage, for: .normal)
        
        button.addTarget(self, action: #selector(paletteBtnClick), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func paletteBtnClick(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let color = mainStoryboard.instantiateViewController(withIdentifier: "ColorViewController")
        
        self.present(color, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        colorPreview(red: red, green: green, blue: blue)
        displayLayout()
        
        redSlider = UISlider(frame: CGRect(x: 45, y: 300, width: 310, height: 31))
        redSlider.value = Float(red)
        redSlider.addTarget(self, action: #selector(redSliderValueDidChange),for: .valueChanged)
        self.view.addSubview(redSlider)
        
        redLabel = UILabel(frame: CGRect(x: 20, y: 245, width: 100, height: 41))
        redLabel.text = String(Int(redSlider.value * 255))
        self.view.addSubview(redLabel)
        
        blueSlider = UISlider(frame: CGRect(x: 45, y: 400, width: 310, height: 31))
        blueSlider.value = Float(blue)
        blueSlider.addTarget(self, action: #selector(blueSliderValueDidChange),for: .valueChanged)
        self.view.addSubview(blueSlider)
        
        blueLabel = UILabel(frame: CGRect(x: 20, y: 345, width: 100, height: 41))
        blueLabel.text = String(Int(blueSlider.value * 255))
        self.view.addSubview(blueLabel)
        
        greenSlider = UISlider(frame: CGRect(x: 45, y: 500, width: 310, height: 31))
        greenSlider.value = Float(blue)
        greenSlider.addTarget(self, action: #selector(greenSliderValueDidChange),for: .valueChanged)
        self.view.addSubview(greenSlider)
        
        greenLabel = UILabel(frame: CGRect(x: 20, y: 445, width: 100, height: 41))
        greenLabel.text = String(Int(greenSlider.value * 255))
        self.view.addSubview(greenLabel)
    

    }
    
    fileprivate func displayLayout(){
        
        let topStackView = UIStackView(arrangedSubviews: [
            colorLabel(),
            closeBtn
        ])
        
        topStackView.distribution = .fillEqually
        
        view.addSubview(topStackView)
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        // left side
        topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        //top
        topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        // right side
        topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        topStackView.spacing = 10
    }
    

    
    
    
    
}
