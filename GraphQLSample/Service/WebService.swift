//
//  WebService.swift
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

class WebService {


  static var shared = WebService()

  func getCustomers() -> Single<List<CustomersQuery.Data.Customer>> {
    return ApolloServie.shared.fetch(query: CustomersQuery())
      .map { result in
        List<CustomersQuery.Data.Customer>(item: result.customers?.compactMap{ $0
          } ?? [])
      }.asSingle()
  }

  func signIn(email: String, password: String) -> Single<SignInUserMutation.Data.SignInUser> {
    return ApolloServie.shared
      .perform(mutation: SignInUserMutation(email: email, password: password))
      .map({ (result) -> SignInUserMutation.Data.SignInUser in
        guard let signInUser = result.signInUser else {
          throw NSError(domain: "signInUser not found", code: 0, userInfo: nil)
        }
        return signInUser
      }).asSingle()
  }

  func getUsers() -> Single<List<UsersQuery.Data.User>> {
    return ApolloServie.shared.fetch(query: UsersQuery())
      .map({ (result)  in
        List<UsersQuery.Data.User>(item: result.users?.compactMap{ $0
          } ?? [])
      })
      .asSingle()
  }

}
