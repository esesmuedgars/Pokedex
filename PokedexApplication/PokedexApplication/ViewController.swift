//
//  ViewController.swift
//  PokedexApplication
//
//  Created by Edgars Vanags on 02/10/2017.
//  Copyright © 2017 edgarsvanags. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	var pokemon = [Pokemon]()
	
	@IBOutlet weak var collectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		parsePokemonCSV()
	}
	
	func parsePokemonCSV() {
		if let path = Bundle.main.path(forResource: "pokemon", ofType: "csv") {
			
			do {
				let csv = try CSV(contentsOfURL: path)
				let rows = csv.rows
				
				for row in rows {
					if let pokedexId = Int(row["id"]!), let name = row["identifier"] {
						let pokemon = Pokemon(name: name, pokedexId: pokedexId)
						self.pokemon.append(pokemon)
					}
				}
			} catch let err as NSError {
				print(err.debugDescription)
			}
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return pokemon.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokemonCell {
			let pokemon = self.pokemon[indexPath.row]
			cell.configureCell(pokemon: pokemon)
			
			return cell
		} else {
			return UICollectionViewCell()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		//TODO: do smth on selected
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 100, height: 100)
	}
}

