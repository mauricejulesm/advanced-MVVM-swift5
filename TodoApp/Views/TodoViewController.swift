//
//  TodoViewController.swift
//  AdvancedMVVM
//
//  Created by falcon on 1/26/20.
//  Copyright © 2020 maurice. All rights reserved.
//

import UIKit

protocol TodoViewProtocal: class {
	func prepareTableViewForUpdate()
}

class TodoViewController: UIViewController {
	
	@IBOutlet var tableViewItems: UITableView!
	@IBOutlet var textFieldItem: UITextField!
	
	let cellIdentifier = "TodoItemCellIdentifier"
	
	var viewModel: TodoItemViewModel?
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableViewItems.delegate = self
		tableViewItems.dataSource = self
		let nib = UINib(nibName: "TodoItemCell", bundle: nil)
		tableViewItems.register(nib, forCellReuseIdentifier: cellIdentifier)
		
		bindModelView()
	}
	
	@IBAction func addItemsButtonTapped(_ sender: Any) {
		guard let newTodoItem = textFieldItem.text, !newTodoItem.isEmpty else {	return }
		viewModel?.addNewItem(newTodoItem: newTodoItem)
	}
	
	func bindModelView(){
		viewModel = TodoItemViewModel(view: self)
	}
}



extension TodoViewController : UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (viewModel?.itemsArray.count)!
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let todoCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TodoItemCell
		guard let todoItemModel = viewModel?.itemsArray[indexPath.row] else { return UITableViewCell() }
		todoCell.configureTodoCell(with: todoItemModel)
		return todoCell
	}
}

extension TodoViewController : UITableViewDelegate {
	
}

extension TodoViewController : TodoViewProtocal {
	func prepareTableViewForUpdate() {
		// tableViewItems.reloadData()
		guard let items = viewModel?.itemsArray else { return }
		self.tableViewItems.beginUpdates()
		self.tableViewItems.insertRows(at: [IndexPath(row: items.count-1, section: 0)], with: .automatic)
		self.tableViewItems.endUpdates()
	}
}



