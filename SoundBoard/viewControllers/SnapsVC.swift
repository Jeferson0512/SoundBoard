//
//  SnapsVC.swift
//  SoundBoard
//
//  Created by Jeferson Bujaico on 5/21/19.
//  Copyright © 2019 JeffRay. All rights reserved.
//

import UIKit
import Firebase

class SnapsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var snaps:[Snap] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Se hace llamado a los demas registro sobre snpas
        SnapsRegistrados()
        //  Actualizará el table view cada vez que ingresemos a ese VC
        SnapsUpdate()
    }
    
    @IBAction func cerrarSesionTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if snaps.count == 0 {
            return 1
        }else{
            return snaps.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if snaps.count == 0 {
            cell.textLabel?.text = "No tienes Snaps 😱"
        }else{
            let snap = snaps[indexPath.row]
            cell.textLabel?.text = snap.from
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "verSnapSegue", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verSnapSegue" {
            let sigVC = segue.destination as! VerSnapVC
            sigVC.snap = sender as! Snap
        }
    }
    
    func SnapsRegistrados(){
        FIRDatabase.database().reference().child("usuarios").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childAdded, with: { (snapshot) in
            let snap = Snap()
            
            //  Se guardará todos los datos en la clase Snap segun el parametro
            snap.imagenURL = (snapshot.value as! NSDictionary)["imageURL"] as! String
            snap.from = (snapshot.value as! NSDictionary)["from"] as! String
            snap.descripcion = (snapshot.value as! NSDictionary)["descripcion"] as! String
            snap.id = snapshot.key
            snap.imageID = (snapshot.value as! NSDictionary)["imageID"] as! String
            //  Se agregan al Arreglo Snap
            self.snaps.append(snap)
            //  Se carga la tabla
            self.tableView.reloadData()
        })
    }
    
    func SnapsUpdate(){
        FIRDatabase.database().reference().child("usuarios").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childAdded, with: { (snapshot) in
            
            var iterador = 0
            for snap in self.snaps{
                if snap.id == snapshot.key {
                    self.snaps.remove(at: iterador)
                }
                iterador += 1
            }
            self.tableView.reloadData()
        })
    }
}
