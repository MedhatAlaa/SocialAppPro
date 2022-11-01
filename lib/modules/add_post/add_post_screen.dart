import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/icon_broken.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({Key? key}) : super(key: key);
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getUserData();
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    IconBroken.Arrow___Left_2,
                  ),
                ),
                titleSpacing: 0.0,
                title: const Text(
                  'Create Post',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (SocialCubit.get(context).postImage != null) {
                        SocialCubit.get(context).uploadPostImage(
                          dateTime: DateTime.now().toString(),
                          text: textController.text,
                        );
                      } else {
                        SocialCubit.get(context).createPost(
                          dateTime: DateTime.now().toString(),
                          text: textController.text,
                        );
                      }
                    },
                    child: const Text('POST'),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if (state is SocialCreatePostLoadingState ||
                        state is SocialUploadPostImageLoadingState)
                      const LinearProgressIndicator(),
                    if (state is SocialCreatePostLoadingState ||
                        state is SocialUploadPostImageLoadingState)
                      const SizedBox(
                        height: 10.0,
                      ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 26.0,
                          backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel!.image}',
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          child: Text(
                            '${SocialCubit.get(context).userModel!.name}',
                            style: Theme.of(context).textTheme.bodyText1!,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: textController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'What is in your mind ....',
                          hintStyle:
                              Theme.of(context).textTheme.caption!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ),
                    ),
                    if (SocialCubit.get(context).postImage != null)
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.0),
                              child: Image(
                                image: FileImage(
                                  SocialCubit.get(context).postImage!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: CircleAvatar(
                              radius: 20.0,
                              child: IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).removePostImage();
                                },
                                icon: const Icon(
                                  Icons.close_sharp,
                                  size: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton.icon(
                            onPressed: () {
                              SocialCubit.get(context).getPostImage();
                            },
                            icon: const Icon(
                              IconBroken.Image,
                            ),
                            label: const Text(
                              'Add Photo',
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              '# tags',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
