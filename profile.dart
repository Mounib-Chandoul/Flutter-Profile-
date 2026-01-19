import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(debugShowCheckedModeBanner: false, home: ProfileScreen()),
);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  final nameController = TextEditingController(text: "Moonib test");
  final phoneController = TextEditingController(text: "12345678");
  final emailController = TextEditingController(text: "chandoulwork@gmail.com");

  bool canEditName = false;
  bool canEditPhone = false;
  bool canEditEmail = false;

  bool nameHasError = false;
  bool phoneHasError = false;
  bool emailHasError = false;

  late AnimationController nameShake;
  late AnimationController phoneShake;
  late AnimationController emailShake;

  @override
  void initState() {
    super.initState();
    nameShake = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    phoneShake = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    emailShake = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  void shake(AnimationController controller) {
    controller.forward(from: 0.0);
  }

  Animation<double> offset(AnimationController controller) {
    return Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Positioned(
                      right: 0,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              AnimatedBuilder(
                animation: nameShake,
                builder: (context, child) => Transform.translate(
                  offset: Offset(offset(nameShake).value, 0),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, color: Colors.white, size: 20),
                    ),
                    title: TextField(
                      controller: nameController,
                      readOnly: !canEditName,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        color: nameHasError ? Colors.red : Colors.black,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        canEditName ? Icons.check : Icons.edit,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          if (canEditName) {
                  
                            if (nameController.text.isEmpty) {
                              nameHasError = true;
                              shake(nameShake);
                              return;
                            }
                            nameHasError = false;
                          }
                          canEditName = !canEditName;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const Divider(indent: 70, endIndent: 20),

              AnimatedBuilder(
                animation: phoneShake,
                builder: (context, child) => Transform.translate(
                  offset: Offset(offset(phoneShake).value, 0),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.phone, color: Colors.white, size: 20),
                    ),
                    title: Row(
                      children: [
                        Image.network(
                          'https://flagcdn.com/w20/tn.png',
                          width: 20,
                        ),
                        const Icon(Icons.arrow_drop_down, color: Colors.grey),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: phoneController,
                            readOnly: !canEditPhone,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              color: phoneHasError ? Colors.red : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        canEditPhone ? Icons.check : Icons.edit,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          if (canEditPhone) {
                            if (phoneController.text.length != 8) {
                              phoneHasError = true;
                              shake(phoneShake);
                              return;
                            }
                            phoneHasError = false;
                          }
                          canEditPhone = !canEditPhone;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const Divider(indent: 70, endIndent: 20),

              AnimatedBuilder(
                animation: emailShake,
                builder: (context, child) => Transform.translate(
                  offset: Offset(offset(emailShake).value, 0),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.email, color: Colors.white, size: 20),
                    ),
                    title: TextField(
                      controller: emailController,
                      readOnly: !canEditEmail,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        color: emailHasError ? Colors.red : Colors.black,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        canEditEmail ? Icons.check : Icons.edit,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          if (canEditEmail) {
                            if (!emailController.text.contains("@")) {
                              emailHasError = true;
                              shake(emailShake);
                              return;
                            }
                            emailHasError = false;
                          }
                          canEditEmail = !canEditEmail;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameShake.dispose();
    phoneShake.dispose();
    emailShake.dispose();
    super.dispose();
  }
}
