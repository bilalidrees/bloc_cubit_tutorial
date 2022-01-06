import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokdex/src/cubit/home/home_cubit.dart';
import 'package:pokdex/src/cubit/utility/AppConfig.dart';
import 'package:pokdex/src/model/Pokemon.dart';
import 'package:pokdex/src/ui/ui_constant/theme/AppColors.dart';

class CustomListItem extends StatelessWidget {
  bool? isNormalList;

  CustomListItem({this.isNormalList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: isNormalList!
            ? BlocProvider.of<HomeCubit>(context).pokemonList!.length
            : BlocProvider.of<HomeCubit>(context).userFavPokemonList!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Pokemon pokemon = isNormalList!
              ? BlocProvider.of<HomeCubit>(context).pokemonList![index]
              : BlocProvider.of<HomeCubit>(context).userFavPokemonList![index];
          return Container(
            width: double.infinity,
            margin: EdgeInsets.all(AppConfig.of(context).appWidth(5)),
            decoration: BoxDecoration(
                color: Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: AppConfig.of(context).appWidth(4),
                      bottom: AppConfig.of(context).appWidth(4),
                      right: AppConfig.of(context).appWidth(5),
                      left: AppConfig.of(context).appWidth(5)),
                  child: Text(
                    " ${pokemon.name}",
                    style: TextStyle(
                        fontSize: AppConfig.of(context).appWidth(7),
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                if (isNormalList!)
                  Container(
                    margin: EdgeInsets.only(
                        top: AppConfig.of(context).appWidth(4),
                        bottom: AppConfig.of(context).appWidth(4),
                        right: AppConfig.of(context).appWidth(5)),
                    child: IconButton(
                      icon: pokemon.isFav!
                          ? Icon(
                              Icons.star,
                              color: AppColors.of(context).mainColor(1),
                              size: AppConfig.of(context).appWidth(7),
                            )
                          : Icon(
                              Icons.star_border,
                              color: AppColors.of(context).mainColor(1),
                              size: AppConfig.of(context).appWidth(7),
                            ),
                      onPressed: () {
                        bool status = pokemon.isFav!;
                        BlocProvider.of<HomeCubit>(context)
                            .changeFavState(index, !status);
                      },
                    ),
                  )
              ],
            ),
          );
        });
  }
}
