//
//  CollectionViewController.swift
//  newsSwiftApp
//
//  Created by habiba on 4/29/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit
import SDWebImage

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
        getData { [weak self] news in
                  DispatchQueue.main.async {
                  self?.indictor? .stopAnimating()
                      self?.news = news
                      self?.collectionView.reloadData()
                  }
              }
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
      
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2.06, height: view.frame.width / 2)
    }


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
         if let detailsScreen = storyboard?.instantiateViewController(withIdentifier: "detailsScreen")
                    as? ViewController {
            detailsScreen.authorVar = selectediteam.author
                    detailsScreen.publishatVar = selectediteam.publishedAt
                    detailsScreen.titleLbVAr = selectediteam.title
                    detailsScreen.urlDVAr = selectediteam.url
                    detailsScreen.imgVar = selectediteam.imageUrl
            detailsScreen.desVAr = selectediteam.desription
                    navigationController?.pushViewController(detailsScreen, animated: true)
                }
                
    }
    }


