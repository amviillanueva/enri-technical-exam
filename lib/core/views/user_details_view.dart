import 'package:flutter/material.dart';
import 'package:flutter_tech_exam/common/route_names.dart';
import 'package:flutter_tech_exam/core/view_models/user_details_view_model.dart';
import 'package:flutter_tech_exam/core/views/base/view.dart';
import 'package:flutter_tech_exam/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: Widget)
@Named(RouteNames.userDetails)
class UserDetailsView extends StatelessWidget
    with ViewMixin<UserDetailsViewModel> {
  UserDetailsView() : super(key: const Key(RouteNames.userDetails));

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: ValueListenableBuilder<UserEntity?>(
        valueListenable: viewModel.user,
        builder: (context, user, child) {
          return user == null
              ? const Center(
                  child: Text('No user selected'),
                )
              : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          user.imageUrl,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
