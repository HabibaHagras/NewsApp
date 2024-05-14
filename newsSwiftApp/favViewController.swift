//
//  favViewController.swift
//  newsSwiftApp
//
//  Created by habiba on 4/29/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

class favViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tabelview: UITableView!
    var fetchedItems: [NSManagedObject] = []

    @IBOutlet weak var viewEmptyFav: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
     //   viewEmptyFav.isHidden = false
        
        tabelview.dataSource = self
        tabelview.delegate = self
        fetchData()
        
    }
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabelview.dataSource = self
        tabelview.delegate = self
        fetchData()
    }
    
    func fetchData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "News")
        
        do {
            fetchedItems = try context.fetch(fetchRequest)
            tabelview.reloadData()
            if !fetchedItems.isEmpty {
                viewEmptyFav.isHidden = true
            } else {
                viewEmptyFav.isHidden = false
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
         let item = fetchedItems[indexPath.row]
        
        cell.textLabel?.text = item.value(forKey:"author") as! String
    if let imageUrlString = item.value(forKey: "imageUrl") as? String,
          let imageUrl = URL(string: imageUrlString) {
        cell.imageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "d"))
       }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectediteam = fetchedItems[indexPath.row]
//        deleteItem(selectedItem)
//        fetchedItems.remove(at: indexPath.row)
//        tableView.deleteRows(at: [indexPath], with: .automatic)
//        detailsScreen
                 if let detailsScreen = storyboard?.instantiateViewController(withIdentifier: "detailsScreen2")
                            as? TableViewController {
                    detailsScreen.authorVar = selectediteam.value(forKey:"author") as! String
                            detailsScreen.publishatVar = selectediteam.value(forKey:"publishedAt") as! String
                            detailsScreen.titleLbVAr = selectediteam.value(forKey:"title") as! String
                            detailsScreen.urlDVAr = selectediteam.value(forKey:"url") as! String
                            detailsScreen.imgVar = selectediteam.value(forKey:"imageUrl") as! String
                    detailsScreen.desVAr = selectediteam.value(forKey:"desription") as! String
                    detailsScreen.isFilled = true
                        navigationController?.pushViewController(detailsScreen, animated: true)
                        }
        
        
        }
    
    
    
 
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            let selectedItem = fetchedItems[indexPath.row]
            
            if editingStyle == .delete {
                deleteItem(selectedItem)
                fetchedItems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }

        func deleteItem(_ item: NSManagedObject) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let context = appDelegate.persistentContainer.viewContext
            context.delete(item)
            do {
                try context.save()
                print("deleted")
            } catch {
                print("Error deleting item: \(error)")
            }
    }

    
    
    
    
}
