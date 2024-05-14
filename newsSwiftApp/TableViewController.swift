//
//  TableViewController.swift
//  newsSwiftApp
//
//  Created by habiba on 5/1/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit
import CoreData


class TableViewController: UITableViewController {
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var authorlb: UILabel!
    @IBOutlet weak var datelb: UILabel!
    @IBOutlet weak var TilileLb: UITextView!
    @IBOutlet weak var deslb: UITextView!
    @IBOutlet weak var urllb: UITextView!
    @IBOutlet weak var addtofav: UIButton!
    var isFilled: Bool = false
    var authorVar :String?
    var titleLbVAr :String?
    var publishatVar :String?
    var urlDVAr  :String?
    var desVAr  :String?
    var imgVar:String?
    @IBAction func addtofavbtn(_ sender: UIButton) {
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
                        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//                             let filledHeartImage = UIImage(named: "fill")
//                             button.setImage(filledHeartImage, for: .normal)
                             isFilled = true
                         } else {
                           print("flase")
                         }
                   }}
                  
                  catch {
                      print("Failed to save new item: \(error)")
                  }
           
           
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        authorlb.text = authorVar
              TilileLb.text = titleLbVAr
              datelb.text =  publishatVar
              urllb.text = urlDVAr
              deslb.text = desVAr
                  if let imageUrlString = imgVar, let imageUrl = URL(string: imageUrlString) {
                     img.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "d"))
                 }
          
           if isFilled {
                 addtofav.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//                                let filledHeartImage = UIImage(named: "fill")
//                                addtofav.setImage(filledHeartImage, for: .normal)
                                isFilled = true
                            } else {
                              print("flase")
                            }
              
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFilled {
            addtofav.setImage(UIImage(systemName: "heart.fill"), for: .normal)

//                              let filledHeartImage = UIImage(named: "fill")
//                              addtofav.setImage(filledHeartImage, for: .normal)
                              isFilled = true
                          } else {
                            print("flase")
                          }
    }


    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }
//
//   
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        
//
//        return cell
//    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
