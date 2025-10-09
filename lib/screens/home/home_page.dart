import 'package:capstone_app/models/analysis_history.dart';
import 'package:capstone_app/providers/home_provider.dart';
import 'package:capstone_app/screens/common/empty_state_view.dart';
import 'package:capstone_app/screens/home/widgets/item_analysis_history_card.dart';
import 'package:capstone_app/screens/input_child_data/input_child_data_page.dart';
import 'package:capstone_app/screens/profile/profile_page.dart';
import 'package:capstone_app/utils/app_colors.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:capstone_app/utils/ui_state.dart';
import 'package:capstone_app/widgets/name_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                  UiSuccessState<List<AnalysisHistory>>(data: var analysisHistoryList) =>
                    _buildLoadedStateView(analysisHistoryList),
                  UiErrorState<List<AnalysisHistory>>() => const SizedBox(),
                  UiEmptyState<List<AnalysisHistory>>() => _buildEmptyState(),
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
            MaterialPageRoute(builder: (context) => const InputChildDataPage()),
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
                // TODO get data from provider
                const NameAvatar(name: 'Luthfi'),
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
                        'Luthfi Soehadak',
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
                    // TODO go to setting page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
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
        onSubmit: (value) {
          context.read<HomeProvider>().filterAnalysisHistoryList(value);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return const EmptyStateView(
      title: 'Belum Ada Riwayat Analisis',
      message:
          'Untuk mulai melakukan pengecekan dengan menekan tombol +. Riwayat analisa yang disimpan akan muncul di sini',
    );
  }

  Widget _buildLoadedStateView(List<AnalysisHistory> listAnalysisHistory) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 32),
      itemBuilder: (context, index) {
        return ItemAnalysisHistoryCard(history: listAnalysisHistory[index]);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16);
      },
      itemCount: listAnalysisHistory.length,
    );
  }
}
