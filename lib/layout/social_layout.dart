import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/components/icon_broken.dart';
import 'package:social_app/components/reus_components.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/social_login/social_login_screen.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  cubit.changeThemeMode();
                },
                icon: cubit.isDark
                    ? const Icon(
                        Icons.dark_mode,
                      )
                    : const Icon(
                        Icons.light_mode_outlined,
                      ),
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          drawer: ConditionalBuilder(
            condition: SocialCubit.get(context).userModel != null,
            builder: (context) =>
                buildDrawer(SocialCubit.get(context).userModel!, context),
            fallback: (context) => const CircularProgressIndicator(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavItem(index, context);
            },
            items: cubit.items,
          ),
        );
      },
    );
  }

  Widget buildDrawer(SocialUserModel model, context) => Drawer(
        backgroundColor:
            SocialCubit.get(context).isDark ? HexColor('333739') : Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                      '${model.image}',
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    '${model.name}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 20.0,
                ),
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: const Text('LOGOUT'),
                      trailing: const Icon(
                        IconBroken.Arrow___Right_2,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        navigateAndFinish(
                          context,
                          SocialLoginScreen(),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('SETTINGS'),
                      trailing: const Icon(
                        IconBroken.Setting,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        navigateTo(
                          context,
                          const SettingsScreen(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
