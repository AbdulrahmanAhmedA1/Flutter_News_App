import 'package:flutter/material.dart';
import 'package:flutter_application_news/const.dart';
import 'package:flutter_application_news/cubit/cubit.dart';
import 'package:flutter_application_news/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<NewsCubit>(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              themeModeIcon(cubit),
            ],
            title: appTitle,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: padding,
                  child: searchTextField(searchController, cubit, context),
                ),
                cubit.search.isNotEmpty
                    ? Expanded(
                        child: ListView.separated(
                            separatorBuilder: (context, i) => divider(),
                            itemCount: countArticles(cubit, cubit.search),
                            itemBuilder: (context, index) {
                              return articleItem(
                                  context, cubit, index, cubit.search);
                            }),
                      )
                    : searchController.text.isNotEmpty
                        ? Center(child: CircularProgressIndicator())
                        : Container(),
              ],
            ),
          ),
        );
      },
    );
  }

  TextFormField searchTextField(TextEditingController searchController,
      NewsCubit cubit, BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyText1,
      keyboardType: TextInputType.text,
      validator: (val) {
        return val.isEmpty ? 'search must not be empty' : null;
      },
      onChanged: (value) {
        cubit.getSearch(value);
        print(cubit.search.length);
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.search_rounded),
          labelText: 'Search',
          hintText: 'Search',
          border: OutlineInputBorder()),
    );
  }

  final padding = const EdgeInsets.all(15);
}
