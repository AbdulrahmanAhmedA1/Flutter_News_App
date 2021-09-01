import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'cubit/cubit.dart';

IconButton themeModeIcon(NewsCubit cubit) {
  return IconButton(
      icon: Icon(Icons.brightness_4_outlined),
      onPressed: () {
        cubit.changeAppThemeMode();
      });
}

InkWell articleItem(BuildContext context, NewsCubit cubit, int index,
    List<dynamic> kindArticles) {
  DateTime date = DateTime.parse(kindArticles[index]['publishedAt']);
  DateFormat.yMMMd().format(date);
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebView(
                    initialUrl: kindArticles[index]['url'].toString(),
                  )));
    },
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 130,
            child: Row(
              children: [
                Container(
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        kindArticles[index]['urlToImage'].toString(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  kindArticles[index]['title'],
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  '${DateFormat.yMMMMEEEEd().format(date)}',
                  style: TextStyle(color: Colors.grey),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Divider divider() {
  return Divider(
    thickness: 2,
    color: Colors.grey[400],
  );
}

int countArticles(NewsCubit cubit, List<dynamic> kindArticle) =>
    kindArticle.length;
Text appTitle = Text('News App');
