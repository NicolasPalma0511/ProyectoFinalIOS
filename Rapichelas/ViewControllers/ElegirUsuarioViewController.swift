//
//  ElegirUsuarioViewController.swift
//  Snapchat2
//
//  Created by Farid Lucio Gonzales Gonzalo on 31/5/24.
//

import UIKit
import Firebase
import FirebaseDatabase

class ElegirUsuarioViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var listaUsuarios: UITableView!
    var usuarios:[Usuario] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        listaUsuarios.delegate=self
        listaUsuarios.dataSource=self
        Database.database().reference().child("usuarios").observe(DataEventType.childAdded,
        with: {(snapshot) in
            print(snapshot)
            
        let usuario = Usuario()
            usuario.email = (snapshot.value as! NSDictionary)["email"] as! String
            usuario.uid = snapshot.key
            self.usuarios.append(usuario)
            self.listaUsuarios.reloadData()
        })
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let usuario = usuarios[indexPath.row]
        cell.textLabel?.text = usuario.email
        return cell
    }
}
