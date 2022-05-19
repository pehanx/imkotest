//
//  HistoryPaidView.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import Foundation
import UIKit

class HistoryPaidView:UIView {
    
    // MARK: - View
    private var close:((HistoryPaidView)->())?
    private let bgView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return view
    }()
    private let contentView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 0.93)
        return view
    }()
    
    private let titlePriceLabel = UILabel(text: "Pay Préstamo rápido", font: .systemFont(ofSize: 13), textColor: R.color.secondary())
    private let priceLabel = UILabel(font: .systemFont(ofSize: 28), textColor: .label)
    private let dividerView:UIView = {
        let view = UIView()
        view.backgroundColor = R.color.separator()
        return view
    }()
    private let arrowView = UIImageView(image: R.image.arrowForwardSecondary())
    private let sideButtonImageView = UIImageView(image: R.image.sideButton())
    private let sideButtonSubtitle = UILabel(text: "Confirm with Side Button", font: .systemFont(ofSize: 13), textColor: .label, textAlignment: .center)
    
    // MARK: - Lifecycle
    
    init(price:Int, close: @escaping (HistoryPaidView)-> ()) {
        self.close = close
        super.init(frame: .zero)
        priceLabel.text = "$\(price)"
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc private func handleClose(){
        close?(self)
    }
    
    // MARK: - Helpers
    private func setupUI() {
        alpha = 0
        [bgView, contentView].forEach{addSubview($0)}
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(189)
            make.bottom.equalToSuperview()
        }
        bgView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(contentView.snp.top)
        }
        [titlePriceLabel, priceLabel, dividerView, arrowView, sideButtonImageView, sideButtonSubtitle].forEach{contentView.addSubview($0)}
        titlePriceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titlePriceLabel.snp.bottom)
            make.leading.equalToSuperview().offset(16)
        }
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(16)
            make.height.equalTo(1)
            make.width.equalToSuperview()
        }
        arrowView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(34.5)
        }
        sideButtonImageView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        sideButtonSubtitle.snp.makeConstraints { make in
            make.top.equalTo(sideButtonImageView.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleClose)))
    }
}

