//
//  VerSnapVC.swift
//  SoundBoard
//
//  Created by Jeferson Bujaico on 6/12/19.
//  Copyright © 2019 JeffRay. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class VerSnapVC: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblSnap: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblSnap.text? = snap.descripcion
        //  Se captura la imagen
        let imagen = URL(string: snap.imagenURL)
        imgView.sd_setImage(with: imagen)
    }

    override func viewWillAppear(_ animated: Bool) {
        //  Se le elimina de Firebase una vez visto
        FIRDatabase.database().reference().child("usuarios").child(FIRAuth.auth()!.currentUser!.uid).child("snap").child(snap.id).removeValue()
        //  Se eliminara la imagen de l Firebase visto
        FIRStorage.storage().reference().child("imagenes").child("\(snap.imageID).jpg").delete{ (error) in
            print("Se elimino la imagen correctamente")
        }
        
    }
    
}
