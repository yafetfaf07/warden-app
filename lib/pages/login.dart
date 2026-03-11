import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:warden_app/api/auth.dart';
import 'package:warden_app/pages/otp_form.dart';
class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController name = TextEditingController();
  final AuthService service = AuthService();

  final TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Colors.white),
        title: Text(
          "Welcome Back",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      // Extend body behind the AppBar/Status bar for a full-screen image look
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 1. Background Image
          SizedBox(
            height:
                MediaQuery.of(context).size.height * 0.45, // Top 45% of screen
            width: double.infinity,
            child: Image.asset('assets/bg.jpg', fit: BoxFit.cover),
          ),

          // 2. Content Overlay
          SingleChildScrollView(
            child: Column(
              children: [
                // Spacer to push the white container down
                SizedBox(height: MediaQuery.of(context).size.height * 0.35),

                // 3. The White Container for Fields
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Find on-street and off-street parking in Addis instantly",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 25),

                      const SizedBox(height: 20),

                      // Phone Input Container
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (value) {},
                          initialValue: PhoneNumber(isoCode: 'ET'),
                          textFieldController: phoneController,
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG,
                          ),
                          inputDecoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone number',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // 4. Continue Button (Outside the container)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                        255,
                        60,
                        138,
                        62,
                      ), // Specific Green Color
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          20,
                        ), // Extra border radius
                      ),
                      elevation: 4,
                    ),
                    onPressed: () async {
                      try {
                        final (data, isSuccessful) = await service.login(phoneController.text);
                    
                        print("Login success: $isSuccessful");
                    
                        if (!context.mounted) return;
                    
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => OtpForm(phone: phoneController.text),
                          ),
                        );
                      } catch (e) {
                        print("Navigation error: $e");
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Verify Phone Number",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 10),
                        isLoading
                            ? const Icon(
                                Icons.circle_outlined,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                      ],
                    ),
                  ),
                ),

                // Login Link
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        // Navigation logic here
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Signup",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
