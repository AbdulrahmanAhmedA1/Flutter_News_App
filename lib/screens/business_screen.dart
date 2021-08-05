import 'package:flutter/material.dart';
import 'package:flutter_application_news/const.dart';
import 'package:flutter_application_news/cubit/cubit.dart';
import 'package:flutter_application_news/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<NewsCubit>(context);

        return cubit.business.length > 0
            ? ListView.separated(
                separatorBuilder: (ctx, i) {
                  return divider();
                },
                itemBuilder: (ctx, index) {
                  return articleItem(context, cubit, index, cubit.business);
                },
                itemCount: cubit.business.length,
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }


}
