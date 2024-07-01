//
//  imagenViewController.swift
//  Snapchat
//
//  Created by Farid Lucio Gonzales Gonzalo on 27/5/24.
//

import UIKit
import FirebaseStorage

class imagenViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var imagePicker=UIImagePickerController()

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var elegirContactoBoton: UIButton!
    @IBOutlet weak var descripcionTextField: UITextField!
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing=false
        present(imagePicker,animated: true,completion: nil)
    }
    @IBAction func elegirContactoTapped(_ sender: Any) {
    
        self.elegirContactoBoton.isEnabled = false
        let imagenesFolder = Storage.storage().reference().child("imagenes")
        let imagenData = imageView.image?.jpegData(compressionQuality: 0.50)
        let cargarImagen = imagenesFolder.child("\(NSUUID().uuidString).jpg").putData(imagenData!, metadata: nil){(metadata,error) in
            if error != nil {
                self.mostrarAlerta(titulo: "Error", mensaje: "Se produjo un error al subir la imagen. Verifique su conexion a internet y vuelva a intentarlo.", accion: "Aceptar")
                self.elegirContactoBoton.isEnabled = true
                print("Ocurrio un error al subir la imagen:\(error)")
            }else{
                self.performSegue(withIdentifier: "seleccionarContactoSegue", sender: nil)
            }
        }
        let alertaCarga = UIAlertController(title: "Cargando Imagen....", message: "0%", preferredStyle: .alert)
        let progresoCarga:UIProgressView = UIProgressView(progressViewStyle: .default)
        cargarImagen.observe(.progress){(snapshot) in
            let porcetanje = Double(snapshot.progress!.completedUnitCount)
            / Double(snapshot.progress!.totalUnitCount)
            print(porcetanje)
            progresoCarga.setProgress(Float(porcetanje), animated: true)
            progresoCarga.frame = CGRect(x:10,y:70,width: 250,height: 0)
            alertaCarga.message=String(round(porcetanje * 100.0))+"%"
            if porcetanje>=1.0{
                alertaCarga.dismiss(animated: true, completion: nil)
            }
        }
        let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alertaCarga.addAction(btnOK)
        alertaCarga.view.addSubview(progresoCarga)
        present(alertaCarga,animated: true,completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate=self
        elegirContactoBoton.isEnabled=false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageView.image = image
        imageView.backgroundColor=UIColor.clear
        elegirContactoBoton.isEnabled=true
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func mostrarAlerta(titulo: String,mensaje:String,accion: String){
        let alerta = UIAlertController(title:titulo,message: mensaje,preferredStyle: .alert)
        let btnCACELOK = UIAlertAction(title: accion ,style: .default,handler: nil)
        alerta.addAction(btnCACELOK)
        present(alerta,animated: true,completion: nil)
    }
    
    override func prepare(for segue:UIStoryboardSegue,sender:Any?){
        let imagenesFolder = Storage.storage().reference().child("imagenes")
        let imagenData = imageView.image?.jpegData(compressionQuality: 0.50)
        imagenesFolder.child("imagenes.jpg").putData(imagenData!,metadata:nil){
            (metadata, error) in
            if error != nil{
                print("Ocurrio un error  al subir la imagen: \(error)")
            }else{
                print("Imagen subida correctamente")
            }
        }
    }
    // MARK: - Table view data source


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
