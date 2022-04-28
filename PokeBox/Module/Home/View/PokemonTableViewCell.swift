//
//  PokemonTableViewCell.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var mainCard: UIView!
    @IBOutlet weak var tvNumber: UILabel!
    @IBOutlet weak var tvName: UILabel!
    @IBOutlet weak var tvType: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    
    private var color: UIColor?
    
    static let identifier = "pokemonTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainCard.dropShadow()
    }
    
    func setDataToCard(data: PokemonModel) {
        tvNumber.text = "#\(String(format: "%03d", data.id))"
        tvName.text = data.name
        tvType.text = data.types.joined(separator: ", ")
        ivImage.sd_setImage(with: URL(string: "\(PokemonImage.url(id: data.id))")) 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
