//
//  IniciarSesionVC.swift
//  SoundBoard
//
//  Created by Jeferson Bujaico on 5/21/19.
//  Copyright © 2019 JeffRay. All rights reserved.
//

import UIKit
import Firebase

class IniciarSesionVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func IngresarTapped(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: txtEmail.text!, password: txtPassword.text!, completion: { (user, error) in
            print("============================")
            print("Se intenta Iniciar Sesión")
            //            print(user!.user)
            print("============================")
            if error != nil{
                print("Tenemos el siguiente error: \(String(describing: error))")
                print("============================")
                print("Se creará un nuevo Usuario")
                print("============================")
                FIRAuth.auth()?.createUser(withEmail: self.txtEmail.text!, password: self.txtPassword.text!, completion: { (user, error) in
                    if error != nil{
                        print("Tenemos el siguiente error: \(String(describing: error))")
                    }else{
                        print("El Usuario Fue creado Exitosamente")
                        FIRDatabase.database().reference().child("usuarios").child(user!.uid).child("email").setValue(user!.email)
                        //  Redireccionamos a la siguiente vista (HomePage)
                        print(user!.email!)
                        self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                    }
                })
//                Auth.auth().createUser(withEmail: self.txtEmail.text!, password: self.txtPassword.text!, completion: { (user, error) in
//                    if error != nil{
//                        print("Tenemos el siguiente error: \(String(describing: error))")
//                    }else{
//                        print("El Usuario Fue creado Exitosamente")
//                        Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
//                        //  Redireccionamos a la siguiente vista (HomePage)
//                        print(user!.user.email!)
//                        self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
//                    }
//                })
            }else{
                print("Inicio de Sesión Exitoso")
                //  Redireccionamos a la siguiente vista (HomePage)
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        })
    }
//        FIRAuth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!, completion: { (user, error) in
//            print("============================")
//            print("Se intenta Iniciar Sesión")
////            print(user!.user)
//            print("============================")
//            if error != nil{
//                print("Tenemos el siguiente error: \(String(describing: error))")
//                print("============================")
//                print("Se creará un nuevo Usuario")
//                print("============================")
//                Auth.auth().createUser(withEmail: self.txtEmail.text!, password: self.txtPassword.text!, completion: { (user, error) in
//                    if error != nil{
//                        print("Tenemos el siguiente error: \(String(describing: error))")
//                    }else{
//                        print("El Usuario Fue creado Exitosamente")
//                    Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
//                        //  Redireccionamos a la siguiente vista (HomePage)
//                        print(user!.user.email!)
//                        self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
//                    }
//                })
//            }else{
//                print("Inicio de Sesión Exitoso")
//                //  Redireccionamos a la siguiente vista (HomePage)
//                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
//            }
//        })
    }
    
//}

