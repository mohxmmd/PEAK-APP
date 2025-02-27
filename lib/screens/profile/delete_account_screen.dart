import 'package:peak_app/screens/profile/delete_account_controller.dart';
import 'package:peak_app/utils/screen_imports.dart';
import 'package:peak_app/widgets/back_button.dart';

class DeleteAccountScreen extends StatelessWidget {
  DeleteAccountScreen({super.key});
  final controller = Get.put(DeleteAccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomBackButton(),
                  ),
                  Text(
                    'Delete Account',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1.0,
              color: Color(0xFF606363),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Delete Your Account?',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'This action will permanently delete your account and all associated data. This cannot be undone.',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w100,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () => _showDeleteConfirmationDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.withOpacity(0.9),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Delete Account',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
          contentPadding: const EdgeInsets.all(18.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(
                'Are you sure?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'This will permanently delete your account and all data. You cannot undo this action.',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w100,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);

                      controller.deleteUserAccount();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red.withOpacity(0.9),
                      foregroundColor: Colors.white,
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
