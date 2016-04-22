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
        //Copy from: Auth() -> Authorized Key Management -> 'CONTROLLER' key
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

