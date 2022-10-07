//
//  NewsTwoTableViewController.swift
//  HomeWorkInformationSystems
//
//  Created by Владислав Лымарь on 05.10.2022.
//

import UIKit

final class NewsTableViewController: UITableViewController {
    
    private var titleForGeaderInSection = ""
    private var chooseValue = ""
    var result: NewsResponce?
    
    let picker = UIPickerView(frame: CGRect(x: 15, y: 20, width: 350, height: 170))
    
    
    override func viewWillAppear(_ animated: Bool) {
        getApi(urlString: urlString)
        picker.reloadAllComponents()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        title = "All News"
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleForGeaderInSection
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  result?.articles?.count ?? 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        guard let result = result?.articles?[indexPath.row] else { return cell }
        titleForGeaderInSection = result.publishedAt
        let imageData: Data = {
            var data = Data()
            if let url = URL(string: result.urlToImage ?? "") {
                do {
                    data = try Data(contentsOf: url)
                } catch {
                    
                }
            }
            return data
        }()
        
        var content = cell.defaultContentConfiguration()
        content.text = "\(result.title)"
        content.secondaryText = "Автор: \(result.author ?? "Неизвестен")"
        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        content.image = UIImage(data: imageData)
        cell.contentConfiguration = content
        
        return cell
    }
    
    @IBAction func leftButton(_ sender: Any) {
        let message = "\n\n\n\n\n\n\n\n"
        let alertContreoller = UIAlertController(title: "Показать новости", message: message, preferredStyle: .actionSheet)
        let alertActionOk = UIAlertAction(title: "Выбрать", style: .default) { _ in
            
            if self.chooseValue == "Apple" {
                self.getApi(urlString: urlAppleString)
            } else if self.chooseValue == "Tesla" {
                self.getApi(urlString: urlTeslaString)
            } else {
                self.getApi(urlString: urlString)
            }
            self.title = self.chooseValue
        }
        let alertCancel = UIAlertAction(title: "Отмена", style: .cancel)
        let editFilther = UIAlertAction(title: "Редактировать фильтр", style: .default) { _ in
            let vc = SecondTableViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        alertContreoller.view.addSubview(picker)
        alertContreoller.addAction(editFilther)
        alertContreoller.addAction(alertActionOk)
        alertContreoller.addAction(alertCancel)
        
        present(alertContreoller, animated: true)
        
    }
    @IBAction func rightButtonItem(_ sender: Any) {
        tableView.reloadData()
        picker.reloadAllComponents()
    }
}

//MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension NewsTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tems.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tems[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chooseValue =  tems[row]
    }
    
}

// MARK: GetApi
extension NewsTableViewController {
    func getApi(urlString: String)  {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let jsonData = try Data(contentsOf: url)
                self.result = try JSONDecoder().decode(NewsResponce.self, from: jsonData)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
