//
//  ViewController.swift
//  newsSwiftApp
//
//  Created by habiba on 4/29/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var publishat: UILabel!
    @IBOutlet weak var titleLb: UITextView!
    @IBOutlet weak var des: UITextView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var urlD: UITextView!
    @IBOutlet weak var lovebutton: UIButton!
    var isFilled: Bool = false
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
    
     if isFilled {
                          let filledHeartImage = UIImage(named: "fill")
                          lovebutton.setImage(filledHeartImage, for: .normal)
                          isFilled = true
                      } else {
                        print("flase")
                      }
        
    }
    
  override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       if isFilled {
                             let filledHeartImage = UIImage(named: "fill")
                             lovebutton.setImage(filledHeartImage, for: .normal)
                             isFilled = true
                         } else {
                           print("flase")
                         }
   }

    

    @IBAction func AddToFav(_ sender: Any) {
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "News", in: context) else {
               return
           }
           
           let newItem = NSManagedObject(entity: entity, insertInto: context)
           
            newItem.setValue(authorVar, forKey: "author")
            newItem.setValue(titleLbVAr, forKey: "title")
            newItem.setValue(publishatVar, forKey: "publishedAt")
            newItem.setValue(desVAr, forKey: "desription")
            newItem.setValue(imgVar, forKey: "imageUrl")
            newItem.setValue(urlDVAr, forKey: "url")

           do {
               try context.save()
            print("saved")
              if let button = sender as? UIButton {
                if !isFilled {
                      let filledHeartImage = UIImage(named: "fill")
                      button.setImage(filledHeartImage, for: .normal)
                      isFilled = true
                  } else {
                    print("flase")
                  }
            }}
           
           catch {
               print("Failed to save new item: \(error)")
           }
    
    
    
    }
    
}

