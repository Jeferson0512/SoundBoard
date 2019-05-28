//
//  ImageVC.swift
//  SoundBoard
//
//  Created by Jeferson Bujaico on 5/21/19.
//  Copyright © 2019 JeffRay. All rights reserved.
//

import UIKit
import Firebase

class ImageVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var txtDescripcion: UITextField!
    @IBOutlet weak var btnContacto: UIButton!
    
    var imgPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgPicker.delegate = self

        // Do any additional setup after loading the view.
    }
    @IBAction func cameraTapped(_ sender: Any) {
        imgPicker.sourceType = .savedPhotosAlbum
        imgPicker.allowsEditing = false
        present(imgPicker, animated: true, completion: nil)
    }
    
    @IBAction func elegirContactoTapped(_ sender: Any) {
        btnContacto.isEnabled = false
        let imgFolder = Storage.storage().reference().child("imagenes")
        let imgData = UIImagePNGRepresentation(imgView.image!)!
        performSegue(withIdentifier: "seleccionarContactoSegue", sender: nil)
        imgFolder.child("imagenes.png").putData(imgData, metadata: nil, completion: {(metadata, error) in
            print("============================")
            print("Intentando subir la imagen")
            if error != nil{
                print("Ocurrio un error: \(String(describing: error))")
            }
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgView.image = image
        imgView.backgroundColor = UIColor.clear
        imgPicker.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let imgFolder = Storage.storage().reference().child("imagenes")
        let imgData = UIImageJPEGRepresentation(imgView.image!, 0.1)!
        
        imgFolder.child("\(NSUUID().uuidString).jpg").putData(imgData, metadata: nil, completion: {(metadata, error) in
            print("============================")
            print("Intentando subir la imagen")
            if error != nil{
                print("Ocurrio un error: \(String(describing: error))")
            }
        })
    }
    
}
