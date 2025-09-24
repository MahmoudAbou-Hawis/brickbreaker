import 'package:brick_breaker/brikebreaker.dart';
import 'package:brick_breaker/components/config.dart';
import 'package:brick_breaker/widgets/ball.dart';
import 'package:brick_breaker/widgets/score.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';




void main() {
  runApp( GameApp());

}


class GameApp extends StatelessWidget {
   GameApp({super.key});

  final Brikebreaker game = Brikebreaker(level: gameLevel.medium, ballColor: Colors.blueAccent);

  Color? ballColor ;

  setColor(Color color){
      ballColor = color;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.pressStart2pTextTheme().apply(
          bodyColor: const Color(0xff184e77),
          displayColor: const Color(0xff184e77),
                  
        ),
        
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffa9d6e5), Color(0xfff2e8cf)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Center(
                child: Column(
                  children: [
                    ScoreCard(score: game.score),
                    
                    Expanded(
                      child: FittedBox(
                        child: SizedBox(
                          width: gameWidth,
                          height: gameHeight,
                          child: GameWidget(          
                            game: game,
                                       overlayBuilderMap: {
                              PlayState.welcome.name: (context, game) => Column(
                                 mainAxisSize: MainAxisSize.min, // <-- Add this
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,                                   children: [
                                  
                                  Expanded(child: Padding(
                                    padding: const EdgeInsets.only(top:280.0),
                                    child: Ball(onColorChanged: setColor,),
                                  )),
                                  Expanded(
                                    child: Container(
                                      child: InkWell(
                                                                    
                                        child: Text(
                                          'TAP TO PLAY',
                                          style: Theme.of(context).textTheme.headlineLarge,
                                        ),
                                        onTap: () => (game as Brikebreaker).start(ballColor!)
                                                            ,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              PlayState.gameOver.name: (context, game) => Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                            InkWell(
                                      onTap: ()=> (game as Brikebreaker).start(ballColor!),
                                    child: Text(
                                      'G A M E  \n O V E R',
                                      style: Theme.of(context).textTheme.headlineLarge,
                                    )),
                                    SizedBox(height: 15,),
                                    InkWell(
                                      onTap: ()=> (game as Brikebreaker).start(ballColor!),
                                      child: Text("TAP TO PLAY AGAIN",                               
                                       style: Theme.of(context).textTheme.bodyMedium,
                                       
                      ),
                                    )
                                  ],
                                ),
                              ),
                              PlayState.won.name: (context, game) => Center(
                                child: Text(
                                  'Y O U  \n  W O N ! ! !',
                                  style: Theme.of(context).textTheme.headlineLarge,
                                ),
                              ),
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}