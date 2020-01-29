//
//  ItemViewModel.swift
//  AdvancedMVVM
//
//  Created by falcon on 1/26/20.
//  Copyright © 2020 maurice. All rights reserved.
//


protocol TodoItemDelegate {
	func onItemAdded() -> ()
}

class TodoItemViewModel {
	var newTodoItem : String?
	var itemsArray : [TodoItemPresentable] = []
	
	init(){
		let item1 = TodoItemModel(id: "1", itemText: "Laundry")
		let item2 = TodoItemModel(id: "2", itemText: "Joggin")
		let item3 = TodoItemModel(id: "3", itemText: "Joggin")
		let item4 = TodoItemModel(id: "4", itemText: "Joggin")
		let item5 = TodoItemModel(id: "5", itemText: "Sleeping")
		let item6 = TodoItemModel(id: "6", itemText: "Sleeping")

		itemsArray.append(contentsOf: [item1, item2, item3, item4, item5, item6])
	}
	
}



extension TodoItemViewModel : TodoItemDelegate {
	func onItemAdded() {
		print("New Item added")
	}
}
