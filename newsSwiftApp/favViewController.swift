//
//  favViewController.swift
//  newsSwiftApp
//
//  Created by habiba on 4/29/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit

class favViewController: UIViewController {

    @IBOutlet weak var viewEmptyFav: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewEmptyFav.isHidden = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
