//
//  TaskCell.swift
//  TaskIt
//
//  Created by Rob Passaro on 1/26/15.
//  Copyright (c) 2015 Rob Passaro. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    // These are the UI elements within the "prototype" cell shown we built in the main storyboard.
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
