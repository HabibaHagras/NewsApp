//
//  ViewController.swift
//  newsSwiftApp
//
//  Created by habiba on 4/29/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var publishat: UILabel!
    @IBOutlet weak var titleLb: UITextView!
    @IBOutlet weak var des: UITextView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var urlD: UITextView!
    var authorVar :String?
    var titleLbVAr :String?
    var publishatVar :String?
    var urlDVAr  :String?
    var desVAr  :String?
    var imgVar:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        author.text = authorVar
        titleLb.text = titleLbVAr
        publishat.text =  publishatVar
        urlD.text = urlDVAr
        des.text = desVAr
            if let imageUrlString = imgVar, let imageUrl = URL(string: imageUrlString) {
               img.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "d"))
           }
        
        
    }
    


}

