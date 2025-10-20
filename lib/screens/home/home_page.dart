import 'package:capstone_app/models/analysis_history.dart';
import 'package:capstone_app/providers/home_provider.dart';
import 'package:capstone_app/providers/profile_provider.dart';
import 'package:capstone_app/screens/common/empty_state_view.dart';
import 'package:capstone_app/screens/common/error_state_view.dart';
import 'package:capstone_app/screens/common/widgets/custom_dialog.dart';
import 'package:capstone_app/screens/home/widgets/bottom_sheet_delete_analysis_history.dart';
import 'package:capstone_app/screens/home/widgets/item_analysis_history_card.dart';
import 'package:capstone_app/screens/input_child_data/input_child_data_page.dart';
import 'package:capstone_app/screens/profile/profile_page.dart';
import 'package:capstone_app/services/auth_service.dart';
import 'package:capstone_app/services/firestore_service.dart';
import 'package:capstone_app/services/tf_lite_service.dart';
import 'package:capstone_app/utils/app_colors.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:capstone_app/utils/ui_state.dart';
import 'package:capstone_app/widgets/name_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/analysis_result_provider.dart';
import '../../providers/input_child_data_provider.dart';
import '../analysis_result/analysis_result_page.dart';
import '../common/widgets/custom_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().fetchAnalysisHistoryList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildAppBar(),
          _buildSearchBar(),
          Expanded(
            child: Consumer<HomeProvider>(
              builder: (context, provider, child) {
                return switch (provider.uiState) {
                  UiNoneState<List<AnalysisHistory>>() => const SizedBox(),
                  UiLoadingState<List<AnalysisHistory>>() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  UiSuccessState<List<AnalysisHistory>>(
                    data: var analysisHistoryList,
                  ) =>
                    _buildLoadedStateView(provider, analysisHistoryList),
                  UiErrorState<List<AnalysisHistory>>(
                    errorTitle: var title,
                    errorMessage: var message,
                  ) =>
                    ErrorStateView(
                      title: title,
                      message: message,
                      onRefresh: () {
                        provider.fetchAnalysisHistoryList();
                      },
                    ),
                  UiEmptyState<List<AnalysisHistory>>(
                    title: var title,
                    message: var message,
                  ) =>
                    EmptyStateView(title: title, message: message),
                };
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChangeNotifierProvider(
                  create: (context) => InputChildDataProvider(
                    context.read<TFLiteService>()..loadModel(),
                  ),
                  child: const InputChildDataPage(),
                );
              },
            ),
          );
        },
        shape: const CircleBorder(),
        backgroundColor: AppColors.mainThemeColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      color: AppColors.mainThemeColor,
      child: Column(
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                NameAvatar(
                  name: context.read<HomeProvider>().user?.displayName ?? '',
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat datang,',
                        style: AppTextStyles.bodySmallText.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        context.read<HomeProvider>().user?.displayName ?? '',
                        style: AppTextStyles.bodyHiEmText.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ChangeNotifierProvider(
                            create: (context) =>
                                ProfileProvider(context.read<AuthService>()),
                            child: const ProfilePage(),
                          );
                        },
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.settings,
                      color: AppColors.mainThemeColor,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 16),
      color: AppColors.mainThemeColor,
      child: CustomDefaultTextField(
        controller: _searchController,
        hint: 'Nama anak...',
        prefixIcon: const Icon(Icons.search),
        onChanged: (value) {
          context.read<HomeProvider>().searchAnalysisHistory(value);
        },
      ),
    );
  }

  Widget _buildLoadedStateView(
    HomeProvider provider,
    List<AnalysisHistory> listAnalysisHistory,
  ) {
    return SafeArea(
      top: false,
      bottom: true,
      child: RefreshIndicator(
        onRefresh: provider.fetchAnalysisHistoryList,
        child: ListView.separated(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: 32,
          ),
          itemBuilder: (context, index) {
            return ItemAnalysisHistoryCard(
              history: listAnalysisHistory[index],
              onClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ChangeNotifierProvider(
                        create: (context) => AnalysisResultProvider(
                          listAnalysisHistory[index],
                          context.read<FirestoreService>(),
                          context.read<AuthService>(),
                        ),
                        child: const AnalysisResultPage(),
                      );
                    },
                  ),
                );
              },
              onDelete: () async {
                final result = await showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return BottomSheetDeleteAnalysisHistory(
                      analysisHistory: listAnalysisHistory[index],
                      onDelete: () {
                        Navigator.pop(context, true);
                      },
                      onCancel: () {
                        Navigator.pop(context, false);
                      },
                    );
                  },
                );

                if (result != null && result) {
                  if (!context.mounted) return;
                  showProgressDialog(context, 'Menghapus data...');
                  final isDeleteSuccess = await provider
                      .deleteAnalysisHistory(
                    listAnalysisHistory[index].id.toString(),
                  );

                  // close the progress dialog
                  if (!context.mounted) return;
                  Navigator.pop(context);
                  if (isDeleteSuccess) {
                    provider.fetchAnalysisHistoryList();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Gagal menghapus data'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                }
              },
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
          itemCount: listAnalysisHistory.length,
        ),
      ),
    );
  }
}
