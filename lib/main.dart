import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: const [
            Flexible(
              child: PostCard(
                front: Tree.icon,
                back: Tree.text,
                color: Tree.color,
              ),
            ),
            Flexible(
              child: PostCard(
                front: Santa.icon,
                back: Santa.text,
                color: Santa.color,
              ),
            ),
            Flexible(
              child: PostCard(
                front: Snowman.icon,
                back: Snowman.text,
                color: Snowman.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final String? front;
  final String? back;
  final Color? color;

  const PostCard({
    Key? key,
    this.front,
    this.back,
    this.color,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  var isFront = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GestureDetector(
        onTap: () => setState(() => isFront = !isFront),
        child: Rotation(
          child: Card(
            key: ValueKey(isFront),
            child: Center(
              child: Text(
                (isFront ? widget.front : widget.back) ?? '',
                style: TextStyle(fontSize: isFront ? 100 : 24),
              ),
            ),
            color: widget.color,
          ),
        ),
      ),
    );
  }
}

// ----------

class Tree {
  static const icon = '🎄';
  static const text =
      'Я Ёлочка! Желаю тебе быть быть зеленым и пушистым, как я!';
  static const color = Colors.green;
}

class Santa {
  static const icon = '🎅';
  static const text = 'Я Дед Мороз! Желаю тебе подарков мешок!';
  static const color = Colors.red;
}

class Snowman {
  static const icon = '☃️';
  static const text = 'Я Снеговик! Желаю тебе хорошо сдать сессию 🌚';
  static const color = Colors.white;
}

class Rotation extends StatelessWidget {
  final Widget? child;

  const Rotation({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget widget, Animation<double> animation) {
          final rotate = Tween(begin: pi, end: 0.0).animate(animation);
          return AnimatedBuilder(
            animation: rotate,
            child: widget,
            builder: (context, widget) => Transform(
              transform: Matrix4.rotationX(rotate.value),
              child: widget,
              alignment: Alignment.center,
            ),
          );
        },
        child: child,
      );
}

const yandexLogo = 'https://avatars.githubusercontent.com/u/7409213';
