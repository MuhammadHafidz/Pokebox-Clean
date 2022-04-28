//
//  DetailViewController.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var tvName: UILabel!
    @IBOutlet weak var tvType: UILabel!
    @IBOutlet weak var tvHeight: UILabel!
    @IBOutlet weak var tvWeight: UILabel!
    @IBOutlet weak var stackStats: UIStackView!
    @IBOutlet weak var stackAbilities: UIStackView!
    @IBOutlet weak var btnAddFavorite: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: DetailPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
//        print("Data \(presenter?.pokemon)")
        setData()
        presenter?.getFavorite()
        // Do any additional setup after loading the view.
    }
    @IBAction func onClickFavorite(_ sender: Any) {
        if presenter!.isFavorite {
            presenter?.deleteFavorite()
        } else {
            presenter?.addFavorite()
        }
    }
    
}

extension DetailViewController: DetailPresenterToViewProtocol {
    func setData() {
        ivImage.sd_setImage(with: URL(string: "\(PokemonImage.url(id: (presenter?.pokemon.id)!))"))
        tvName.text = presenter?.pokemon.name
        tvType.text = presenter?.pokemon.types.joined(separator: ", ")
        tvHeight.text = "\(presenter?.pokemon.height ?? 0)"
        tvWeight.text = "\(presenter?.pokemon.weight ?? 0)"
        
        for stat in presenter!.pokemon.stats {
            let statView = StatView(frame: CGRect(x: 0, y: 16, width: view.bounds.width, height: 100))
            statView.setData(stat: stat)
            stackStats.addArrangedSubview(statView)
        }
        for ability in presenter!.pokemon.abilities {
            let abilityView = AbilityView(frame: CGRect(x: 0, y: 16, width: view.bounds.width, height: 100))
            abilityView.setData(data: ability)
            stackAbilities.addArrangedSubview(abilityView)
        }
        
    }
    
    func setFavorite() {
        if presenter!.isFavorite {
            btnAddFavorite.configuration?.title = "Delete From Favorite"
            btnAddFavorite.tintColor = UIColor.systemRed
            btnAddFavorite.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 14)
        } else {
            btnAddFavorite.tintColor = UIColor.systemBlue
            btnAddFavorite.configuration?.title = "Add To Favorite"
            btnAddFavorite.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 14)
            
        }
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            print("[Alert closed] - \(message)")
        }
        alert.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
