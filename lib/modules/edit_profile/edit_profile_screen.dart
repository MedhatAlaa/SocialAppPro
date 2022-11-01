import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/icon_broken.dart';
import 'package:social_app/components/reus_components.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = model!.name!;
        phoneController.text = model.phone!;
        bioController.text = model.bio!;
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
              'Edit Profile',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUserData(
                    name: nameController.text,
                    bio: bioController.text,
                    phone: phoneController.text,
                  );
                },
                child: const Text(
                  'UPDATE',
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.37,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(4.0),
                                    topLeft: Radius.circular(4.0),
                                  ),
                                  child: Image(
                                    image: coverImage == null
                                        ? NetworkImage('${model.coverImage}')
                                        : FileImage(coverImage)
                                            as ImageProvider,
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
                                      SocialCubit.get(context).getCoverImage();
                                    },
                                    icon: const Icon(
                                      IconBroken.Camera,
                                      size: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 74.0,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 70.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(
                                        '${model.image}',
                                      )
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: CircleAvatar(
                                radius: 20.0,
                                child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                  icon: const Icon(
                                    IconBroken.Camera,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  if (profileImage != null || coverImage != null)
                    Row(
                      children: [
                        if (profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  onPressed: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text,
                                    );
                                  },
                                  text: 'Upload Profile',
                                ),
                                if (state
                                    is SocialUploadProfileImageLoadingState)
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                if (state
                                    is SocialUploadProfileImageLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        if (coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  onPressed: () {
                                    SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text,
                                    );
                                  },
                                  text: 'Upload Cover',
                                ),
                                if (state is SocialUploadCoverImageLoadingState)
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                if (state is SocialUploadCoverImageLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      prefixIcon: const Icon(
                        IconBroken.User,
                        color: Colors.amberAccent,
                      ),
                      labelText: 'Name',
                      validator: (name) {
                        if (name!.isEmpty) {
                          return 'Name must not be empty';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                      controller: bioController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      prefixIcon: const Icon(
                        IconBroken.Info_Circle,
                        color: Colors.amberAccent,
                      ),
                      labelText: 'Bio',
                      validator: (bio) {
                        if (bio!.isEmpty) {
                          return 'Bio must not be empty';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    obscureText: false,
                    prefixIcon: const Icon(
                      IconBroken.Call,
                      color: Colors.amberAccent,
                    ),
                    labelText: 'Phone',
                    validator: (phone) {
                      if (phone!.isEmpty) {
                        return 'Phone must not be empty';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
