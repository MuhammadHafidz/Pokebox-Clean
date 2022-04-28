//
//  AbilityView.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import UIKit

class AbilityView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tvAbilityTitle: UILabel!
    @IBOutlet weak var tvAbilityDesc: UILabel!
    
    func setData(data: PokemonAbilityModel) {
        tvAbilityTitle.text = data.name
        tvAbilityDesc.text = data.effect.joined(separator: " \n ")
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "AbilityView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }

}
