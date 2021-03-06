//
//  ElegirUsuarioVC.swift
//  SoundBoard
//
//  Created by Jeferson Bujaico on 5/27/19.
//  Copyright © 2019 JeffRay. All rights reserved.
//

import UIKit
import Firebase

class ElegirUsuarioVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //  Estableciendo variables a los componentes
    @IBOutlet weak var tableView: UITableView!
    
    //  Llamando a la Clase Usuario
    var usuarios:[Usuario] = []
    var imagenURL = ""
    var descrip = ""
    var imgID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Imprimir la lista de usuarios
        FIRDatabase.database().reference().child("usuarios").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            //  Imprime lista de users por consola
//            print(snapshot)
            let usuario = Usuario()
            usuario.email = (snapshot.value as! NSDictionary)["email"] as! String
            usuario.uid = snapshot.key
            self.usuarios.append(usuario)
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell()
        let usuario = usuarios[indexPath.row]
        cell.textLabel?.text = usuario.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let usuario = usuarios[indexPath.row]
        let snap = ["from": FIRAuth.auth()!.currentUser!.email!, "descripcion": descrip, "imageURL": imagenURL, "imageID": imgID]
        FIRDatabase.database().reference().child("usuarios").child(usuario.uid).child("snaps").childByAutoId().setValue(snap)
        navigationController?.popToRootViewController(animated: true)
    }
}
