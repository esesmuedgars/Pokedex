//
//  PokemonDetailViewController.swift
//  PokedexApplication
//
//  Created by Edgars Vanags on 10/10/2017.
//  Copyright © 2017 edgarsvanags. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
	
	var pokemon: Pokemon!

	@IBOutlet weak var navigationLabel: UILabel!
	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var currentEvolutionImage: UIImageView!
	@IBOutlet weak var nextEvolutionImage: UIImageView!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var typeLabel: UILabel!
	@IBOutlet weak var defenceLabel: UILabel!
	@IBOutlet weak var heightLabel: UILabel!
	@IBOutlet weak var pokedexIdLabel: UILabel!
	@IBOutlet weak var weightLabel: UILabel!
	@IBOutlet weak var baseAttackLabel: UILabel!
	@IBOutlet weak var evolutionLabel: UILabel!
	
	@IBAction func backButtonPressed(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		navigationLabel.text = pokemon.name.capitalized
		containerView.layer.cornerRadius = 10
		
		pokemon.downloadPokemonDetail() {
			self.updateUI()
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	func updateUI() {
		currentEvolutionImage.image = UIImage(named: String(pokemon.pokedexId))
		nextEvolutionImage.image = UIImage(named: pokemon.nextEvolution)
		descriptionLabel.text = pokemon.description
		typeLabel.text = pokemon.type
		defenceLabel.text = String(pokemon.defense)
		heightLabel.text = pokemon.height
		pokedexIdLabel.text = String(pokemon.pokedexId)
		weightLabel.text = pokemon.weight
		baseAttackLabel.text = String(pokemon.baseAttack)
		evolutionLabel.text = pokemon.nextEvolutionString
	}
}
