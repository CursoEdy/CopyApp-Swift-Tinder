//
//  CardView.swift
//  TinderApp
//
//  Created by ednardo alves on 17/07/25.
//

import UIKit

class CardView: UIView {
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let bioLabel = UILabel()
    
    //MARK: Label flutuante
    
    private let likeLabel: UILabel = {
        let label = UILabel()
        label.text = "LIKE"
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .green
        label.alpha = 0
        return label
    }()
    
    private let nopeLabel: UILabel = {
        let label = UILabel()
        label.text = "NOPE"
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .red
        label.alpha = 0
        return label
    }()
    
    init(user: User){
        super.init(frame: .zero)
        setupLayout()
        configure(with: user)
        addGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(with user: User){
        imageView.image = UIImage(named: user.imageName)
        nameLabel.text = "\(user.name), \(user.age)"
        bioLabel.text = user.bio
    }
    
    private func setupLayout() {
        layer.cornerRadius = 16
        clipsToBounds = true
        backgroundColor = .white
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        nameLabel.font = .boldSystemFont(ofSize: 24)
        nameLabel.textColor = .white
        nameLabel.shadowColor = .black
        nameLabel.shadowOffset = CGSize(width: 1, height: 1)
        
        bioLabel.font = .systemFont(ofSize: 16)
        bioLabel.textColor = .white
        bioLabel.numberOfLines = 0
        
        [imageView, nameLabel, bioLabel, likeLabel, nopeLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -48),
            
            bioLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            
            likeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            likeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            
            nopeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            nopeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
    }
    
    private func addGesture() {
        let pan = UIPanGestureRecognizer(target: self , action: #selector(handlePan(_:)))
        addGestureRecognizer(pan)
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        let rotationDegrees = translation.x / 20
        let rotationAngle = rotationDegrees * .pi / 180
        let transform = CGAffineTransform(rotationAngle: rotationAngle).translatedBy(x: translation.x, y: translation.y)
        self.transform = transform
        
        likeLabel.alpha = translation.x > 0 ? min(1, abs(translation.x) / 100) : 0
        nopeLabel.alpha = translation.x < 0 ? min(1, abs(translation.x) / 100) : 0

        if gesture.state == .ended {
            let shouldDismiss = abs(translation.x) > 120
            if shouldDismiss {
                UIView.animate(withDuration: 0.3, animations: {
                    let direction: CGFloat = translation.x > 0 ? 1 : -1
                    self.center.x += 500 * direction
                    self.alpha = 0
                }) { _ in
                    self.removeFromSuperview()
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.transform = .identity
                    self.likeLabel.alpha = 0
                    self.nopeLabel.alpha = 0
                }
            }
        }
    }
}
