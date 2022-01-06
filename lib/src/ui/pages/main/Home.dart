import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokdex/src/AppLocalizations.dart';
import 'package:pokdex/src/cubit/home/home_cubit.dart';
import 'package:pokdex/src/ui/ui_constant/theme/AppColors.dart';
import 'package:pokdex/src/ui/ui_constant/theme/string.dart';
import 'package:pokdex/src/ui/widgets/CustomListItem.dart';
import 'package:pokdex/src/ui/widgets/CustomLoadingWidget.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context).fetchPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is ErrorState) {
          Toast.show("${state.message}", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      },
      builder: (context, state) {
        if (state is LoadingState)
          return CustomLoadingWidget();
        else
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                leading: Container(),
                bottom: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // Creates border
                    color: AppColors.of(context).mainColor(1),
                  ),
                  labelColor: Colors.black,
                  onTap: (index) {
                    // Tab index when user select it, it start from zero
                  },
                  tabs: [
                    Tab(
                      text:
                          AppLocalizations.of(context)!.translate(Strings.HOME),
                      icon: Icon(Icons.add_to_home_screen_outlined),
                    ),
                    Tab(
                      text: AppLocalizations.of(context)!
                          .translate(Strings.FAVOURITES),
                      icon: Icon(Icons.favorite),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  CustomListItem(
                    isNormalList: true,
                  ),
                  CustomListItem(
                    isNormalList: false,
                  ),
                ],
              ),
            ),
          );
      },
    );
  }
}
