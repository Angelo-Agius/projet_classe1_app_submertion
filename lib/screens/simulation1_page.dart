import 'package:flutter/material.dart';

class Simulation1Page extends StatefulWidget {
  const Simulation1Page({super.key});

  @override
  State<Simulation1Page> createState() => _Simulation1PageState();
}

class _Simulation1PageState extends State<Simulation1Page>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _heightAnimation;

  bool showOverlay = true;
  bool showBackButton = true;
  bool showResetButton = false;


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _heightAnimation = Tween<double>(
      begin: 0,
      end: 455, //Faudra qu'ont ajute en fonction de l'image du prof
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showBackButton = true;
          showResetButton = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.yellow,
            child: Image.asset(
              "assets/imgs/simulation1_img.png",
              fit: BoxFit.cover,
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: double.infinity
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedBuilder(
              animation: _heightAnimation,
              builder: (context, child) {
                return Container(
                  width: 150,
                  height: _heightAnimation.value,
                  decoration: BoxDecoration(
                    color:
                        Colors
                            .blue.withValues(alpha: 0.7), //ont mettra de la transparence quand on aura l'image
                  ),
                );
              },
            ),
          ),
          if (showOverlay) ...[
            Container(color: Colors.white.withValues(alpha: 0.5)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  onPressed: () {
                    setState(() {
                      _startAnimation();
                      showOverlay = false;
                      showBackButton = false;
                      showResetButton = false;
                    });
                  },
                  child: Text(
                    'Start Simulation',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
          if (showBackButton)
            Positioned(
              top: 20,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, size: 28, color: showOverlay ? Colors.black : Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          if (showResetButton)
            Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(Icons.replay, size: 50, color: showOverlay ? Colors.black : Colors.white,),
                onPressed: () {
                  setState(() {
                    _startAnimation();
                    showBackButton = false;
                    showResetButton = false;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
