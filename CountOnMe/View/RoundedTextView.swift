//
//  RoundedTextView.swift
//  CountOnMe
//
//  Created by mickael ruzel on 04/05/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import UIKit

class RoundedTextView: UITextView {

    static var shared = RoundedTextView()

    func roundedTextView() {
        self.layer.cornerRadius = self.bounds.height / 25
    }
}
