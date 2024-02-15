import 'package:flutter/material.dart';

// class CardSearchFormApp extends StatefulWidget {
//   const CardSearchFormApp({Key? key}) : super(key: key);
//   @override
//   CardSearchFormState createState() => CardSearchFormState();
// }

// class CardSearchFormState extends State {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController searchController = TextEditingController();

//     return Container(child: CardSearchForm(context, searchController));
//   }
// }

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Build actions for the AppBar (e.g., clear query button)
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          // queryの単語でFirestoreのDBを検索
        },
      ),
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Build leading icon for the AppBar (e.g., back button)
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Build the results based on the current query
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Build suggestions based on the current query
    return Center(
      child: Text('Suggestions for: $query'),
    );
  }
}
