//
//  CollectionViewController.swift
//  newsSwiftApp
//
//  Created by habiba on 4/29/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit
import SDWebImage
import Reachability
import CoreData



var reachability: Reachability?


class CollectionViewController: UICollectionViewController ,  UICollectionViewDelegateFlowLayout {
    var news: [NewsModel] = []
    var indictor : UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        indictor = UIActivityIndicatorView(style: .large)
        indictor?.center = view.center
        indictor?.startAnimating()
        indictor?.color = UIColor.red
        view.addSubview(indictor!)
//        getData { [weak self] news in
//                  DispatchQueue.main.async {
//                  self?.indictor? .stopAnimating()
//                      self?.news = news
//                      self?.collectionView.reloadData()
//                  }
//              }
        
       ///
        do {
              reachability = try Reachability()
          } catch {
              print("Unable to create Reachability")
          }
          
           NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: .reachabilityChanged, object: reachability)

          do {
              try reachability?.startNotifier()
            

          } catch {
              print("Unable to start Reachability notifier")
          }
        ///
        
    }
    @objc func reachabilityChanged(_ notification: Notification) {
        guard let reachability = notification.object as? Reachability else { return }
        
        if reachability.connection != .unavailable {
            getData { [weak self] news in
                             DispatchQueue.main.async {
                             self?.indictor? .stopAnimating()
                                 self?.news = news
                                 self?.collectionView.reloadData()
                                self?.deleteAllData()
                                self?.saveDataCore()

                             }
                         }

        } else {
            getCoreData()
            print("Network is unavailable")
        }
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
      
        return 1
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width / 1, height: view.frame.width / 2)
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 
        return news.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as! CollectionViewCell

            let currentNews = news[indexPath.item]
               cell.author.text = currentNews.author
            if let imageUrlString = currentNews.imageUrl,
                    let imageUrl = URL(string: imageUrlString) {
                     cell.img.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "d"))
                 }
            return cell

            
        }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectediteam = news[indexPath.row]
//        detailsScreen
         if let detailsScreen = storyboard?.instantiateViewController(withIdentifier: "detailsScreen2")
                    as? TableViewController {
            detailsScreen.authorVar = selectediteam.author
                    detailsScreen.publishatVar = selectediteam.publishedAt
                    detailsScreen.titleLbVAr = selectediteam.title
                    detailsScreen.urlDVAr = selectediteam.url
                    detailsScreen.imgVar = selectediteam.imageUrl
            detailsScreen.desVAr = selectediteam.desription
                    navigationController?.pushViewController(detailsScreen, animated: true)
                }
                
    }
    
    
    func saveDataCore()  {
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
              let context = appDelegate.persistentContainer.viewContext
             for newsItem in news {
                     guard let entity = NSEntityDescription.entity(forEntityName: "Home", in: context) else {
                         print("Entity description not found")
                         return
                     }
                     
                     let newItem = NSManagedObject(entity: entity, insertInto: context)
                     
                     newItem.setValue(newsItem.author, forKey: "author")
                     newItem.setValue(newsItem.title, forKey: "title")
                     newItem.setValue(newsItem.publishedAt, forKey: "publishedAt")
                     newItem.setValue(newsItem.desription, forKey: "desription")
                     newItem.setValue(newsItem.imageUrl, forKey: "imageUrl")
                     newItem.setValue(newsItem.url, forKey: "url")
                     
                 do {
                     try context.save()
                  print("saveddddddddddddddd")
        
                    
                 }
                 
                 catch {
                     print("Failed to save new item: \(error)")
                 }
          
          
          
          }
          
    
    
    
    }
    
  // Inside your reachabilityChanged(_:) function or wherever appropriate
   func getCoreData() {
       guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
           return
       }
       let context = appDelegate.persistentContainer.viewContext

       let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Home")

       do {
           let fetchedItems = try context.fetch(fetchRequest)
           self.news = fetchedItems.map { item in
               return NewsModel(
                   author: item.value(forKey: "author") as? String ?? "",
                   title: item.value(forKey: "title") as? String ?? "",
                   description: item.value(forKey: "desription") as? String ?? "",
                   imageUrl: item.value(forKey: "imageUrl") as? String ?? "",
                   url: item.value(forKey: "url") as? String ?? "",
                   publishedAt: item.value(forKey: "publishedAt") as? String ?? ""
               )
           }

           collectionView.reloadData()

       } catch let error as NSError {
           print("Could not fetch. \(error), \(error.userInfo)")
       }
   }
    func deleteAllData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Home")

        do {
            let items = try context.fetch(fetchRequest)
            for item in items {
                guard let objectToDelete = item as? NSManagedObject else { continue }
                context.delete(objectToDelete)
            }
            try context.save()
        } catch let error as NSError {
            print("Could not delete data. \(error), \(error.userInfo)")
        }
    }

    
}


