import 'dart:convert';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

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
  String? _congratulation;

  @override
  void initState() {
    super.initState();
    _getJoke();
  }

  void _getJoke() => get(Uri.parse('https://api.chucknorris.io/jokes/random'))
      .then((value) => _congratulation = jsonDecode(value.body)['value']);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: FlipCard(
        direction: FlipDirection.VERTICAL,
        front: _card(true),
        back: _card(false),
        onFlip: () {
          setState(() => isFront = !isFront);
          if (!isFront) {
            _getJoke();
          }
        },
      ),
    );
  }

  Widget _card(bool isFront) {
    return Card(
      key: ValueKey(isFront),
      child: Center(
        child: Text(
          (isFront ? widget.front : _congratulation ?? widget.back) ?? '',
          style: TextStyle(fontSize: isFront ? 100 : 24),
        ),
      ),
      color: widget.color,
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

const yandexLogo = 'https://avatars.githubusercontent.com/u/7409213';
