//
//  PokemonCell.swift
//  PokedexApplication
//
//  Created by Edgars Vanags on 02/10/2017.
//  Copyright © 2017 edgarsvanags. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
	
	@IBOutlet weak var pokemonImage: UIImageView!
	@IBOutlet weak var pokemonName: UILabel!
	
	var pokemon: Pokemon!
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		layer.cornerRadius = 5.0
	}
	
	func configureCell(pokemon: Pokemon) {
		self.pokemon = pokemon
		
		pokemonName.text = self.pokemon.name.capitalized
		pokemonImage.image = UIImage(named: String(self.pokemon.pokedexId))
	}
}
