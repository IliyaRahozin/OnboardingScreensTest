//
//  CollectionViewCell.swift
//  OnboardingScreensTest
//
//  Created by Illia Rahozin on 17.11.2023.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    
    // MARK: - PROPERTIES
    
    lazy var illustrationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "titleLabel"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .titleText
        label.minimumScaleFactor = 0.5
        label.lineBreakMode = .byClipping
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "descriptionLabel"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .descriptionText
        label.lineBreakMode = .byClipping
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundPage
        view.layer.cornerRadius = 20
        return view
    }()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CollectionViewCell {
    
    private func setupViews() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let stackview = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackview.distribution = .fill
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.spacing = 10
        
        containerView.addSubviews(
            illustrationImageView,
            stackview
        )
        
        illustrationImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(illustrationImageView.snp.width).multipliedBy(1.12)
        }
        
        stackview.snp.makeConstraints { make in
            make.top.equalTo(illustrationImageView.snp.bottom).offset(10)
            make.left.right.equalTo(illustrationImageView)
            make.bottom.lessThanOrEqualToSuperview().inset(10)
            
        }
    }
    
}
