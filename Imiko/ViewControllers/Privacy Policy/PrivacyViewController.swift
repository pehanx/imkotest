//
//  PrivacyViewController.swift
//  Imiko
//
//  Created by Nikita Spekhin on 02.06.2022.
//

import UIKit
import SnapKit

class PrivacyViewController:UIViewController {
    
    // MARK: - Views
    private let titleLabel = UILabel(text: "Política de Privacidad", font: .boldSystemFont(ofSize: 28), textColor: R.color.primaryText())
    
    private lazy var backButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(R.image.backButton(), for: .normal)
        btn.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return btn
    }()
    
    private let scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let descriptionLabel = UILabel(text: "¿Al contrario del pensamiento popular?\n· el texto de Lorem Ipsum no es simplemente texto aleatorio.\n\n¿Tiene sus raices en una pieza cl´sica de la literatura del Latin?\n· que data del año 45 antes de Cristo, aciendo que este adquiera mas de 2000 años de antiguedad. Richard McClintock, un profesor de Latin de la Universidad de Hampden-Sydney en Virginia, encontró una de las palabras más oscuras de la lengua del latín, \"consecteur\", en un pasaje de.\n\n¿Lorem Ipsum, y al seguir leyendo distintos textos del latín, descubrió la fuente indudable. Lorem Ipsum viene de las secciones?\n1.10.32 y 1.10.33 de \"de Finnibus Bonorum et Malorum\" (Los Extremos del Bien y El Mal) por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", viene de una linea en la sección 1.10.32\n\nEl trozo de texto estándar de Lorem Ipsum usado desde el año 1500 es reproducido debajo para aquellos interesados. Las secciones 1.10.32 y 1.10.33 de \"de Finibus Bonorum et Malorum\" por Cicero son también reproducidas en su forma original exacta, acompañadas por versiones en Inglés de la traducción realizada en 1914 por H. Rackham.", font: .systemFont(ofSize: 16), textColor: R.color.primaryText(), numberOfLines: 0)
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Selectors
    @objc private func handleBack(){
        dismiss(animated: true)
    }
    
    // MARK: - Helpres
    private func setupUI(){
        view.backgroundColor = R.color.mainBackground()
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        view.addSubview(scrollView)
        scrollView.addSubview(descriptionLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(36)
            make.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.width.equalToSuperview().offset(-64)
            make.bottom.greaterThanOrEqualToSuperview().offset(-24)
        }
        
    }
}
