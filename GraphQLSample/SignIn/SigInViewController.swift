//
//  SigInViewController.swift
//  GraphQLSample
//
//  Created by 馮仰靚 on 2019/3/26.
//  Copyright © 2019 YCFeng.com.tw. All rights reserved.
//

import Foundation
import UIKit
import RxOptional
import RxSwift
import RxCocoa
import WebKit

class SignInViewController: UIViewController {

  var viewModel: SignInViewModel!
  let wkWebView = WKWebView.init(frame: CGRect.init(x: 0, y: 300, width: 500, height: 600))

  @IBOutlet weak var email: UITextField!
  @IBOutlet weak var password: UITextField!
  @IBOutlet weak var signInButton: UIButton!

  let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    wkWebView.loadHTMLString("<p><a href=\"https://nippon.car-rental.jp/globals/cn_index/\"><img src=\"https://i.froala.com/assets/photo7.jpg\" data-id=\"7\" data-type=\"image\" data-name=\"Image 2019-02-10 at 06:02:57.jpg\" style=\"width: 300px;\" class=\"fr-fic fr-dib\">https://nippon.car-rental.jp/globals/cn_index/</a></p>", baseURL: nil)
    wkWebView.isOpaque = false
    wkWebView.backgroundColor = .black
    self.view.addSubview(wkWebView)
    viewModel = SignInViewModel()

    email.rx
      .text
      .bind(to: viewModel.email)
      .disposed(by: disposeBag)

    password.rx
      .text
      .bind(to: viewModel.password)
      .disposed(by: disposeBag)

    signInButton.rx
      .tap
      .throttle(0.3, scheduler: MainScheduler.instance)
      .map { Void() }
      .bind(to: viewModel.submit)
      .disposed(by: disposeBag)

    viewModel
      .isSignInButtonEnabled
      .bind(to: signInButton.rx.isEnabled)
      .disposed(by: disposeBag)

    viewModel.loginResult
      .subscribe(onNext: { print($0)
        switch $0 {
        case .success:
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let vc = storyboard.instantiateViewController(withIdentifier: "Main")
          self.navigationController?.pushViewController(vc, animated: true)
        case .failure(let error):
          self.showAlert(title: "登入失敗")
          print(error)
        }
      })
      .disposed(by: disposeBag)

    viewModel.bind()
  }

  func showAlert(title: String) {

    let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "確認", style: .default, handler: { (action: UIAlertAction!) in

    }))
    self.present(alert, animated: true, completion: nil)
  }

}
