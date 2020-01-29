//
//  TodoItemCell.swift
//  AdvancedMVVM
//
//  Created by falcon on 1/29/20.
//  Copyright © 2020 maurice. All rights reserved.
//

import UIKit

class TodoItemCell: UITableViewCell {

	@IBOutlet var todoItemNumber: UILabel!
	@IBOutlet var todoItemTitle: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)		
		
    }
	
	func configureTodoCell(with model: TodoItemPresentable) -> () {
		todoItemNumber.text = model.id
		todoItemTitle.text = model.itemText
	}
	
}
