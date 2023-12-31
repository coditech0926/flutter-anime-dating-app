import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senpai/core/graphql/blocs/mutation/mutation_bloc.dart';
import 'package:senpai/core/profile_fill/favorite_anime/add_favorite_anime_bloc.dart';
import 'package:senpai/core/user/blocs/update_user/update_user_bloc.dart';
import 'package:senpai/core/user/blocs/verify_photo_user/verify_photo_user_bloc.dart';
import 'package:senpai/core/widgets/loading.dart';
import 'package:senpai/data/text_constants.dart';
import 'package:senpai/dependency_injection/injection.dart';
import 'package:senpai/screens/profile_fill/bloc/profile_fill_bloc.dart';
import 'package:senpai/screens/verify_photo/bloc/verify_photo_bloc.dart';

import 'package:senpai/screens/verify_photo/widgets/verify_photo_content.dart';
import 'package:senpai/utils/methods/aliases.dart';

class VerifyPhotoProfileFillPage extends StatelessWidget {
  const VerifyPhotoProfileFillPage({super.key, this.photo});

  final File? photo;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VerifyPhotoBloc>(
          create: (context) => VerifyPhotoBloc()
            ..add(OnVerifyPhotoInitEvent(
              userId: BlocProvider.of<ProfileFillBloc>(context).userId,
              photo: photo,
              hasProfileFillBloc: true,
            )),
        ),
        BlocProvider(
          create: (_) => getIt<VerifyPhotoUserBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<UpdateUserBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<AddFavoriteAnimeBloc>(),
        ),
      ],
      child: Stack(
        children: [
          const VerifyPhotoContent(),
          _buildVerifyPhotoUserListeners(),
          _buildUpdateUserListeners(),
          _buildAddAnimeListListeners(),
        ],
      ),
    );
  }

  Widget _buildVerifyPhotoUserListeners() {
    return BlocBuilder<VerifyPhotoUserBloc, MutationState>(
      builder: (context, state) {
        return state.maybeWhen<Widget>(
            loading: () => const SenpaiLoading(),
            failed: (error, result) {
              _showSnackBarError(context, TextConstants.serverError);
              return const SizedBox.shrink();
            },
            succeeded: (data, result) {
              final bloc = BlocProvider.of<VerifyPhotoBloc>(context);
              final response = result.data;

              if (response == null) {
                // handle this fatal error
                logIt.wtf("A successful empty response just got set user");
                return const SizedBox.shrink();
              }
              final user = response["submitVerifyRequest"]["user"];
              if (user == null) {
                _showSnackBarError(context, TextConstants.nullUser);
                logIt.error("A user with error");
                return const SizedBox.shrink();
              }
              bloc.add(OnOpenStartMatchSceenEvent());
              return const SizedBox.shrink();
            },
            orElse: () => const SizedBox.shrink());
      },
    );
  }

  Widget _buildUpdateUserListeners() {
    return BlocConsumer<UpdateUserBloc, MutationState>(
      listener: (context, state) {
        state.maybeWhen(
          loading: () {},
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen<Widget>(
            loading: () => const SenpaiLoading(),
            failed: (error, result) {
              _showSnackBarError(context, TextConstants.serverError);
              return const SizedBox.shrink();
            },
            succeeded: (data, result) {
              final response = result.data;

              if (response == null) {
                // handle this fatal error
                logIt.wtf("A successful empty response just got set user");
                return const SizedBox.shrink();
              }

              final user = response["updateUser"]["user"];
              if (user == null) {
                _showSnackBarError(context, TextConstants.nullUser);
                logIt.error("A user with error");
                return const SizedBox.shrink();
              }
              context.router.pushNamed("/home");
              return const SizedBox.shrink();
            },
            orElse: () => const SizedBox.shrink());
      },
    );
  }

  Widget _buildAddAnimeListListeners() {
    return BlocBuilder<AddFavoriteAnimeBloc, MutationState>(
      builder: (context, state) {
        return state.maybeWhen<Widget>(
          loading: () => const SenpaiLoading(),
          succeeded: (data, result) {
            final response = result.data;

            if (response == null) {
              // handle this fatal error
              logIt.wtf("A successful empty response just got recorded");
              return const SizedBox.shrink();
            }
            List<dynamic> listAnime =
                response["addFavoriteAnime"]["user"]["animes"];

            if (listAnime.isEmpty) {
              _showSnackBarError(context, TextConstants.nullUser);
              logIt.error("A user without an animes tried to again");
              return const SizedBox.shrink();
            }
            final blocProfileFill = BlocProvider.of<ProfileFillBloc>(context);
            final serverBloc = BlocProvider.of<UpdateUserBloc>(context);
            serverBloc.updateUserInfo(user: blocProfileFill.user);
            return const SizedBox.shrink();
          },
          failed: (error, result) {
            _showSnackBarError(context, TextConstants.serverError);
            return const SizedBox.shrink();
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  _showSnackBarError(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'On Snap!',
                message: message,
                contentType: ContentType.failure,
              ),
            ),
          );
      },
    );
  }
}
