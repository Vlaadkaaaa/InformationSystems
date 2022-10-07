//
//  SecontTableViewController.swift
//  HomeWorkInformationSystems
//
//  Created by Владислав Лымарь on 07.10.2022.
//

import UIKit

final class SecondTableViewController: UITableViewController {
    
    private var addNewFilther: UIButton = {
        let button = UIButton(frame: CGRect(x: 95, y: 400, width: 200, height: 40))
        button.setTitle("Добавить фильтр", for: .normal)
        button.backgroundColor = .red        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filther"
        view.backgroundColor = .white
        view.addSubview(addNewFilther)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveFilther))
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "filtherCell")
        addNewFilther.addTarget(self, action: #selector(addNewFiltherAction), for: .allTouchEvents)
        
    }
    @objc func saveFilther() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func addNewFiltherAction() {
        let alert = UIAlertController(title: "Добавить фильтр", message: "", preferredStyle: .alert)
        alert.addTextField { texField in
            texField.tag = 0
        }
        alert.addTextField { texField in
            texField.tag = 1
        }
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { _ in
            let textOne = alert.textFields?.first?.text
            tems.append(textOne ?? "")
            self.tableView.reloadData()
        }))
        present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "filtherCell", for: indexPath)
        cell?.textLabel?.text = tems[indexPath.row]
        
        return cell!
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            tems.remove(at: indexPath.row)
            tableView.reloadData()
        }
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
    
}
