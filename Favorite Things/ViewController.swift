//
//  ViewController.swift
//  Favorite Things
//
//  Created by Justin Hohl on 4/5/18.
//  Copyright © 2018 hohljm. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    var favoriteNumber: Int = 50
    var docRef: DocumentReference!
    var favoriteThingsListener: ListenerRegistration!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        docRef = Firestore.firestore().collection("favoriteThings").document("myDocId")
    }

    @IBOutlet weak var numberlabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteThingsListener = docRef.addSnapshotListener({ (documentSnapshot, error) in
            if error != nil {
                print("Error fetching document. \(error!.localizedDescription)")
                return
            }
            
            self.colorLabel.text = documentSnapshot?.get("color") as? String
            self.favoriteNumber = documentSnapshot?.get("number") as! Int
            self.numberlabel.text = String(self.favoriteNumber)
        })
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        favoriteThingsListener.remove()
    }
    
    @IBAction func pressedRed(_ sender: Any) {
        docRef.updateData(["color": "red"])
    }
    
    @IBAction func pressedWhite(_ sender: Any) {
        docRef.updateData(["color": "white"])
    }
    
    @IBAction func pressedBlue(_ sender: Any) {
        docRef.updateData(["color": "blue"])
    }
    
    @IBAction func pressedFetchColorOnce(_ sender: Any) {
        docRef.getDocument { (documentSnapshot, error) in
            if error != nil {
                print("Error fetching document. \(error!.localizedDescription)")
                return
            }
            
            self.colorLabel.text = documentSnapshot?.get("color") as? String
        }
    }
    
    @IBAction func pressedIncrement(_ sender: Any) {
        docRef.updateData(["number": favoriteNumber + 1])
    }
    
    @IBAction func pressedDecrement(_ sender: Any) {
        docRef.updateData(["number": favoriteNumber - 1])

    }
    
    
    
}

