//
//  ViewController.swift
//  UIResponder-Explained
//
//  Created by Hossam on 3/16/20.
//  Copyright © 2020 Hossam. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
   lazy var  testImageView : UIImageView  = {
        let imageView = UIImageView(image: UIImage(named: "X1Z1"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    var scale = CGFloat.zero
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(ShakeMe(target: self, action: #selector(myG)))
        self.view.backgroundColor = .red
        self.view.addSubview(testImageView)
       
        NSLayoutConstraint.activate([self.testImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor , constant: 100) ,
        self.testImageView.topAnchor.constraint(equalTo: self.view.topAnchor , constant: 100),
        self.testImageView.widthAnchor.constraint(equalToConstant: 190) ,
        self.testImageView.heightAnchor.constraint(equalToConstant: 180)
        ])

        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(touches.count)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    @objc func myG () {
        print("I CALLRF R")
    }
    
    
    
   

}


