//  This file was automatically generated and should not be edited.

import Apollo

public final class CustomersQuery: GraphQLQuery {
  public let operationDefinition =
    "query Customers {\n  customers {\n    __typename\n    name\n    address\n    email\n    created_at\n    id\n    phone\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("customers", type: .list(.object(Customer.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(customers: [Customer?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "customers": customers.flatMap { (value: [Customer?]) -> [ResultMap?] in value.map { (value: Customer?) -> ResultMap? in value.flatMap { (value: Customer) -> ResultMap in value.resultMap } } }])
    }

    /// 顧客
    public var customers: [Customer?]? {
      get {
        return (resultMap["customers"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Customer?] in value.map { (value: ResultMap?) -> Customer? in value.flatMap { (value: ResultMap) -> Customer in Customer(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Customer?]) -> [ResultMap?] in value.map { (value: Customer?) -> ResultMap? in value.flatMap { (value: Customer) -> ResultMap in value.resultMap } } }, forKey: "customers")
      }
    }

    public struct Customer: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("address", type: .scalar(String.self)),
        GraphQLField("email", type: .scalar(String.self)),
        GraphQLField("created_at", type: .scalar(String.self)),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("phone", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String? = nil, address: String? = nil, email: String? = nil, createdAt: String? = nil, id: GraphQLID, phone: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "name": name, "address": address, "email": email, "created_at": createdAt, "id": id, "phone": phone])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// 姓名
      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// 戶籍地址
      public var address: String? {
        get {
          return resultMap["address"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "address")
        }
      }

      /// 電子信箱
      public var email: String? {
        get {
          return resultMap["email"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      /// 建立於
      public var createdAt: String? {
        get {
          return resultMap["created_at"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "created_at")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      /// 手機號碼
      public var phone: String? {
        get {
          return resultMap["phone"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "phone")
        }
      }
    }
  }
}