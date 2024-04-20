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
    var urlString = ""
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
        createdAlamofireLink()
    }
    @IBAction func urlSessionButton(_ sender: Any) {
        createdUrlSessionLink()
    }
    
    func setupUrlSessionButton(){
        urlSessionButtonOutlet.layer.cornerRadius = 15
        urlSessionButtonOutlet.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(40)
            make.top.equalToSuperview().inset(180)
            make.left.equalToSuperview().inset(20)
        }
    }
    func setupAlamofireButton(){
        alamofireButtonOutlet.layer.cornerRadius = 15
        alamofireButtonOutlet.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(40)
            make.top.equalToSuperview().inset(180)
            make.right.equalToSuperview().inset(20)
        }
    }
    func setupLinkTextView(){
        linkTextViewOutlet.layer.cornerRadius = 15
        linkTextViewOutlet.font = .systemFont(ofSize: 12)
        linkTextViewOutlet.snp.makeConstraints { make in
            make.height.equalTo(550)
            make.bottom.equalToSuperview().inset(60)
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(20)
        }
    }
    func setupInputTextField(){
        inputTextFieldOutlet.font = .systemFont(ofSize: 18)
        inputTextFieldOutlet.layer.cornerRadius = 15
        inputTextFieldOutlet.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalToSuperview().inset(100)
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(20)
        }
    }
    
    func createdUrlSessionLink(){
        
        var requestForSessionButton = URLRequest(url: createdURL() )
        requestForSessionButton.httpMethod = "GET"
        requestForSessionButton.allHTTPHeaderFields = [
            "X-API-KEY" : "69352346-76a6-4ed5-a233-346dc7cc7127",
            "Content-Type": "application/json"]
        
        let task = URLSession.shared.dataTask(with: requestForSessionButton, completionHandler: { data,response, error in
            if let error = error {
                print(error)
            }
            else if let data = data, let _ = try? JSONSerialization.jsonObject(with:data, options: []) {
                let convertedString = String(data: data, encoding: .utf8)
                self.mainQueue.async {
                    self.linkTextViewOutlet.text = convertedString
                }
                print(convertedString as Any)
            }
        })
        task.resume()
    }
    
    func createdAlamofireLink(){
        let filmInstance = FilmInstance(keyword: userInput ?? "", pagesCount: 0)
        
        AF.request(url!,
                   headers: [
                    "X-API-KEY" : "69352346-76a6-4ed5-a233-346dc7cc7127",
                    "Content-Type": "application/json"]
        ).response { response in
            guard response.error != nil else{return}
            guard let data = response.data else{return}
            let convertedString = String(data: data, encoding: .utf8)
            self.mainQueue.async {
                self.linkTextViewOutlet.text = convertedString
            }
            debugPrint(convertedString ?? "")
            print(response.response?.statusCode)
        }
    }
    
    func createdURL()-> URL{
        
        userInput = inputTextFieldOutlet.text
        urlString = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword="
        urlString += userInput ?? ""
        url = URL(string: urlString)
        
        return url!
    }
}
