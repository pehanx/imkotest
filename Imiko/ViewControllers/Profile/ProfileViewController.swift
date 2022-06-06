//
//  ProfileViewController.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import Foundation
import UIKit

class ProfileViewController:BaseViewController {
    
    // MARK: - Properties
    private var items:[ProfileItem] = [.fio, .phone, .mail]
    
    // MARK: - Views
    private lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProfileHeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeaderViewCell.className)
        collectionView.register(ProfileItemCollectionViewCell.self, forCellWithReuseIdentifier: ProfileItemCollectionViewCell.className)
        collectionView.contentInset.bottom = 24
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(forName: .refreshProfile, object: nil, queue: nil) { [weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Helpers
    private func setupUI(){
        bgView.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
}

// MARK: - UICollectionViewDataSource
extension ProfileViewController:UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileItemCollectionViewCell.className, for: indexPath) as! ProfileItemCollectionViewCell
        cell.setupData(items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeaderViewCell.className, for: indexPath) as! ProfileHeaderViewCell
        header.setupData(ProfileManager.data)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let profile = ProfileManager.data else { return }
        switch items[indexPath.item] {
            
        case .fio:
            let vc = SettingsNameViewController(profile)
            navigationController?.pushViewController(vc, animated: true)
        case .phone:
            let vc = SettingsPhoneViewController(profile)
            navigationController?.pushViewController(vc, animated: true)
        case .mail:
            let vc = SettingsMailViewController(profile)
            navigationController?.pushViewController(vc, animated: true)
        default: break
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.size.width - 36, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.size.width
        let dummyCell = ProfileHeaderViewCell(frame: .init(x: 0, y: 0, width: width, height: 1000))
        dummyCell.setupData(ProfileManager.data)
        return size(dummyCell: .cellHeader(dummyCell), width: width)
    }
}
