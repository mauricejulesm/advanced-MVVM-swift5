//
//  TodoItemModel.swift
//  AdvancedMVVM
//
//  Created by falcon on 1/29/20.
//  Copyright © 2020 maurice. All rights reserved.
//

protocol TodoItemCellDelegate {
	func onItemSelected() -> ()
}

protocol TodoItemPresentable {
	var id : String? {get}
	var itemText : String? {get}
}

struct TodoItemCellViewModel :TodoItemPresentable {
	var id: String?
	var itemText: String?
	
	init(id:String, itemText:String) {
		self.id = id
		self.itemText = itemText
	}
}

extension TodoItemCellViewModel : TodoItemCellDelegate {
	func onItemSelected() {
		print("Item of id \(id ?? "unable to retrieve the id") was selected.")
	}
}
