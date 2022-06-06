//
//  HistoryViewContoller.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import UIKit
import DZLabel

class HistoryViewContoller:BaseViewController {
    
    // MARK: - Properties
    private var historyItems = [Credit]()
    
    // MARK: - Views
    private let scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let titleLabel = UILabel(text: "Historial de préstamos", font: .boldSystemFont(ofSize: 28), textColor: R.color.primaryText())
    private let personImageView = UIImageView(image: R.image.historyPerson())
    private lazy var descriptionLabel = UILabel(text: "Todavía no tiene ningún préstamo.\nSacar un préstamo?", font: .systemFont(ofSize: 14), textColor: R.color.primaryText(), numberOfLines: 0, textAlignment: .center)
    
    private lazy var dataStackView:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [personImageView, descriptionLabel])
        stack.spacing = 24
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var applyLoanButton:BaseButton = {
        let btn = BaseButton(title: "Solicitar un préstamo")
        btn.addTarget(self, action: #selector(handleApplyLoan), for: .touchUpInside)
        return btn
    }()
    
    // MARK: -- List
    private lazy var historyCollectionView:HistoryCollectionView = {
        let collectionView = HistoryCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        historyItems = CreditsManager.data
        
        let isHideHistory = self.historyItems.count == 0
        [self.scrollView, self.applyLoanButton].forEach{$0.isHidden = !isHideHistory}
        self.historyCollectionView.isHidden = isHideHistory
        
        DispatchQueue.main.async {
            self.historyCollectionView.reloadData()
        }
    }
    
    // MARK: - Selectors
    @objc private func handleApplyLoan(){
        tabBarController?.selectedIndex = 1
    }
    
    // MARK: - Helpers
    private func setupUI(){
        [titleLabel, applyLoanButton, scrollView,
         historyCollectionView].forEach{bgView.addSubview($0)}
        scrollView.addSubview(dataStackView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.centerX.equalToSuperview()
        }
        
        applyLoanButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalTo(applyLoanButton.snp.top)
        }
        
        dataStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.bottom.greaterThanOrEqualToSuperview().offset(-24)
            make.width.equalToSuperview().offset(-70)
        }
        
        historyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
}

extension HistoryViewContoller: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return historyItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCell.className, for: indexPath) as! HistoryCell
        cell.setupData(historyItems[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width - 36, height: 91)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch historyItems[indexPath.item].type {
        case .notApproved:
            break
        case .considered:
            break
        case .approved:
            break
        }
    }
    
}
