// import 'package:flutter/material.dart';
// import 'package:myapp/Model/cardObject.dart';

// Widget CardSearchForm(
//     BuildContext context, TextEditingController searchController) {
//   return Builder(builder: (BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search App'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               showSearch(
//                 context: context,
//                 delegate: CustomSearchDelegate(),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: searchController,
//               decoration: InputDecoration(
//                 hintText: 'Enter your search query',
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Handle search button press
//                 String searchQuery = searchController.text;
//                 print('Search query: $searchQuery');
//                 // Implement your search logic here
//               },
//               child: Text('Search'),
//             ),
//           ],
//         ),
//       ),
//     );
//   });
// }

// class CustomSearchDelegate extends SearchDelegate<String> {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     // Build actions for the AppBar (e.g., clear query button)
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     // Build leading icon for the AppBar (e.g., back button)
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, "");
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // Build the results based on the current query
//     return Center(
//       child: Text('Search results for: $query'),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // Build suggestions based on the current query
//     return Center(
//       child: Text('Suggestions for: $query'),
//     );
//   }
// }
