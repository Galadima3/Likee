import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:likee/components/book_list.dart';
import 'package:likee/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onFavoritePress(int index) {
    if (favoriteBooksBox.containsKey(index)) {
      favoriteBooksBox.delete(index);
      return;
    }
    favoriteBooksBox.put(index, books[index]);
  }

  Widget getIcon(int index) {
    if (favoriteBooksBox.containsKey(index)) {
      return const Icon(Icons.favorite, color: Colors.red);
    }
    return const Icon(Icons.favorite_border);
  }

  late Box<String> favoriteBooksBox;
  @override
  void initState() {
    favoriteBooksBox = Hive.box(favoritesBox);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorite Texts'),
          centerTitle: true,
        ),
        body: ValueListenableBuilder(
          valueListenable: favoriteBooksBox.listenable(),
          builder: (context, Box box, child) {
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(books[index]),
                  trailing: IconButton(
                    icon: getIcon(index),
                    onPressed: () => onFavoritePress(index),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
