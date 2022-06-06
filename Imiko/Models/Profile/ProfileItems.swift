//
//  ProfileItems.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import UIKit

enum ProfileItem:CaseIterable {
    case fio, phone, mail, language
    
    var image:UIImage? {
        switch self {
        case .fio: return R.image.profile.fio()
        case .phone: return R.image.profile.phone()
        case .mail: return R.image.profile.mail()
        case .language: return R.image.profile.language()
        }
    }
    
    var title:String {
        switch self {
        case .fio: return "Cambiar nombre"
        case .phone: return "Cambiar teléfono"
        case .mail: return "Cambiar correo electrónico"
        case .language: return "Cambiar idioma"
        }
    }
    
    var subTitle:String {
        switch self {
        case .fio: return "Cambiar su nombre y apellido"
        case .phone: return "Puedes cambiar tu número de Teléfono"
        case .mail: return "Puedes cambiar tu email"
        case .language: return "Сambiar el idioma de la aplicación"
        }
    }
    
}
