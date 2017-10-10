//
//  Pokemon.swift
//  PokedexApplication
//
//  Created by Edgars Vanags on 02/10/2017.
//  Copyright © 2017 edgarsvanags. All rights reserved.
//

import Foundation

class Pokemon {
	private var _name: String!
	private var _pokedexId: Int!
	
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
	
	init(name: String, pokedexId: Int) {
		self._name = name
		self._pokedexId = pokedexId
	}
}

extension String {
	public mutating func clear() {
		self = ""
	}
}
