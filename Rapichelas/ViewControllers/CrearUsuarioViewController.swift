//
//  CrearUsuarioViewController.swift
//  Snapchat2
//
//  Created by Farid Lucio Gonzales Gonzalo on 31/5/24.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CrearUsuarioViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func crearUsuarioTapped(_ sender: Any) {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if let error = error {
                    print("Error al crear el usuario: \(error.localizedDescription)")
                    return
                }
                print("Usuario creado exitosamente")
                Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                let alerta = UIAlertController(title: "Creación de Usuario", message: "Usuario \(self.emailTextField.text!) se creó correctamente.", preferredStyle: .alert)
                let btnOK = UIAlertAction(title: "Aceptar", style: .default) { (action) in
                    self.dismiss(animated: true, completion: nil)
                }
                alerta.addAction(btnOK)
                self.present(alerta, animated: true, completion: nil)
            }
        }

}
