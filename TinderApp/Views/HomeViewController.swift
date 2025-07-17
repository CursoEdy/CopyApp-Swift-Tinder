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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutCards()
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
