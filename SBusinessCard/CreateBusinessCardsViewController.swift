//
//  CreateBusinessCardsViewController.swift
//  SBusinessCard
//
//  Created by Luthon Hagvinprice on 2017-11-30.
//  Copyright © 2017 Luthon Hagvinprice. All rights reserved.
//

import UIKit

class CreateBusinessCardsViewController: UIViewController {

    
    // @IBOutlets
        @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    // Dismiss view when cancel button pressed
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
