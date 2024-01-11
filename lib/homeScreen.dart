import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int leftDice = 1;
  int rightDice = 1;
  late AnimationController? animationController;
CurvedAnimation? animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
animate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController?.dispose();
  }

  void roll() {
    animationController?.forward();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dice App'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: GestureDetector(
                  onDoubleTap: roll,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Image(
                      height: 200 - (animationController?.value)!*200,
                      image:
                          AssetImage('assets/images/dice-png-$leftDice.png'),
                    ),
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onDoubleTap: roll,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Image(
                      height: 200 - (animationController?.value)!*200,
                      image:
                          AssetImage('assets/images/dice-png-$rightDice.png'),
                    ),
                  ),
                )),
              ],
            ),


            ElevatedButton(onPressed: roll, child: Text('Roll')),


          ],



        ),
      ),
    );
  }

  void animate() {




    animationController = AnimationController(
      duration: Duration(
        seconds: 2,
      ), vsync: this,
    );



     animation = animationController != null
        ? CurvedAnimation(parent: animationController!, curve: Curves.bounceOut)
        : null;

    animationController?.addListener(() {

        setState(() {

        });

      print(animationController?.value);
    });

    animationController?.addStatusListener((status) {

      if(status==AnimationStatus.completed)
      {
        setState(() {
          leftDice = Random().nextInt(6) + 1;
          rightDice = Random().nextInt(6) + 1;
        });

        animationController?.reverse();
        print('completed');

      }
    });
  }
}
