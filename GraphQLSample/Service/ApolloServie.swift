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
  var token: String?
  private var _client: ApolloClient? // 有token的client
  private var _noTokenClient = ApolloClient(networkTransport: HTTPNetworkTransport(url: URL(string: "https://ps.larvata.tw/graphql")!)) // 沒有token的client

  var client: ApolloClient {
    if let client = _client { // 預先傳回有token的client
      return client
    } else if let token = token { // 有token但是_client是nil
      let configuration = URLSessionConfiguration.default
      // Add additional headers as needed
      let url = URL(string: "https://ps.larvata.tw/graphql")!
      configuration.httpAdditionalHeaders = ["X-CSRF-Token" : token] // Replace `<token>`
      let client = ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))

      _client = client

      return client
    } else { // 傳回沒token的client
      return _noTokenClient
    }
  }

  func fetch<Query: GraphQLQuery>(query: Query,
                                  cachePolicy: CachePolicy = .returnCacheDataElseFetch,
                                  queue: DispatchQueue = DispatchQueue.main) -> Observable<Query.Data> {
    return self.client.rx
      .fetch(query: query,
             cachePolicy: cachePolicy,
             queue: queue)
  }

  func perform<Mutation: GraphQLMutation>(mutation: Mutation, queue: DispatchQueue = DispatchQueue.main) -> Observable<Mutation.Data> {
    return self.client.rx
      .perform(mutation: mutation, queue: queue)
  }

}
