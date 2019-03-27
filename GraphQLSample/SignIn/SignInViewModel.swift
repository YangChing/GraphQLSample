//
//  SignInViewModel.swift
//  GraphQLSample
//
//  Created by 馮仰靚 on 2019/3/26.
//  Copyright © 2019 YCFeng.com.tw. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxApolloClient
import RxOptional

//protocol SignInViewModelInOut {
//  //input:
//  var email: AnyObserver<String> { get set }
//
//  //output:
//  var
//}


class SignInViewModel {

  //input
  let email = BehaviorRelay<String?>(value: nil)
  let password = BehaviorRelay<String?>(value: nil)
  let submit = PublishSubject<Void>()
  //output
  let isSignInButtonEnabled = BehaviorSubject<Bool>(value: false)
  let loginResult = PublishSubject<Result<Void, Error>>()

  private let disposeBag = DisposeBag()
  private var token: String?

  func bind() {
    Observable
      .combineLatest(email, password) {
        return ($0?.isNotEmpty ?? false) && ($1?.isNotEmpty ?? false)
      }
      .bind(to: isSignInButtonEnabled)
      .disposed(by: disposeBag)

    submit
      .map { [unowned self] _ -> (email: String, password: String) in
        self.checkLoginInfo()
      }
      .flatMap {
        WebService.shared
          .signIn(email: $0.email, password: $0.password)
          .do(onSuccess: { [unowned self] in
            self.token = $0.token
            ApolloServie.shared.token = $0.token
          })
          .map { _ -> Result<Void, Error> in
            Result<Void, Error>.success(())
          }
          .catchError {
            .just(Result<Void, Error>.failure($0))
        }
      }
      .debug()
      .bind(to: loginResult)
      .disposed(by: disposeBag)
  }

  private func checkLoginInfo() -> (email: String, password: String) {
    guard let email = self.email.value else {
      return ("", "")
    }
    guard let password = self.password.value else {
      return ("", "")
    }
    return (email, password)
  }
  
}
