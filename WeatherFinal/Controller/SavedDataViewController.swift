//
//  SavedDataViewController.swift
//  WeatherFinal
//
//  Created by minhdat on 18/10/2022.
//

import UIKit

class SavedDataViewController: UIViewController {
    
    var receivedTime : String?
    var receivedHumidity : String?
    
    var vc = ViewController()
    
    let currentTime = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
}

extension SavedDataViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vc.humidityData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = vc.humidityData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.reuseCell, for: indexPath) as! DataCell
        
        let time = Date()
        let format = DateFormatter()
        format.dateFormat = "d MMM y, HH:mm"
        
        cell.time.text = format.string(from: time)
        print(format.string(from: time))
        
//        cell.humidity.text = data.value(forKey: "humidity") as? String
        cell.humidity.text = receivedHumidity!
        
        
        print(format.string(from: time))
        
        return cell
        
    }
}

extension SavedDataViewController : UITableViewDelegate{
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
