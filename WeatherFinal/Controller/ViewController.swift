//
//  ViewController.swift
//  Weather
//
//  Created by minhdat on 11/10/2022.
//

import UIKit
import CoreLocation
import CoreData

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SearchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    var weatherManager = WeatherManager()
    //    let weatherModel = WeatherModel()
    var locationManager = CLLocationManager()
    
    var humidityData : [NSManagedObject] = []
    var savedHumidity : String = "Not yet"
    
    @IBOutlet weak var CityName: UILabel!
    @IBOutlet weak var SearchTextField: UITextField!
    @IBOutlet weak var Temperature: UILabel!
    @IBOutlet weak var Humidity: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBAction func SaveData(_ sender: Any) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "HumData", in: managedContext)!
        let humData = NSManagedObject(entity: entity, insertInto: managedContext)
        
        humData.setValue(savedHumidity, forKey: "humidity")
        
        do {
            try managedContext.save()
            humidityData.append(humData)
            //                    tableview.reloadData()
            print("Saved humidity = \(savedHumidity)")
            print(humidityData.count)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        self.performSegue(withIdentifier: "ReuseableCell", sender: "self")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "ReuseableCell"{
            let dataVC = segue.destination as! SavedDataViewController
            
            dataVC.receivedHumidity = savedHumidity
        }
    }
    
}



//MARK: - WeatherManagerDelegate
extension ViewController : WeatherManagerDelegate{
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.Temperature.text = weather.temperatureString
//            self.Humidity.text = weather.humidityString
            
            self.savedHumidity = weather.humidityString
            self.Humidity.text = self.savedHumidity
            
            
            self.CityName.text = weather.cityName
            self.weatherImage.image = UIImage(systemName: weather.getConditionName(conditionID: weather.conditionId))
        }
        
    }
    
    
}


//MARK: - UITextField Delegate
extension ViewController : UITextFieldDelegate {
    
    @IBAction func SearchLocation(_ sender: UIButton) {
        SearchTextField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = SearchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        SearchTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        } else {
            textField.placeholder = "Search a city !"
            return false
        }
    }
    
}

//MARK: - Core location
extension ViewController : CLLocationManagerDelegate {
    @IBAction func CurrentLocation(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            weatherManager.fetchWeather(latitude: latitude, longitude: longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//MARK: - Coredata
//extension ViewController : UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return humidityData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let data = humidityData[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.reuseCell, for: indexPath) as! DataCell
//
//        let hum = (data.value(forKey: "humidity") as? Double) ?? 0.0
//
//        let time = Date()
//        let format = DateFormatter()
//        format.dateFormat = "d MMM y, HH:mm"
//
//        cell.time.text = format.string(from: time)
//        cell.humidity.text = String(hum)
//
//        print(format.string(from: time))
//
//        return cell
//    }
//
//}
