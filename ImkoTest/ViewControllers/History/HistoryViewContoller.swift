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
    private var historyItems = [CreditHistoryModel]()
    
    // MARK: - Views
    private let titleLabel = UILabel(text: "Historial de préstamos", font: .boldSystemFont(ofSize: 28), textColor: R.color.primaryText())
    private let personImageView = UIImageView(image: R.image.historyPerson())
    private lazy var descriptionLabel:DZLabel = {
        let label = DZLabel()
        label.dzFont = .systemFont(ofSize: 14)
        label.dzNumberOfLines = 0
        label.dzTextAlignment = .center
        label.dzTextColor = R.color.primaryText()
        label.dzLinkColor = R.color.blue()!
        label.dzText = "Todavía no tiene ningún préstamo.\nSacar un préstamo?"
        label.dzEnabledTypes = [.regex(pattern: "\\s(Sacar un préstamo?)\\b")]
        label.dzHandleRegexKeywordTap { _ in
            if let url = URL(string: "https://www.google.com/") {
                UIApplication.shared.open(url)
            }
        }
        return label
    }()
    
    private lazy var applyLoan:BaseButton = {
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
        historyItems = CreditsManager.shared.getArray()
        let isHideHistory = self.historyItems.count == 0
        [self.personImageView, self.descriptionLabel, self.applyLoan].forEach{$0.isHidden = !isHideHistory}
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
        [titleLabel,
         personImageView, descriptionLabel, applyLoan,
         historyCollectionView].forEach{bgView.addSubview($0)}
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.centerX.equalToSuperview()
        }
        
        personImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(84)
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(personImageView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }

        applyLoan.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCell.id, for: indexPath) as! HistoryCell
        cell.setupData(historyItems[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width - 36, height: 91)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch historyItems[indexPath.item].type {
        case .paid:
            let alert = UIAlertController(title: "Préstamo ya pagado", message: "Pague el préstamo que aún no ha pagado", preferredStyle: .alert)
            alert.addAction(.init(title: "Listo", style: .default))
            present(alert, animated: true)
        case .unpaid:
            let historyPaidView = HistoryPaidView(price: historyItems[indexPath.item].price) { view in
                UIView.animate(withDuration: 0.3) {
                    view.alpha = 0
                } completion: { finished in
                    if finished {
                        view.removeFromSuperview()
                        self.tabBarController?.tabBar.isHidden = false
                    }
                }
            }
            UIView.animate(withDuration: 0.3) {
                historyPaidView.alpha = 1
            }
            view.addSubview(historyPaidView)
            historyPaidView.frame = view.bounds
            tabBarController?.tabBar.isHidden = true
        }
        
    }
    
}
