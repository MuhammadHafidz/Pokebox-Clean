//
//  FavoriteViewController.swift
//  PokeBox
//
//  Created by Enygma System on 27/04/22.
//

import UIKit

class FavoriteViewController: UIViewController {
    @IBOutlet weak var favoriteTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: FavoritePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        presenter?.view = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        presenter?.getData()
    }
  
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func registerTableView() {
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        
        favoriteTableView.register(
            UINib(nibName: "PokemonTableViewCell", bundle: nil),
            forCellReuseIdentifier: PokemonTableViewCell.identifier
        )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presenter?.pokemonData.count == 0 && activityIndicator.isHidden {
            tableView.setEmptyView(title: "Pokemon not Found", message: "")
        } else {
            tableView.restore()
        }
        
        return self.presenter?.pokemonData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: PokemonTableViewCell.identifier,
            for: indexPath) as? PokemonTableViewCell {
            let data = presenter?.pokemonData[indexPath.row]
            cell.setDataToCard(data: data!)
            
            let contentViewTap = CustomTapGesture(target: self, action: #selector(self.openDetail))
            contentViewTap.id = indexPath.row
            cell.rootView.addGestureRecognizer(contentViewTap)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    @objc private func openDetail(sender: CustomTapGesture) {
        presenter?.toDetail(index: sender.id, navigationControll: navigationController)
        tabBarController?.tabBar.isHidden = true
    }

}

extension FavoriteViewController: FavoritePresenterToViewProtocol {
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
    
    func updateTableView() {
        favoriteTableView.reloadData()
    }
    
}
