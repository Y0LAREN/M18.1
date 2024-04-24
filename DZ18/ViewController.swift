//
//  ViewController.swift
//  DZ18
//
//  Created by Илья Иванов on 19.03.2024.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {
  
  var userInput: String?
  var urlTypeString = ""
  var url: URL?
  let mainQueue = DispatchQueue.main
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setupLinkTextView()
    setupInputTextField()
    setupAlamofireButton()
    setupUrlSessionButton()
    
  }
  
  @IBOutlet weak var urlSessionButtonOutlet: UIButton!
  @IBOutlet weak var alamofireButtonOutlet: UIButton!
  @IBOutlet weak var inputTextFieldOutlet: UITextField!
  @IBOutlet weak var linkTextViewOutlet: UITextView!
  
  @IBAction func inputTextField(_ sender: Any) {
  }
  @IBAction func alamofireButton(_ sender: Any) {
    networkRequestUsingURLSession()
  }
  @IBAction func urlSessionButton(_ sender: Any) {
    networkRequestUsingURLSession()
  }
  
  //MARK: Функция реализации сетевого запроса через URLSession
  private func networkRequestUsingURLSession(){
    
    var requestForSessionButton = URLRequest(url: createdURL() )
    requestForSessionButton.httpMethod = "GET"
    requestForSessionButton.allHTTPHeaderFields = [
      "X-API-KEY" : "69352346-76a6-4ed5-a233-346dc7cc7127",
      "Content-Type": "application/json"]
    
    let task = URLSession.shared.dataTask(with: requestForSessionButton, completionHandler: { data,response, error in
      if let error = error {
        print(error)
      } else if let data = data, let _ = try? JSONSerialization.jsonObject(with:data, options: []) {
        let convertedString = String(data: data, encoding: .utf8)
        self.mainQueue.async {
          self.linkTextViewOutlet.text = convertedString
        }
        print(convertedString as Any)
      }
    })
    task.resume()
  }
  
  //MARK: Функция реализации сетевого запроса через Alamofire
  private func networkRequestUsingAlamofire(){
    
    AF.request(createdURL(),
               headers: [
                "X-API-KEY" : "69352346-76a6-4ed5-a233-346dc7cc7127",
                "Content-Type": "application/json"]
    ).response { response in
      guard response.error == nil else{
        return}
      guard let data = response.data else{
        return}
      let convertedString = String(data: data, encoding: .utf8)
      self.linkTextViewOutlet.text = convertedString
      debugPrint(convertedString ?? "")
    }
  }
  
  //MARK: Функция для создания URL
  private func createdURL()-> URL{
    
    userInput = inputTextFieldOutlet.text
    urlTypeString = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword="
    urlTypeString += userInput ?? ""
    url = URL(string: urlTypeString)
    
    return url!
  }
  
  //MARK: Функция для настройки кнопки URLSession
  private func setupUrlSessionButton(){
    urlSessionButtonOutlet.layer.cornerRadius = 15
    urlSessionButtonOutlet.snp.makeConstraints { make in
      make.width.equalTo(150)
      make.height.equalTo(40)
      make.top.equalToSuperview().inset(180)
      make.left.equalToSuperview().inset(20)
    }
  }
  //MARK: Функция для настройки кнопки Alamofire
  private func setupAlamofireButton(){
    alamofireButtonOutlet.layer.cornerRadius = 15
    alamofireButtonOutlet.snp.makeConstraints { make in
      make.width.equalTo(150)
      make.height.equalTo(40)
      make.top.equalToSuperview().inset(180)
      make.right.equalToSuperview().inset(20)
    }
  }
  //MARK: Функция для настройки кнопки TextView
  private func setupLinkTextView(){
    linkTextViewOutlet.layer.cornerRadius = 15
    linkTextViewOutlet.font = .systemFont(ofSize: 12)
    linkTextViewOutlet.snp.makeConstraints { make in
      make.height.equalTo(550)
      make.bottom.equalToSuperview().inset(60)
      make.right.equalToSuperview().inset(20)
      make.left.equalToSuperview().inset(20)
    }
  }
  //MARK: Функция для настройки кнопки TextField
  private func setupInputTextField(){
    inputTextFieldOutlet.font = .systemFont(ofSize: 18)
    inputTextFieldOutlet.layer.cornerRadius = 15
    inputTextFieldOutlet.snp.makeConstraints { make in
      make.height.equalTo(60)
      make.top.equalToSuperview().inset(100)
      make.right.equalToSuperview().inset(20)
      make.left.equalToSuperview().inset(20)
    }
  }
}
