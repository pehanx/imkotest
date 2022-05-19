//
//  NewLoanSumsCollectionView.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import UIKit

class NewLoanSumsCollectionView:UICollectionView  {
    
    private let sums:[Int] = stride(from: 100, to: 1001, by: 100).map{$0}
    var didSelectSum: ((Int) -> ())?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI(){
        register(NewLoanSumCell.self, forCellWithReuseIdentifier: NewLoanSumCell.id)
        delegate = self
        dataSource = self
        contentInset = .init(top: 0, left: 18, bottom: 0, right: 18)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
}

extension NewLoanSumsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewLoanSumCell.id, for: indexPath) as! NewLoanSumCell
        cell.titleLabel.text = "$\(sums[indexPath.item])"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dummyCell = NewLoanSumCell(frame: .init(x:0, y: 0, width: 1000, height: 1000))
        dummyCell.titleLabel.text = "$\(sums[indexPath.item])"
        dummyCell.layoutIfNeeded()
        let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: 1000, height: 1000))
        let width = estimatedSize.width
        return .init(width: width, height: bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectSum?(sums[indexPath.item])
    }
}

class NewLoanSumCell:UICollectionViewCell {
    
    // MARK: - Properties
    static let id = String(describing: NewLoanSumCell.self)
    
    // MARK: - Views
    let titleLabel = UILabel(font: .systemFont(ofSize: 14, weight: .medium), textColor: R.color.primaryText())
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI(){
        layer.cornerRadius = 6
        clipsToBounds = true
        contentView.backgroundColor = R.color.lightGray()
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 9, left: 20, bottom: 9, right: 20))
        }
    }
}
