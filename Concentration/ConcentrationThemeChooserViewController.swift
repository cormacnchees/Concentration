//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Cormac Hayden on 4/4/19.
//  Copyright © 2019 Cormac Hayden. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    
    let themes = [
        "Hawaii": "🌙🌊🌈🌸🌺🥝🏄🏼‍♂️🤙🏽🌴🥥😁🕶🐬🙉",
        "Space": "👩‍🚀👽🌚🌙✨💫☄️🌜🌞🚀🛰🔭🌎🛸",
        "Baller": "😎🤑😈☠️🤘👑🐲🌮🍾🥂🏆🔫💎💵",
    ]
    
    override func awakeFromNib() { //sets initial iPhone screen to theme selector
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme 
                }
            }
        }
    }
    
}
