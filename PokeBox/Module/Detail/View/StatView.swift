//
//  StatView.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import UIKit

class StatView: UIView {
    @IBOutlet var contentView: StatView!
    @IBOutlet weak var tvStatTitle: UILabel!
    @IBOutlet weak var tvStatValue: UILabel!
    @IBOutlet weak var pvStat: UIProgressView!
    
    func setData(stat: PokemonStatModel) {
        tvStatTitle.text = stat.name
        tvStatValue.text = "\(stat.value)%"
        let value = Float(stat.value) / 100
        pvStat.setProgress(value, animated: true)
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
        let nib = UINib(nibName: "StatView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
