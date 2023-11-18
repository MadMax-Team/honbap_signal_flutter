import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_list_bloc.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_list_event.dart';
import 'package:honbap_signal_flutter/bloc/signal/signal_list_state.dart';
import 'package:honbap_signal_flutter/constants/gaps.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';
import 'package:honbap_signal_flutter/cubit/signal_apply_cubit.dart';
import 'package:honbap_signal_flutter/cubit/user_cubit.dart';
import 'package:honbap_signal_flutter/screens/signal/signal_userprofile_dialog.dart';
import 'package:honbap_signal_flutter/screens/signal/widgets/signal_usercard_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SignalListScreen extends StatefulWidget {
  const SignalListScreen({super.key});

  @override
  State<SignalListScreen> createState() => _SignalListScreenState();
}

class _SignalListScreenState extends State<SignalListScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '내 근처 시그널',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<SignalListBloc, SignalListState>(
        buildWhen: (previous, current) => previous.signals != current.signals,
        builder: (context, state) {
          if (state.status == SignalListStatus.init) {
            context.read<SignalListBloc>().add(SignalListGetEvent(
                  jwt: context.read<UserCubit>().state.user!.jwt!,
                ));
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
          if (state.status == SignalListStatus.loading &&
              state.signals.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
          if (state.status == SignalListStatus.error) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message ?? 'error'),
                  Gaps.v20,
                  TextButton(
                    onPressed: () {
                      context.read<SignalListBloc>().add(SignalListGetEvent(
                            jwt: context.read<UserCubit>().state.user!.jwt!,
                          ));
                    },
                    child: const Text('다시 시도하기'),
                  ),
                ],
              ),
            );
          }
          return SmartRefresher(
            controller: _refreshController,
            onRefresh: () {
              context.read<SignalListBloc>().add(SignalListGetEvent(
                    jwt: context.read<UserCubit>().state.user!.jwt!,
                  ));
              _refreshController.refreshCompleted();
            },
            onLoading: () {
              _refreshController.loadComplete();
            },
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(Sizes.size16),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: Sizes.size96 * 3,
                      mainAxisSpacing: Sizes.size20,
                      crossAxisSpacing: Sizes.size20,
                      childAspectRatio: 4 / 5,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context_) {
                                return SignalUserDialog(
                                  signal: state.signals[index],
                                  cubit: context.read<SignalApplyCubit>(),
                                );
                              },
                            );
                          },
                          child: SignalUserCard(
                            signal: state.signals[index],
                          ),
                        );
                      },
                      childCount: state.signals.length,
                    ),
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
