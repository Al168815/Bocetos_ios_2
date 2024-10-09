//
//  ControladorPantallaPrincipalDeColeccion.swift
//  Boceto_2_Cellview
//
//  Created by alumno on 10/7/24.
//

import UIKit

class ControladorPantallaPrincipalDeColeccion: UICollectionViewController {
    
    private var lista_de_publicaciones: [Post] = []
    private let url_de_publicaciones = "https://jsonplaceholder.typicode.com/posts"
    private let identificador_de_celda = "celda_pantalla_principal"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ubicacion = URL(string: url_de_publicaciones)!
        URLSession.shared.dataTask(with: ubicacion) { (datos, respuesta, error) in
            do {
                if let publicaciones_recibidas = datos {
                    let prueba_de_interpretacion_de_datos = try JSONDecoder().decode([Post].self, from: publicaciones_recibidas)
                    DispatchQueue.main.async {
                        self.lista_de_publicaciones = prueba_de_interpretacion_de_datos
                        self.collectionView.reloadData() // Recarga la colección para mostrar los datos
                    }
                } else {
                    print("No recibimos información")
                }
            } catch {
                print("Error")
            }
        }.resume()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 // Cambiado a 1 sección para mostrar las publicaciones
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lista_de_publicaciones.count // Devuelve el número de publicaciones
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda: VistaDeZelda = collectionView.dequeueReusableCell(withReuseIdentifier: identificador_de_celda, for: indexPath) as! VistaDeZelda
        
        // Obtiene la publicación correspondiente
        let publicacion = lista_de_publicaciones[indexPath.item]
        
        // Combina el título y el cuerpo
        celda.etiqueta.text = "\(publicacion.id)\n\n\(publicacion.title)\n\n\(publicacion.body)" // Usando \n para saltos de línea
        
        return celda
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Se seleccionó la celda \(indexPath)")
    }
    
    // MARK: UICollectionViewDelegate
}
