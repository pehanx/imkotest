//
//  NewLoanViewController.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import UIKit

class NewLoanViewController:BaseViewController {
    
    // MARK: - Views
    private let titleLabel = UILabel(text: "Nuevo préstamo", font: .boldSystemFont(ofSize: 28), textColor: R.color.primaryText())
    
    // MARK: -- Sum
    private let sumDescriptionLabel = UILabel(text: "¿Cuánto quieres pedir prestado?", font: .systemFont(ofSize: 14), textColor: R.color.primaryText(), textAlignment: .center)
    private lazy var sumMinusButton = PlusMinusButton(type: .minus) {
        self.sumMinusPlus(type: .minus)
    }
    
    private let sumLabel = UILabel(text: "$100", font: .boldSystemFont(ofSize: 28), textColor: R.color.blue(), textAlignment: .center)
    
    private lazy var sumPlusButton = PlusMinusButton(type: .plus) {
        self.sumMinusPlus(type: .plus)
    }
    
    private lazy var sumSlider:UISlider = {
        let slider = UISlider()
        slider.minimumValue = 100
        slider.maximumValue = 1000
        slider.thumbTintColor = R.color.blue()
        slider.tintColor = R.color.blue()
        slider.maximumTrackTintColor = R.color.lightGray()
        slider.addTarget(self, action: #selector(handleChangeSum), for: .valueChanged)
        return slider
    }()
    private lazy var sumStep100 = createStepCircle(isBlue: true)
    private lazy var sumStep1000 = createStepCircle(isBlue: false)
    private let sumStep100Label = UILabel(text: "$100", font: .systemFont(ofSize: 14, weight: .medium), textColor: R.color.primaryText())
    private let sumStep1000Label = UILabel(text: "$1000", font: .systemFont(ofSize: 14, weight: .medium), textColor: R.color.primaryText())
    private lazy var newLoanSumsCollectionView:NewLoanSumsCollectionView = {
        let collectionView = NewLoanSumsCollectionView()
        collectionView.didSelectSum = { [weak self] sum in
            self?.updateSum(sum)
        }
        return collectionView
    }()
    
    // MARK: -- Long
    private let longDescriptionLabel = UILabel(text: "¿Por cuánto tiempo?", font: .systemFont(ofSize: 14), textColor: R.color.primaryText(), textAlignment: .center)
    private lazy var longMinusButton = PlusMinusButton(type: .minus) {
        self.longMinusPlus(type: .minus)
    }
    private let longLabel = UILabel(text: "0 días", font: .boldSystemFont(ofSize: 28), textColor: R.color.blue(), textAlignment: .center)
    private lazy var longPlusButton = PlusMinusButton(type: .plus) {
        self.longMinusPlus(type: .plus)
    }
    private lazy var longSlider:UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 60
        slider.thumbTintColor = R.color.blue()
        slider.tintColor = R.color.blue()
        slider.maximumTrackTintColor = R.color.lightGray()
        slider.addTarget(self, action: #selector(handleChangeLong), for: .valueChanged)
        return slider
    }()
    private lazy var longStep0 = createStepCircle(isBlue: true)
    private lazy var longStep30 = createStepCircle(isBlue: false)
    private lazy var longStep60 = createStepCircle(isBlue: false)
    private let longStep0Label = UILabel(text: "0", font: .systemFont(ofSize: 14, weight: .medium), textColor: R.color.primaryText())
    private let longStep30Label = UILabel(text: "30", font: .systemFont(ofSize: 14, weight: .medium), textColor: R.color.primaryText())
    private let longStep60Label = UILabel(text: "60", font: .systemFont(ofSize: 14, weight: .medium), textColor: R.color.primaryText())
    
    private lazy var submit:BaseButton = {
        let btn = BaseButton(title: "Enviar solicitud")
        btn.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Selectors
    @objc private func handleSubmit(){
        guard let price = getSum, let days = getDays else { return }
        let creditModel = CreditHistoryModel(price: price, days: days, type: .unpaid)
        CreditsManager.shared.save(creditModel)
        let vc = LoanAcceptedViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tabBarController?.selectedIndex = 0
        }
    }
    
    @objc private func handleChangeSum(_ slider:UISlider){
        sumLabel.text = "$" + String(Int(slider.value))
    }
    
    @objc private func handleChangeLong(_ slider:UISlider){
        let daysStr = Int(slider.value) == 1 ? "día" : "días"
        longLabel.text = String(Int(slider.value)) + " " + daysStr
        longStep30.backgroundColor = Int(slider.value) >= 30 ? R.color.blue() : R.color.lightGray()
    }
    
    // MARK: - Helpers
    private func setupUI(){
        [titleLabel, sumDescriptionLabel, sumMinusButton, sumLabel, sumPlusButton, sumSlider, sumStep100Label, sumStep1000Label, newLoanSumsCollectionView, longDescriptionLabel, longMinusButton, longLabel, longPlusButton, longSlider, longStep0Label, longStep30Label, longStep60Label, submit].forEach{bgView.addSubview($0)}
        bgView.insertSubview(sumStep100, belowSubview: sumSlider)
        bgView.insertSubview(sumStep1000, belowSubview: sumSlider)
        bgView.insertSubview(longStep0, belowSubview: longSlider)
        bgView.insertSubview(longStep30, belowSubview: longSlider)
        bgView.insertSubview(longStep60, belowSubview: longSlider)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.centerX.equalToSuperview()
        }
        
        sumDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        sumMinusButton.snp.makeConstraints { make in
            make.top.equalTo(sumDescriptionLabel.snp.bottom).offset(36)
            make.leading.equalToSuperview().offset(61)
        }
        
        sumPlusButton.snp.makeConstraints { make in
            make.centerY.equalTo(sumMinusButton)
            make.trailing.equalToSuperview().offset(-61)
        }
        
        sumLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sumMinusButton)
            make.centerX.equalToSuperview()
        }
        
        sumSlider.snp.makeConstraints { make in
            make.top.equalTo(sumMinusButton.snp.bottom).offset(47)
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().offset(-28)
        }
        
        sumStep100.snp.makeConstraints { make in
            make.centerY.equalTo(sumSlider.snp.centerY)
            make.leading.equalTo(sumSlider.snp.leading)
        }
        
        sumStep1000.snp.makeConstraints { make in
            make.centerY.equalTo(sumSlider.snp.centerY)
            make.trailing.equalTo(sumSlider.snp.trailing)
        }
        
        sumStep100Label.snp.makeConstraints { make in
            make.top.equalTo(sumStep100.snp.bottom).offset(8)
            make.centerX.equalTo(sumStep100.snp.centerX)
        }
        
        sumStep1000Label.snp.makeConstraints { make in
            make.top.equalTo(sumStep1000.snp.bottom).offset(8)
            make.centerX.equalTo(sumStep1000.snp.centerX)
        }
        
        newLoanSumsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sumStep100Label.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(36)
        }
        
        longDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(newLoanSumsCollectionView.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
        }
        
        longMinusButton.snp.makeConstraints { make in
            make.top.equalTo(longDescriptionLabel.snp.bottom).offset(36)
            make.leading.equalToSuperview().offset(61)
        }
        
        longPlusButton.snp.makeConstraints { make in
            make.centerY.equalTo(longMinusButton)
            make.trailing.equalToSuperview().offset(-61)
        }
        
        longLabel.snp.makeConstraints { make in
            make.centerY.equalTo(longMinusButton)
            make.centerX.equalToSuperview()
        }
        
        longSlider.snp.makeConstraints { make in
            make.top.equalTo(longMinusButton.snp.bottom).offset(47)
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().offset(-28)
        }
        
        longStep0.snp.makeConstraints { make in
            make.centerY.equalTo(longSlider.snp.centerY)
            make.leading.equalTo(longSlider.snp.leading)
        }
        
        longStep30.snp.makeConstraints { make in
            make.centerY.equalTo(longSlider.snp.centerY)
            make.centerX.equalTo(longSlider.snp.centerX)
        }
        
        longStep60.snp.makeConstraints { make in
            make.centerY.equalTo(longSlider.snp.centerY)
            make.trailing.equalTo(longSlider.snp.trailing)
        }
        
        longStep0Label.snp.makeConstraints { make in
            make.top.equalTo(longStep0.snp.bottom).offset(8)
            make.centerX.equalTo(longStep0.snp.centerX)
        }
        
        longStep30Label.snp.makeConstraints { make in
            make.top.equalTo(longStep30.snp.bottom).offset(8)
            make.centerX.equalTo(longStep30.snp.centerX)
        }
        
        longStep60Label.snp.makeConstraints { make in
            make.top.equalTo(longStep60.snp.bottom).offset(8)
            make.centerX.equalTo(longStep60.snp.centerX)
        }
        
        submit.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
        }
    }
    
    private func updateSum(_ sum:Int) {
        sumLabel.text = "$\(sum)"
        sumSlider.value = Float(sum)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func updateLong(_ days:Int) {
        let daysStr = days == 1 ? "día" : "días"
        longLabel.text = String(days) + " " + daysStr
        longSlider.value = Float(days)
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.longStep30.backgroundColor = days >= 30 ? R.color.blue() : R.color.lightGray()
        }
    }
    
    private func sumMinusPlus(type:PlusMinusButton.PlusMinus) {
        guard var sum = getSum else { return }
        switch type {
        case .plus:
            sum += 100
            if sum > 1000 {
                sum = 1000
            }
        case .minus:
            sum -= 100
            if sum < 100 {
                sum = 100
            }
        }
        updateSum(sum)
    }
    
    private func longMinusPlus(type:PlusMinusButton.PlusMinus) {
        guard var days = getDays else { return }
        switch type {
        case .plus:
            days += 1
            if days > 60 {
                days = 60
            }
        case .minus:
            days -= 1
            if days < 0 {
                days = 0
            }
        }
        updateLong(days)
    }
    
    private func createStepCircle(isBlue:Bool) -> UIView {
        let view = UIView()
        view.snp.makeConstraints {$0.size.equalTo(14)}
        view.layer.cornerRadius = 7
        view.backgroundColor = isBlue ? R.color.blue() : R.color.lightGray()
        return view
    }
    
    private var getSum:Int? {
        var newSumLabel = sumLabel.text
        newSumLabel?.removeFirst()
        guard let textSum = newSumLabel, let sum = Int(textSum) else { return nil }
        return sum
    }
    
    private var getDays:Int? {
        guard let textLong = longLabel.text?.components(separatedBy: " ")[0], let days = Int(textLong) else { return nil }
        return days
    }
}
