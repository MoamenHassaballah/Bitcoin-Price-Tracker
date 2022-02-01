//
//  ViewController.swift
//  Bitcoin Price Tracker
//
//  Created by Moamen Hassaballah on 01/02/2022.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, PriceDelegate {
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var currencyPickerView: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    
    private let currenciesList = ["USD", "CAD", "GBP", "EUR"]
    let apiHandler = APIHandler()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dataView.layer.cornerRadius = 30
        currencyPickerView.dataSource = self
        currencyPickerView.delegate = self
        apiHandler.delegate = self
        
        apiHandler.getPrice(currenciesList[0])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currenciesList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currenciesList[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = currenciesList[row]
        
        apiHandler.getPrice(selectedCurrency)
    }
    
    
    func onPriceRetrieved(price: Prices) {
        DispatchQueue.main.sync {
    
            let selectedRow = currencyPickerView.selectedRow(inComponent: 0)
            priceLabel.text = "\(String(format: "%.2f", price.rate)) \(currenciesList[selectedRow])"
        }
    }
    
    func onError(error: Error) {
        print("Error: \(error)")
    }

}

