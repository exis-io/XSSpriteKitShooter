//
//  ViewController.swift
//  SpriteKitController
//
//  Created by Chase Roossin on 4/19/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
import Riffle

class ViewController: UIViewController, Delegate {

    @IBOutlet weak var speed: UISlider!

    @IBAction func addMonster(sender: AnyObject) {
        print("publishing")
        app.publish("addMonster", Double(speed.value))
    }

    @IBOutlet weak var monstersKilled: UILabel!

    var app: Domain!
    var me: Domain!

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set up your app
        //Change USERNAME to your username that you used to sign up with at my.exis.io
        app = Domain(name: "xs.demo.USERNAME.monster")

        //Set up your domain
        me = Domain(name: "controller", superdomain: app)
        me.delegate = self

        //Joining container with your token
        //Navigate to your dashboard on my.exis.io and go to your app
        //Go to your appliances tab and open your Auth appliance and find the Token Management tab
        //Copy from: 'CONTROLLER' key
        me.setToken("GET_YOUR_CONTROLLER_KEY")
        me.join()
    }

    func onJoin() {
        print("Controller joined")
        app.subscribe("monsterKilled", updateMonsterLabel)
    }

    func onLeave() {
        print("We left!")
    }

    func updateMonsterLabel(totalKilled: Int){
        self.monstersKilled.text = "Monsters Killed: " + String(totalKilled)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

