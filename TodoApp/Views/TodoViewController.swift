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
	func prepareViewForItemRemove(at index: Int) -> ()
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
		viewModel?.newTodoItem = newTodoItem
		
		DispatchQueue.global(qos: .background).async {
			self.viewModel?.onAddNewItem()
		}
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
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let currentItemView = viewModel?.itemsArray[indexPath.row]
		(currentItemView as? TodoModelDelegate)?.onItemSelected()
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		
		let itemViewModel = self.viewModel?.itemsArray[indexPath.row]
		
		let deleteAction = UIContextualAction(style: .normal, title: "Delete Todo") { (action, sourceView, success: (Bool) -> (Void)) in
			
			DispatchQueue.global(qos: .background).async {
				self.viewModel?.onDeleteItem(todoId: (itemViewModel?.id)!)
			}
			success(true)
		}
		
		deleteAction.backgroundColor = .red
		return UISwipeActionsConfiguration(actions: [deleteAction])
	}
}

extension TodoViewController : TodoViewProtocal {
	
	
	func prepareTableViewForUpdate() {
		DispatchQueue.main.async(execute: { () -> Void in
			guard let items = self.viewModel?.itemsArray else { return }
			self.textFieldItem.text = ""
			self.tableViewItems.beginUpdates()
			self.tableViewItems.insertRows(at: [IndexPath(row: items.count-1, section: 0)], with: .automatic)
			self.tableViewItems.endUpdates()
		})
		
	}
	
	func prepareViewForItemRemove(at index: Int) {
		DispatchQueue.main.async(execute: { () -> Void in
			self.tableViewItems.beginUpdates()
			self.tableViewItems.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
			self.tableViewItems.endUpdates()
		})
	}
	
	
}



