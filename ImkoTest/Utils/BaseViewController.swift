//
//  BaseViewController.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import RxSwift
import RxCocoa
import UIKit

class BaseViewController: UIViewController {

    // MARK: - Properties
    var canCloseKeyboard: Bool {return true}
    let disposeBag = DisposeBag()
    
    // MARK: - Views
    let bgView:UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 28
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if canCloseKeyboard {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(tapGesture)
            tapGesture.cancelsTouchesInView = false
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func hideKeyboard() {
        view.endEditing(false)
    }
    
    // MARK: - Helpers
    private func setupUI(){
        view.backgroundColor = R.color.darkBlue()
        bgView.backgroundColor = R.color.mainBackground()
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
