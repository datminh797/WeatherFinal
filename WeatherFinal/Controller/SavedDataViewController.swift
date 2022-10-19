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
    
    var vc = MainViewController()
    
    let currentTime = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        // Regist cell
        tableView.register(UINib(nibName: Constant.cellNibName, bundle: nil), forCellReuseIdentifier: Constant.reuseCell)
//        tableView.register(UINib.init(nibName: Constant.cellNibName, bundle: nil), fo rCellReuseIdentifier: Constant.reuseCell)

        self.tableView.reloadData()
        
        //Init data
    }
    
    @IBOutlet weak var tableView: UITableView!
    
//    func loadData(){
//        for i in vc.humidityData.count {
//            print("Looped")
//        }
//    }
    
    
}

//MARK: - Table View Data Source
extension SavedDataViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Saved.count is \(vc.humidityData.count)")
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
        cell.time.text = receivedTime!
        
        
        print(format.string(from: time))
        
        return cell
        
    }
}

