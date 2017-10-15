//
//  ViewController.swift
//  PokedexApplication
//
//  Created by Edgars Vanags on 02/10/2017.
//  Copyright © 2017 edgarsvanags. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
	
	let defaults = UserDefaults.standard
	
	var pokemon = [Pokemon]()
	var filteredPokemon = [Pokemon]()
	var searching = false
	var musicPlayer: AVAudioPlayer!

	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var musicButton: UIButton!
	@IBOutlet weak var searchBar: UISearchBar!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		defaults.register(defaults: ["MusicShouldPlay": true])
		defaults.register(defaults: ["MusicButtonAlpha": 1.0])
		
		parsePokemonCSV()
		setupSearchBar()
		initAudio()
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
	
	func setupSearchBar() {
		if let textField = self.searchBar.value(forKey: "searchField") as? UITextField,
			let iconView = textField.leftView as? UIImageView {
			iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
			iconView.tintColor = .white
			textField.clearButtonMode = .never
		}
	}
	
	func initAudio() {
		if let path = Bundle.main.path(forResource: "music", ofType: "mp3") {
			
			do {
				if let url = URL(string: path) {
					musicPlayer = try AVAudioPlayer(contentsOf: url)
					musicPlayer.prepareToPlay()
					musicPlayer.numberOfLoops = -1
					
					musicButton.alpha = CGFloat(defaults.double(forKey: "MusicButtonAlpha"))
					if (defaults.bool(forKey: "MusicShouldPlay")) && (defaults.double(forKey: "MusicButtonAlpha") == 1.0) {
						musicPlayer.play()
					}
				}
			} catch let err as NSError {
				print(err.debugDescription)
			}
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if searching {
			return filteredPokemon.count
		}
		return pokemon.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokemonCell {
			
			let pokemon: Pokemon!
			
			if searching {
				pokemon = self.filteredPokemon[indexPath.row]
			} else {
				pokemon = self.pokemon[indexPath.row]
			}
			cell.configureCell(pokemon: pokemon)
			
			return cell
		} else {
			return UICollectionViewCell()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		var pokemon: Pokemon!
		if searching {
			pokemon = self.filteredPokemon[indexPath.row]
		} else {
			pokemon = self.pokemon[indexPath.row]
		}
		performSegue(withIdentifier: "PokemonDetailSegue", sender: pokemon)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 100, height: 100)
	}
	
	@IBAction func musicButtonPressed(_ sender: UIButton) {
		if musicPlayer.isPlaying {
			musicPlayer.pause()
			sender.alpha = 0.2
			
			defaults.set(false, forKey: "MusicShouldPlay")
			defaults.set(0.2, forKey: "MusicButtonAlpha")
		} else {
			musicPlayer.play()
			sender.alpha = 1.0
			
			defaults.set(true, forKey: "MusicShouldPlay")
			defaults.set(1.0, forKey: "MusicButtonAlpha")
		}
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		view.endEditing(true)
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText.isEmpty {
			searching = false
			view.endEditing(true)
		} else {
			searching = true
			filteredPokemon = pokemon.filter({ $0.name.range(of: searchText.lowercased()) != nil })
		}
		collectionView.reloadData()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "PokemonDetailSegue" {
			if let PokemonDetailVC = segue.destination as? PokemonDetailViewController,
				let pokemon = sender as? Pokemon {
				PokemonDetailVC.pokemon = pokemon
			}
		}
	}
}

