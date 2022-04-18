import 'package:dictionary_bloc/models/dictionary_model.dart';
import 'package:dictionary_bloc/screens/detail/detail_screen.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  final List<DictionaryModel>? words;

  const ListScreen(this.words, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: ListView.separated(
          itemBuilder: (context, index) => ListTile(
                title: Text(
                  "${words![index].word}",
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailScreen(words![index])));
                },
              ),
          separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
              ),
          itemCount: words!.length),
    );
  }
}
