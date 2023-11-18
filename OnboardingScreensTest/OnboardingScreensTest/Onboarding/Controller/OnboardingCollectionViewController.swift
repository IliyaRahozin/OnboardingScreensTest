//
//  ViewController.swift
//  OnboardingScreensTest
//
//  Created by Illia Rahozin on 17.11.2023.
//

import UIKit
import RxSwift
import RxCocoa

class OnboardingCollectionViewController: UICollectionViewController {
    
    // MARK: - PROPERTIES
    weak var coordinator: OnboardingCoordinator?
    private let disposeBag = DisposeBag()
    
    var viewModel = OnboardingPageListViewModel([])
        
    private(set) lazy var onboardinPageControllerView =
        OnboardinPageControllerView(viewModel: viewModel)
    
    // MARK: - INIT
    init(pagesData: [OnboardingPage]) {
        viewModel = OnboardingPageListViewModel(pagesData)
        super.init(collectionViewLayout: OnboardingCollectionLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.preservesSuperviewLayoutMargins = true
        setupPurchase()
        configureCollectionView()
        setupPageControllerView()
        setupOnboardingViewTapBindings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureContentInset()
    }

}


// MARK: UICollectionView DataSource/DelegateFlowLayout
extension OnboardingCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    private func configureNavBar() {
        let closeButton = Constant.Builder.closeButton()
        let addButtonObservable = closeButton.rx.tap.asObservable()

        addButtonObservable
            .subscribe(onNext: { [weak self] in
                self?.handleCloseButtonTap()
            })
            .disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem = closeButton
        
        let restorePurchaseButton = Constant.Builder.restorePurchaseButton()
        let customBarButtonItem = UIBarButtonItem(customView: restorePurchaseButton)
        let restorePurchaseButtonObservable = restorePurchaseButton.rx.tap.asObservable()

        restorePurchaseButtonObservable
            .subscribe(
                onNext: { [weak self] in
                    self?.handleRestorePurchase()
                },
               onError: { error in
                    print("Error: \(error)")
                }
            )
            .disposed(by: disposeBag)
        
        navigationItem.leftBarButtonItem = customBarButtonItem
    }
    
    private func handleCloseButtonTap() {
        print("Close button tapped!")
        coordinator?.close()
    }
    
    private func handleRestorePurchase() {
        restorePurchase()
        print("Restore Purchase button tapped!")
    }
    
    private func configureContentInset() {
        if let navigationController = navigationController {
            let topInset = navigationController.navigationBar.frame.size.height
            collectionView?.contentInset.top = -topInset * 2.3
        }
    }
    
    private func cofigureCollectionInset() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = 20
            collectionView?.isPagingEnabled = false
            
            if let collectionView = collectionView {
                let contentInsetLeft = (collectionView.bounds.width - collectionView.bounds.width + 62) / 2
                let contentInsetRight = contentInsetLeft
                collectionView.contentInset = UIEdgeInsets(top: 0, left: contentInsetLeft, bottom: 0, right: contentInsetRight)
            }
        }
    }
    
    private func configureCollectionView() {
        cofigureCollectionInset()
        collectionView.isUserInteractionEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.backgroundView = UIImageView(image: Constant.background)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        
        configureNavBar()
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemInSection(in: section)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
    
        let viewModel = viewModel.getPageForRow(at: indexPath)
        viewModel.pageImage.asDriver(onErrorJustReturn: UIImage())
            .drive(cell.illustrationImageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.pageTitle.asDriver(onErrorJustReturn: "Title")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.pageDescription.asDriver(onErrorJustReturn: "Description")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: disposeBag)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = collectionView.bounds.width - 62
        let height = width * (view.frame.height < 670 ? 1.5 : 1.65)
        
        return CGSize(width: width, height: height)
    }
        
}



// MARK: - PageControll
extension OnboardingCollectionViewController {
    
    func setupPageControllerView() {
        view.addSubviews(onboardinPageControllerView)
        
        onboardinPageControllerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

    }
    
    func setupOnboardingViewTapBindings() {
        onboardinPageControllerView.continueButton.rx.tap
                .subscribe(onNext: { [weak self] in
                    self?.handleNext()
                })
                .disposed(by: disposeBag)
    }
        
    private func handleNext(){
        let nextIndex = min(viewModel.currentPageIndex + 1, viewModel.numberOfItemInSection())

        if nextIndex == viewModel.numberOfItemInSection() {
            handleSubscribe()
        } else {
            handleUpdatePageController(at: nextIndex, aniamteCollection: true)
        }
    }
    
    private func handleSubscribe() {
        print("Free & Sub logic")
        makePayment()
    }
    
    func handleUpdatePageController(at index: Int, aniamteCollection: Bool) {
        viewModel.currentPageIndex = index
        onboardinPageControllerView.updateControllerPosition(index: viewModel.currentPageIndex)
        
        if aniamteCollection {
            let indexPath = IndexPath(item: viewModel.currentPageIndex, section: 0)
            collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
