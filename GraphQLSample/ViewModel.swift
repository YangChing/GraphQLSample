//
//  ViewModel.swift
//  GraphQLSample
//
//  Created by 馮仰靚 on 2019/3/18.
//  Copyright © 2019 YCFeng.com.tw. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxApolloClient
import RxOptional

typealias Customer = CustomersQuery.Data.Customer

class ViewModel {

  //output
  var customers = BehaviorRelay<List<Customer>>.init(value: List<Customer>(item: []))

  //input
  let isReloadData = BehaviorRelay<Bool>(value: false)

  var disposBag = DisposeBag()

  init() {
    isReloadData
      .asObservable()
      .filter { $0 }
      .flatMapLatest { _ in
        WebService().getCustomers().asObservable()
      }
      .catchErrorJustReturn(List<Customer>(item: []))
      .map { $0 }
      .bind(to: customers)
      .disposed(by: disposBag)
  }
}

class WebService {
  func getCustomers() -> Single<List<CustomersQuery.Data.Customer>> {
    return ApolloServie.shared.fetch(query: CustomersQuery())
      .map { result in
        List<CustomersQuery.Data.Customer>(item: result.customers?.compactMap{ $0
        } ?? [])
      }.asSingle()
  }
}
