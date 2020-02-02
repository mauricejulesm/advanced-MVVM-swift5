//
//  ItemViewModel.swift
//  AdvancedMVVM
//
//  Created by falcon on 1/26/20.
//  Copyright © 2020 maurice. All rights reserved.
//


protocol TodoItemDelegate {
	func onAddNewItem() -> ()
	func onDeleteItem(todoId: String) -> ()
}

protocol TodoViewPresentable {
	var newTodoItem: String? { get }
}

class TodoItemViewModel : TodoViewPresentable {
	weak var view: TodoViewProtocal?
	
	var newTodoItem : String?
	var itemsArray : [TodoPresentable] = []
	
	init( view: TodoViewProtocal){
		self.view = view
		let item1 = TodoModel(id: "1", itemText: "Laundry")
		let item2 = TodoModel(id: "2", itemText: "Joggin")
		let item3 = TodoModel(id: "3", itemText: "Sleeping")

		itemsArray.append(contentsOf: [item1, item2, item3])
	}
	
}

extension TodoItemViewModel : TodoItemDelegate {
	
	func onAddNewItem() {
		
		guard let newItemText = self.newTodoItem else {
			return
		}
		
		let itemIndex = itemsArray.count + 1
		let newItem = TodoModel(id: "\(itemIndex)", itemText: newItemText)
		
		self.itemsArray.append(newItem)
		self.newTodoItem = ""
		view?.prepareTableViewForUpdate()
	}
	
	func onDeleteItem(todoId: String) {
		guard let itemIndex = self.itemsArray.index(where: {$0.id! == todoId }) else {
			return
		}
		self.itemsArray.remove(at: itemIndex)
		self.view?.prepareViewForItemRemove(at: itemIndex)
	}
	
}
