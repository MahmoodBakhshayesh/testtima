import 'dart:developer';
import 'dart:math' as math;
import 'package:artemis_ui_kit/artemis_ui_kit.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/classes/people_class.dart';
import '../../core/constants/ui.dart';
import '../../widgets/DotButton.dart';
import '../../widgets/MyTextField.dart';
import '../../widgets/user_avatar.dart';
import 'users_controller.dart';
import 'users_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';

class UsersViewPhone extends StatefulWidget {
  const UsersViewPhone({super.key});

  @override
  State<UsersViewPhone> createState() => _UsersViewPhoneState();
}

class _UsersViewPhoneState extends State<UsersViewPhone> {
  static UsersController myUsersController = getIt<UsersController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myUsersController.getUserList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            myUsersController.showAddUserDialog();
          },
          child: Icon(Icons.person_add),
        ),
        appBar: UsersAppBar(),
        body: Column(
          children: [
            Divider(),
            Expanded(child: PeopleListWidget())],
        ));
  }
}

class UsersAppBar extends StatelessWidget implements PreferredSizeWidget {
  static UsersController myUsersController = getIt<UsersController>();

  const UsersAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(108);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.white,
      alignment: Alignment.center,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      BackButton(
                      ),
                      Text(
                        "Users",
                        style: TextStyle( fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                      Spacer(),
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  myUsersController.getUserList();
                },
                icon: Icon(
                  Icons.refresh,
                ))
          ],
        ),
      ),
    );
  }
}

class PeopleListWidget extends ConsumerStatefulWidget {
  const PeopleListWidget({super.key});

  @override
  ConsumerState<PeopleListWidget> createState() => _PeopleListWidgetState();
}

class _PeopleListWidgetState extends ConsumerState<PeopleListWidget> {
  final TextEditingController searchC = TextEditingController();

  @override
  void initState() {
    searchC.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    searchC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<People> peoples = ref.watch(peopleListProvider).where((f) => f.validateSearch(searchC.text)).toList();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Expanded(
                  child: MyTextField(
                    height: 48,
                    prefixIcon: const Icon(Icons.search),
                    controller: searchC,
                    placeholder: "Name, Email, ...",
                  ))
            ],
          ),
        ),
        Expanded(
          child: CustomMaterialIndicator(
            onRefresh: () async {
              await getIt<UsersController>().getUserList();
            },
            // Your refresh logic
            backgroundColor: Colors.transparent,
            useMaterialContainer: false,
            indicatorBuilder: (context, controller) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: CircularProgressIndicator(
                  color: context.mainColor,
                  value: controller.state.isLoading ? null : math.min(controller.value, 1.0),
                ),
              );
            },
            child: ref.watch(loadingUsersProvider)
                ? Center(
              child: SpinKitCubeGrid(
                size: 60,
                color: context.mainColor,
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.only(bottom: 105.0),
              itemBuilder: (c, i) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: PeopleWidget(
                  people: peoples[i],
                  index: i,
                ),
              ),
              itemCount: peoples.length,
            ),
          ),
        ),
      ],
    );
  }
}

class PeopleWidget extends StatelessWidget {
  final People people;
  final int index;
  final void Function()? onTap;

  const PeopleWidget({super.key, required this.people, required this.index, this.onTap});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool isOdd = index % 2 != 0;
    const TextStyle headerTextStyle = TextStyle(fontWeight: FontWeight.w600, color: MyColors.black, fontSize: 11);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: !isOdd ? MyColors.white2 : MyColors.white3,
        ),
        child: Row(
          spacing: 8,
          children: [
            Stack(
              children: [
                Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 1)),
                    child: UserAvatar(
                      url: '',
                      hasImage: people.hasImage,
                      people: people,

                    )),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: Icon(Icons.circle,color: people.enable ? MyColors.green : Colors.red,size: 12,))
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: ArtemisCardField(title: "Username", value: people.username ?? '-', scale: 0.7)),
                      Expanded(child: ArtemisCardField(title: "Fist Name", value: people.firstname ?? '-', scale: 0.7)),
                      Expanded(child: ArtemisCardField(title: "Last Name", value: people.lastname ?? '-', scale: 0.7)),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(flex: 2, child: ArtemisCardField(title: "Email", value: people.email ?? '-', scale: 0.7)),
                      // Expanded(flex:1,child: ArtemisCardField(title: "Phone", value: people.phone??'-',scale: 0.7)),
                    ],
                  ),

                  // Text(people.email??''),
                  // Text(people.username??''),
                ],
              ),
            ),
            DotButton(
              icon: Icons.settings,
              onPressed: () {
                getIt<UsersController>().showEditUserDialog(people);
              },
            )
          ],
        ),
      ),
    );
  }
}
