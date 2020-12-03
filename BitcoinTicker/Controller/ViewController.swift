//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {

    //MARK: - Properties
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    //MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }
    
    //MARK: - UIPickerDelegate

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    //MARK: -UIPickerSelectedRow
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalURL = baseURL + currencyArray[row]
    }
    
    //MARK: - Networking
    
    func getPriceData(url: String) {
        AF.request(url, method: .get).responseJSON {
            response in
            if ((response.data?.isEmpty) != nil) {
                self.bitcoinPriceLabel.text = "N/A"
            } else {
                let priceJSON: JSON = JSON(response.result)
                self.updatePriceData(json: priceJSON)
            }
        }
    }

    //MARK: - JSON Parsing
    
    func updatePriceData(json : JSON) {
        if let priceResult = json["main"]["temp"].double {
//            weatherData.temperature = Int(round(priceResult!) - 273.15)
//            weatherData.city = json["name"].stringValue
//            weatherData.condition = json["weather"][0]["id"].intValue
//            weatherData.weatherIconName =    weatherData.updateWeatherIcon(condition: weatherData.condition)
        }
        updateUIWithPriceData()
    }
    
    //MARK: - UIUpdate

    func updateUIWithPriceData() {
        
    }
}

