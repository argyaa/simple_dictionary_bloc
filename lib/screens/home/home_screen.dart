import 'package:dictionary_bloc/bloc/dictionary_cubit.dart';
import 'package:dictionary_bloc/screens/list/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // ignore_for_file: prefer_const_constructors
  getDictionaryFormWidget(BuildContext context) {
    final cubit = context.watch<DictionaryCubit>();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Spacer(),
          Text(
            "Dictionary App",
            style: TextStyle(
              color: Colors.deepOrangeAccent,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Search any word you want quickly",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 32,
          ),
          TextField(
            controller: cubit.queryController,
            decoration: InputDecoration(
              hintText: "Search a word",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              fillColor: Colors.grey[100],
              filled: true,
              prefixIcon: Icon(Icons.search),
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          Spacer(),
          // ignore: sized_box_for_whitespace
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await cubit.getWordSearched(cubit.queryController.text);
                cubit.queryController.clear();
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrangeAccent,
                  padding: const EdgeInsets.all(16)),
              child: Text("SEARCH"),
            ),
          ),
        ],
      ),
    );
  }

  getLoadingWidget() {
    return Center(child: CircularProgressIndicator());
  }

  getErrorWidget(String message) {
    return Center(
      child: Text(message),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DictionaryCubit>();

    return BlocListener<DictionaryCubit, DictionaryState>(
      listener: (context, state) {
        if (state is WordSearchedState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: ((context) => ListScreen(state.words))),
          );
        }
      },
      bloc: cubit,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[600],
        body: cubit.state is WordSearchingState
            ? getLoadingWidget()
            : cubit.state is ErrorState
                ? getErrorWidget("Some Error")
                : cubit.state is NoWordSearchedState
                    ? getDictionaryFormWidget(context)
                    : SizedBox(),
      ),
    );
  }
}
