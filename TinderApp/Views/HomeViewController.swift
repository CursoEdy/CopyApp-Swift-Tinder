//
//  HomeViewController.swift
//  TinderApp
//
//  Created by ednardo alves on 17/07/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var users: [User] = [
        User(id: 1, name: "Lucas", age: 27, bio: "Gamer e dev apaixonado por tecnologia.", imageName: "lucas"),
        User(id: 2, name: "Maria", age: 25, bio: "Amo viajar, café e boas conversas.", imageName: "maria"),
        User(id: 3, name: "Rafael", age: 30, bio: "Engenheiro de software e maratonista.", imageName: "rafael")
    ]

    private let likeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        btn.tintColor = .green.withAlphaComponent(0.6)
        return btn
    }()
    
    private let dislikeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "hand.thumbsdown.fill"), for: .normal)
        btn.tintColor = .red.withAlphaComponent(0.6)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutCards()
        setupViews()
    }
    
    private func setupViews() {
        [likeButton, dislikeButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            dislikeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            dislikeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            dislikeButton.widthAnchor.constraint(equalToConstant: 60),
            dislikeButton.heightAnchor.constraint(equalToConstant: 60),

            likeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            likeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            likeButton.widthAnchor.constraint(equalToConstant: 60),
            likeButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func layoutCards() {
        for (index, user) in users.reversed().enumerated() {
            let card = CardView(user: user)
            card.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(card)

            NSLayoutConstraint.activate([
                card.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                card.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                card.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                card.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
            ])

            // Cards mais antigos ficam atrás
            view.sendSubviewToBack(card)
        }
    }
    
    
}
