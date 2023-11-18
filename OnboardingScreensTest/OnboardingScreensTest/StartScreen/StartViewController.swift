//
//  StartVC.swift
//  OnboardingScreensTest
//
//  Created by Illia Rahozin on 18.11.2023.
//

import UIKit
import SnapKit
import RxSwift

class StartViewController: UIViewController {
    
    weak var coordinator: StartCoordinator?
    private let disposeBag = DisposeBag()
    
    private lazy var presentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Present", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(presentButton)
        presentButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        let buttonTapObservable = presentButton.rx.tap.asObservable()
        
        buttonTapObservable.subscribe(onNext: { [weak self] in
            self?.coordinator?.showOnboarding()
        }).disposed(by: disposeBag)
    }

}
