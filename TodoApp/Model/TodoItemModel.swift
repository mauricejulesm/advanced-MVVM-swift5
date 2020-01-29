//
//  TodoItemModel.swift
//  AdvancedMVVM
//
//  Created by falcon on 1/29/20.
//  Copyright © 2020 maurice. All rights reserved.
//



protocol TodoItemPresentable {
	var id : String? {get}
	var itemText : String? {get}
}

struct TodoItemModel :TodoItemPresentable {
	var id: String?
	var itemText: String?
}
