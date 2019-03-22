//
//  ApolloServie.swift
//  GraphQLSample
//
//  Created by 馮仰靚 on 2019/3/18.
//  Copyright © 2019 YCFeng.com.tw. All rights reserved.
//

import Foundation
import Apollo
import RxSwift
import RxCocoa

class ApolloServie {
  static let shared = ApolloServie()
  let client: ApolloClient

  init() {
    client = {
      let configuration = URLSessionConfiguration.default
      // Add additional headers as needed
//         let token = "grA+nPkqU/ev3SuJWPVNTP1VJF9BQtZ7PzW7J5DUL1tqsVMgY4HA2f5SKKE4+iDJdY4YXTPmYU3X4Xlv5dsZFQ=="
//      configuration.httpAdditionalHeaders = ["X-CSRF-Token" : token] // Replace `<token>`
      let url = URL(string: "https://ps.larvata.tw/graphql")!
      return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
  }

  func fetch<Query: GraphQLQuery>(query: Query,
                                  cachePolicy: CachePolicy = .returnCacheDataElseFetch,
                                  queue: DispatchQueue = DispatchQueue.main) -> Observable<Query.Data> {
    return self.client.rx
      .fetch(query: query,
             cachePolicy: cachePolicy,
             queue: queue)
  }

}
