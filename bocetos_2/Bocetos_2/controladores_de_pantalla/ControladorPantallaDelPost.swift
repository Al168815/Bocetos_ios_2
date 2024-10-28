//
//  ControladorPantallaDelPost.swift
//  Bocetos_2
//
//  Created by alumno on 10/11/24.
//

import UIKit

class ControladorPantallaDelPost: UIViewController {
    private let identificador_de_celda = "CeldaComentario"
    let proveedor_publicaciones = ProveedorDePublicaciones.autoreferencia
    
    
    @IBOutlet weak var titulo_de_publicaciones: UILabel!
    @IBOutlet weak var nombre_de_usuario: UILabel!
    @IBOutlet weak var cuerpo_de_publicacion: UILabel!
    @IBOutlet weak var seccion_comentarios: UICollectionView!
    
    
    public var id_publicacion: Int?
    
    private var publicacion: Publicacion?
    
    private var usuario: Usuario?
    private var lista_comentarios: [Comentario] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let controlador_de_navegacion = self.navigationController as? mod_navegador_principal
        controlador_de_navegacion?.activar_navigation_bar(actviar: true)
        
        realizar_descarga_de_informacion()
    }
    
    func realizar_descarga_de_informacion(){
        if self.publicacion == nil{
            proveedor_publicaciones.obtener_publicaciones(id: self.id_publicacion ?? -1, que_hacer_al_recibir: {
                [weak self] (publicacion) in self?.publicacion = publicacion
                    DispatchQueue.main.async {
                        self?.dibujar_publicacion()
                    }
                })
        }
        else if self.publicacion != nil {
            proveedor_publicaciones.obtener_usuario(id: publicacion!.userId, que_hacer_al_recibir: {
                [weak self] (usuario) in self?.usuario = usuario
                    DispatchQueue.main.async {
                        self?.dibujar_publicacion()
                    }
                })
        }
    }
    
    
    func dibujar_publicacion(){
        guard let publicacion_actual = self.publicacion else{
            return
        }
        
        titulo_de_publicaciones.text = publicacion_actual.title
        cuerpo_de_publicacion.text = publicacion_actual.body
    }
    func dibujar_usuario(){
            guard let usuario_actual = self.usuario else {
                return
            }
            
            nombre_de_usuario.text = usuario_actual.username
            
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return lista_comentarios.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            print("Aqui denberia hacer algo")
            
            let celda_comentario = collectionView.dequeueReusableCell(withReuseIdentifier: identificador_de_celda, for: indexPath)
        
            // Configure the cell
            celda_comentario.comentario.text=self.lista_comentarios[indexPath.item].body
            // print(self.lista_de_publicaciones)
            
            return celda_comentario
        }
        


}