//
//  Pokemon.swift
//  PokedexApplication
//
//  Created by Edgars Vanags on 02/10/2017.
//  Copyright © 2017 edgarsvanags. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
	private var _name: String!
	private var _pokedexId: Int!
	
	private var _description: String!
	private var _type: String!
	private var _defense: Int!
	private var _height: String!
	private var _weight: String!
	private var _baseAttack: Int!
	private var _nextEvolution: String!
	private var _nextEvolutionString: String!
	
	private var _pokemonURL: String!
	
	var name: String {
		get {
			return _name
		}
		set {
			_name = newValue
		}
	}
	
	var pokedexId: Int {
		get {
			return _pokedexId
		}
		set {
			_pokedexId = newValue
		}
	}
	
	var description: String {
		get {
			if _description == nil {
				_description = "Pokémon has no description!"
			}
			return _description
		}
		set {
			_description = newValue
		}
	}
	
	var type: String {
		get {
			if _type == nil {
				_type = "Typeless"
			}
			return _type
		}
		set {
			_type = newValue
		}
	}
	
	var defense: Int {
		get {
			if _defense == nil {
				_defense = 0
			}
			return _defense
		}
		set {
			_defense = newValue
		}
	}
	
	var height: String {
		get {
			if _height == nil {
				_height = String(0)
			}
			return _height
		}
		set {
			_height = newValue
		}
	}
	
	var weight: String {
		get {
			if _weight == nil {
				_weight = String(0)
			}
			return _weight
		}
		set {
			_weight = newValue
		}
	}
	
	var baseAttack: Int {
		get {
			if _baseAttack == nil {
				_baseAttack = 0
			}
			return _baseAttack
		}
		set {
			_baseAttack = newValue
		}
	}
	
	var nextEvolution: String {
		get {
			if _nextEvolution == nil {
				_nextEvolution = "back"
			}
			return _nextEvolution
		}
		set {
			_nextEvolution = newValue
		}
	}
	
	var nextEvolutionString: String {
		get {
			if _nextEvolutionString == nil {
				_nextEvolutionString = "Pokémon is fully evolved!"
			}
			return _nextEvolutionString
		}
		set {
			_nextEvolutionString = "Next Evolution: \(newValue)!"
		}
	}
	
	init(name: String, pokedexId: Int) {
		self.name = name
		self.pokedexId = pokedexId
		
		self._pokemonURL = BASE_URL + URL_POKEMON + String(self.pokedexId)
	}
	
	func downloadPokemonDetail(completed: @escaping DownloadComplete) {
		Alamofire.request(_pokemonURL).responseJSON {
			if let dict = $0.result.value as? Dictionary<String, Any> {
				
				if let weight = dict["weight"] as? String {
					self.weight = weight
				}
				
				if let height = dict["height"] as? String {
					self.height = height
				}
				
				if let baseAttack = dict["attack"] as? Int {
					self.baseAttack = baseAttack
				}
				
				if let defense = dict["defense"] as? Int {
					self.defense = defense
				}
				
				if let types = dict["types"] as? [Dictionary<String, Any>], types.count > 0 {
					var typeArray = [String]()
					for item in types {
						if let type = item["name"] as? String {
							typeArray.append(type.capitalized)
							
						}
					}
					self.type = typeArray.joined(separator: "/")
				}
				
				if let evolutions = dict["evolutions"] as? [Dictionary<String, Any>], evolutions.count > 0,
					let url = evolutions[0]["resource_uri"] as? String {
					let stringURL = BASE_URL + url
					Alamofire.request(stringURL).responseJSON {
						if let dict = $0.result.value as? Dictionary<String, Any> {
							
							if let nextEvolution = dict["pkdx_id"] as? Int {
								if nextEvolution < 718 {
									self.nextEvolution = String(nextEvolution)
								}
							}
							
							if let evolvingTo = dict["name"] as? String {
								if evolvingTo.range(of: "mega") == nil {
									self.nextEvolutionString = evolvingTo
								}
							}
						}
						completed()
					}
				}
				
				if let descriptions = dict["descriptions"] as? [Dictionary<String, String>], descriptions.count > 0 {
					if let url = descriptions[0]["resource_uri"] {
						let stringURL = BASE_URL + url
						Alamofire.request(stringURL).responseJSON {
							if let dict = $0.result.value as? Dictionary<String, Any> {
								
								if let description = dict["description"] as? String {
									self.description = description.replacingOccurrences(of: "POKMON", with: "Pokémon")
								}
							}
							completed()
						}
					}
				}
			}
			completed()
		}
	}
}

