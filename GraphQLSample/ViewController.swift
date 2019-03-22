//
//  ViewController.swift
//  GraphQLSample
//
//  Created by 馮仰靚 on 2019/3/18.
//  Copyright © 2019 YCFeng.com.tw. All rights reserved.
//

import UIKit
import RxOptional
import RxSwift
import RxCocoa
import FLEX

class ViewController: UIViewController {

  var viewModel: ViewModel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var refresh: UIBarButtonItem!
  var disposBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.viewModel = ViewModel()
//    FLEXManager.shared()?.showExplorer()
    bindRefresh()
    bindTableView()
  }

  private func bindRefresh() {
    refresh.rx.tap
    .throttle(0.3, scheduler: MainScheduler.instance)
    .map { true }
    .bind(to: viewModel.isReloadData)
    .disposed(by: disposBag)
  }

  private func bindTableView() {
    viewModel.customers
      .map{ $0.item }
      .bind(to: tableView.rx.items)
      { (tableView, row, element) in
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = "name：\(element.name ?? "nil") \naddress: \(element.address ?? "nil") \nemail: \(element.email ?? "nil")"
        cell.textLabel?.numberOfLines = 3
        return cell
      }
      .disposed(by: disposBag)
  }

}


