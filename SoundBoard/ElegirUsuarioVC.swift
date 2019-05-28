//
//  ElegirUsuarioVC.swift
//  SoundBoard
//
//  Created by Jeferson Bujaico on 5/27/19.
//  Copyright © 2019 JeffRay. All rights reserved.
//

import UIKit

class ElegirUsuarioVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
