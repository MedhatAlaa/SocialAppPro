import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/icon_broken.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/social_user_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({super.key, required this.socialUserModel});

  var messageController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  SocialUserModel socialUserModel;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(
          receiverId: socialUserModel.uid!,
        );
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    IconBroken.Arrow___Left_2,
                  ),
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 24.0,
                      backgroundImage: NetworkImage('${socialUserModel.image}'),
                    ),
                    const SizedBox(
                      width: 14.0,
                    ),
                    Text(
                      '${socialUserModel.name}',
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ConditionalBuilder(
                        condition: SocialCubit.get(context).messages.isNotEmpty,
                        builder: (context) => Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var message = SocialCubit.get(context)
                                        .messages[index];
                                    if (SocialCubit.get(context)
                                            .userModel!
                                            .uid ==
                                        message.senderId) {
                                      return buildMyMessage(message, context);
                                    } else {
                                      return buildMessage(message, context);
                                    }
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 10.0,
                                  ),
                                  itemCount:
                                      SocialCubit.get(context).messages.length,
                                ),
                              ),
                              if (SocialCubit.get(context).chatImage != null)
                                Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      width: MediaQuery.of(context).size.width,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        child: Image(
                                          image: FileImage(
                                            SocialCubit.get(context).chatImage!,
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
                                            SocialCubit.get(context)
                                                .removeChatImage();
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
                            ],
                          ),
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.grey[300]!,
                          )),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 10.0),
                              child: TextFormField(
                                controller: messageController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'message must not be empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type your message here...',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              SocialCubit.get(context).getChatImage();
                            },
                            icon: const Icon(
                              IconBroken.Camera,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            color: Colors.blue,
                            child: IconButton(
                              onPressed: () {
                                if (SocialCubit.get(context).chatImage !=
                                    null) {
                                  SocialCubit.get(context).uploadChatImage(
                                    receiverId: socialUserModel.uid!,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                } else {
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: socialUserModel.uid!,
                                    text: messageController.text,
                                    dateTime: DateTime.now().toString(),
                                  );
                                }
                              },
                              icon: const Icon(
                                IconBroken.Send,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMyMessage(MessageModel model, context) => Align(
        alignment: Alignment.topRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (model.text != '')
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                ),
                child: Text(
                  '${model.text}',
                ),
              ),
            if (model.chatImage != '')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image(
                      image: NetworkImage('${model.chatImage}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );

  Widget buildMessage(MessageModel model, context) => Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (model.text != '')
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: Text(
                  '${model.text}',
                ),
              ),
            if (model.chatImage != '')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image(
                      image: NetworkImage('${model.chatImage}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
}
