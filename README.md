# Swift SpriteKit Shooter!

This is a tutorial based on [Ray Wenderlinch's SpriteKit and Swift tutorial](https://www.raywenderlich.com/119815/sprite-kit-swift-2-tutorial-for-beginners).  We have incorporated Exis in order to make it a multiplayer game!

Download the code to get started:
```console
git clone https://github.com/exis-io/XSSpriteKitShooter.git
cd SpriteKitSimpleGame
pod install
```

### Create app on Exis

Navigate to [my.exis.io](my.exis.io) and register for an account or login to your existing 

Click create an app from template and select `Sprite Kit Multiplayer`

### Setup for your app
Launch your Xcode project by either opening `SpriteKitSimpleGame.xcworkspace` in Finder or by running:

```console
open SpriteKitSimpleGame.xcworkspace
```

Once this is launched you will see 2 folders in your project: `SpriteKitSimpleGame` and `SpriteKitController` (Each of these represent a target.  First being the actual game for Player 1 and the second being the controller for Player 2).

### SpriteKitSimpleGame

In your first target find the file `GameScene.swift`.  This is where we will inject the Exis code for Player 1 (who is actually playing the game).  You will be editing lines `65` & `74`.  

Change `USERNAME` to the username that you used to signup for an account with Exis. Then change `GET_YOUR_CONTROLLER_KEY` to the key that you can find in your app on [my.exis.io](my.exis.io) under Appliances->Auth->Token Management->game

```swift
override init(size: CGSize){
        super.init(size: size)

        app = Domain(name: "xs.demo.USERNAME.monster")

        //Set up your domain
        me = Domain(name: "game", superdomain: app)
        me.delegate = self
        //Joining container with your token
        //Navigate to your dashboard on my.exis.io and go to your app
        //Go to your appliances tab and open your Auth appliance and find the Token Management tab
        //Copy from: 'GAME' key
        me.setToken("GET_YOUR_CONTROLLER_KEY")
        me.join()
    }
```

You will notice that in the `onJoin()` function we subscribe to an endpoint - this is where all the magic happens:

```swift
func onJoin() {
    app.subscribe("addMonster", addMonster)
    app.publish("monsterKilled", 0)
}
```

This means `addMonster` function is called everytime something is published on the `addMonster` endpoint.  It will tell the screen to create a monster at a random location with the speed that Player 2 determines.  Feel free to look at the `addMonster` function to see how that works.

### SpriteKitController

This is the target for Player 2 - which allows the user to push a monster onto Player 1's screen with a specific speed.

Navigate to this file in your project and open `ViewController.swift`.

Just as you did with the other target edit your username and key

```swift
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
```

**Note**: The only difference is that the key should be the `controller` key NOT the `game` key.

Once this is all complete go ahead and run your `SpriteKitSimpleGame` target on either the simulator or a physical device and then run `SpriteKitController` on the opposite.  (Xcode does not allow you to run multiple simulators, so one must be on a physical device and the other on a simulator.  Or both on a physical device).

**Compile and run!**

