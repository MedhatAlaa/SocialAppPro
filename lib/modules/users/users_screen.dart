import 'package:flutter/material.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';


class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Image(
                image: NetworkImage(
                  'https://img.freepik.com/premium-vector/city-map-any-kind-digital-info-graphics-print-publication-gps-map_403715-37.jpg?w=740',
                ),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40.0),
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(200.0),
                  bottomRight: Radius.circular(200.0),
                ),
                color: SocialCubit.get(context).isDark
                    ? Colors.black26
                    : Colors.grey[300],
              ),
              child: Center(
                child: Text(
                  'The Location Will Coming Soon',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
