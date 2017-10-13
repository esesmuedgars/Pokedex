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
	private var _description: String!
	private var _type: String!
	private var _defence: Int!
	private var _height: Int!
	private var _weight: Int!
	private var _baseAttack: Int!
	private var _nextEvolutionString: String!
	
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
