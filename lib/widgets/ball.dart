


import 'package:flutter/material.dart';


List<Color> colors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
  Colors.pink,
];
class Ball extends StatefulWidget
{
  Ball({super.key, required this.onColorChanged});
  final void Function(Color) onColorChanged;

  @override
  State<StatefulWidget> createState() => _ball();
  int idx = 0;
  
}

class _ball extends State<Ball>
{
  @override
  Widget build(BuildContext context) {
      widget.onColorChanged(colors[widget.idx]);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(child: Icon(Icons.arrow_back_ios,size: 50,) ,onTap: () => setState(() {
            widget.idx--;
            widget.idx %= (colors.length);
            widget.onColorChanged(colors[widget.idx]);
          }),),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
                color: colors[widget.idx],
      
            ),
          ),
      
          InkWell(child: Icon(Icons.arrow_forward_ios,size: 50,),onTap: () => setState(() {
            widget.idx++;
            widget.idx %= (colors.length);
            widget.onColorChanged(colors[widget.idx]);
          }))
      
      
        ],
      ),
    );
  
  }
  
}