import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/components/icon_broken.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/models/post_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getUserData();
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).posts.isNotEmpty &&
                    SocialCubit.get(context).userModel != null,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Card(
                          shadowColor: SocialCubit.get(context).isDark
                              ? Colors.white
                              : Colors.black,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5.0,
                          child: Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              Image(
                                image: const NetworkImage(
                                  'https://img.freepik.com/free-photo/body-language_273609-6129.jpg?w=996&t=st=1666464885~exp=1666465485~hmac=6e3ed76cafa55751c6453d94b1a65879ac0e8a7a1aaa1d9a8e8ba8bb6f54fcc6',
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.29,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  right: 8.0,
                                ),
                                child: Text(
                                  'Communicate with friends',
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildFeedsItem(
                              SocialCubit.get(context).posts[index],
                              context,
                              index),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 6.0,
                          ),
                          itemCount: SocialCubit.get(context).posts.length,
                        ),
                      ],
                    ),
                  ),
                ),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildFeedsItem(PostModel model, context, index) => Card(
        color:
            SocialCubit.get(context).isDark ? HexColor('333739') : Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 6.0,
        shadowColor:
            SocialCubit.get(context).isDark ? Colors.white : Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 26.0,
                    backgroundImage: NetworkImage(
                      '${model.image}',
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: SocialCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Icon(
                              Icons.check_circle,
                              size: 18.0,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                height: 1.5,
                                color: Colors.grey,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      IconBroken.More_Circle,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                ),
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: SocialCubit.get(context).isDark
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      fontSize: 14.0,
                    ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      4.0,
                    ),
                    child: Image(
                      image: NetworkImage(
                        '${model.postImage}',
                      ),
                      height: MediaQuery.of(context).size.height * 0.26,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                            size: 18.0,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            IconBroken.Chat,
                            color: Colors.amber,
                            size: 18.0,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${SocialCubit.get(context).likes[index]} comment',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 15.0,
                ),
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                      '${SocialCubit.get(context).userModel!.image}',
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'Write a comment...',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        SocialCubit.get(context).likePost(
                          SocialCubit.get(context).postId[index],
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                            size: 18.0,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Like',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
