//
// 
//  Snapchat
//
//  Created by Farid Lucio Gonzales Gonzalo on 20/5/24.
//

import UIKit

import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FirebaseDatabase
class iniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var googleSignInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func googleb(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
            return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

          // ...
        }
    }
    @IBAction func IniciarSesionTapped(_ sender: Any) {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                print("Intentando Iniciar sesión")
                if let error = error {
                    print("Se presentó el siguiente error: \(error.localizedDescription)")
                    let alerta = UIAlertController(title: "Error", message: "Usuario no registrado. ¿Desea crear una cuenta?", preferredStyle: .alert)
                    let btnCrear = UIAlertAction(title: "Crear", style: .default) { (action) in
                        self.performSegue(withIdentifier: "mostrarCrearUsuario", sender: nil)
                    }
                    let btnCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
                    alerta.addAction(btnCrear)
                    alerta.addAction(btnCancelar)
                    self.present(alerta, animated: true, completion: nil)
                } else {
                    print("Inicio de sesión exitoso")
                    self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                }
            }
        }
    
    @IBAction func botonGoogle(_ sender: Any) {
    }
    
    
}

