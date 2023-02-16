//
//  PreviewRecipeViewController.swift
//  tayasui-test
//
//  Created by Lucien Brun on 16/02/2023.
//

import UIKit

/// This view controller previews the recipe
class PreviewRecipeViewController: UIViewController {
    private let titleLabel = UILabel()
    private let containerImageView = UIView()
    private let imageView = UIImageView()
    private let ingredientsView = UIView()
    private let ingredientsTitleLabel = UILabel()
    private let ingredientsLabel = UILabel()
    
    private let imageViewHeight: CGFloat = 336
    
    
    init(recipe: Recipe) {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .secondarySystemBackground
        
        // Set up title label
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.text = recipe.name
        
        // Set up image view
        imageView.contentMode = .scaleAspectFill
        imageView.image = recipe.image
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        
        // Set up ingredients view
        ingredientsTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        ingredientsTitleLabel.text = "Ingrédients"
        ingredientsLabel.font = UIFont.systemFont(ofSize: 17)
        ingredientsLabel.numberOfLines = 0
        ingredientsLabel.text = recipe.ingredients
        
        // Add subviews and constraints
        view.addSubview(titleLabel)
        view.addSubview(containerImageView)
        containerImageView.addSubview(imageView)
        view.addSubview(ingredientsView)
        ingredientsView.addSubview(ingredientsTitleLabel)
        ingredientsView.addSubview(ingredientsLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerImageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
            
            // Container image view constraints
            containerImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            containerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            containerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
            
            // Image view constraints
            imageView.topAnchor.constraint(equalTo: containerImageView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerImageView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerImageView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageViewHeight),
            
            // Ingredients view constraints
            ingredientsView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            ingredientsView.leadingAnchor.constraint(equalTo: containerImageView.leadingAnchor, constant: 8),
            ingredientsView.trailingAnchor.constraint(equalTo: containerImageView.trailingAnchor, constant: 8),
            ingredientsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 16),
            
            // Ingredients title label constraints
            ingredientsTitleLabel.topAnchor.constraint(equalTo: ingredientsView.topAnchor, constant: 8),
            ingredientsTitleLabel.leadingAnchor.constraint(equalTo: ingredientsView.leadingAnchor),
            ingredientsTitleLabel.trailingAnchor.constraint(equalTo: ingredientsView.trailingAnchor),
            
            // Ingredients label constraints
            ingredientsLabel.topAnchor.constraint(equalTo: ingredientsTitleLabel.bottomAnchor, constant: 8),
            ingredientsLabel.leadingAnchor.constraint(equalTo: ingredientsView.leadingAnchor),
            ingredientsLabel.trailingAnchor.constraint(equalTo: ingredientsView.trailingAnchor),
            ingredientsLabel.bottomAnchor.constraint(equalTo: ingredientsView.bottomAnchor, constant: 8)
        ])        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Update preferredContentSize to fit all content
        let targetSize = CGSize(width: view.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        let size = view.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        preferredContentSize = size
    }
}
