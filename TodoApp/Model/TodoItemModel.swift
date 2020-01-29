//
//  TodoItemModel.swift
//  AdvancedMVVM
//
//  Created by falcon on 1/29/20.
//  Copyright © 2020 maurice. All rights reserved.
//

protocol TodoModelDelegate {
	func onItemSelected() -> ()
}

protocol TodoPresentable {
	var id : String? {get}
	var itemText : String? {get}
}

struct TodoModel :TodoPresentable {
	var id: String?
	var itemText: String?
	
	init(id:String, itemText:String) {
		self.id = id
		self.itemText = itemText
	}
}

extension TodoModel : TodoModelDelegate {
	func onItemSelected() {
		print("Item of id \(id ?? "unable to retrieve the id") was selected.")
	}
}
