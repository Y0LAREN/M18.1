//
//  ViewController.swift
//  DZ18
//
//  Created by Илья Иванов on 19.03.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var userInputData: Data?
    var userInput: String?
    var answerServer: String?
    var urlString = ""
    var url: URL?
    
    
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
        linkTextViewOutlet.text = answerServer
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
        urlString = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword="
        userInput = inputTextFieldOutlet.text
        urlString += userInput ?? ""
        url = URL(string: urlString)
        var request = URLRequest(url: url! )
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "X-API-KEY" : "69352346-76a6-4ed5-a233-346dc7cc7127",
            "Content-Type": "application/json"]

        let task = URLSession.shared.dataTask(with: request, completionHandler: { data,response, error in
            if let error = error {
                print(error)
            }
            else if let data = data, let json = try? JSONSerialization.jsonObject(with:data, options: []) {
                let convertedString = String(data: data, encoding: .utf8)
                self.linkTextViewOutlet.text = convertedString
                print(convertedString as Any)
            }
        })
        task.resume()
    }
    
    func createdAlamofireLink(){
        
    }
}

