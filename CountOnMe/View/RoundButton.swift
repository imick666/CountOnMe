//
//  RoundButton.swift
//  CountOnMe
//
//  Created by mickael ruzel on 27/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    static let shared = RoundButton()

    func setUpButton() {
        self.layer.cornerRadius = self.bounds.height / 2
    }

}
