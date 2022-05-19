//
//  KeyboardHeightObservable.swift
//  ImkoTest
//
//  Created by Nikita Spekhin on 19.05.2022.
//

import RxSwift
import RxCocoa

typealias KeyboardHeightInfo = (CGFloat, TimeInterval)

func keyboardHeight() -> Driver<KeyboardHeightInfo> {
  return Observable
    .from([
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
        .map { notification -> KeyboardHeightInfo in
          let userInfo = notification.userInfo
            let value = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
            let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0
          return (value, animationDuration)
      },
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
        .map { notification -> KeyboardHeightInfo in
          let userInfo = notification.userInfo
            let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0
          return (0, animationDuration)
      }
      ])
    .merge()
    .asDriver(onErrorDriveWith: Driver.never())
}
