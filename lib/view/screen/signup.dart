import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/auth_controller.dart';
import 'home_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 250, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign Up',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'username',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [

                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: controller.txtFirstName,
                        keyboardType: TextInputType.name,
                        cursorColor: Colors.black45,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(9),
                          labelText: 'First Name',
                          labelStyle: GoogleFonts.poppins(
                            color: Color(0xffC7C9D9),
                            fontSize: 12,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Color(0xffC7C9D9),
                              width: 1,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Color(0xffC7C9D9),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Email',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: controller.txtEmail,
                  cursorColor: Colors.black45,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(9),
                    labelText: 'Enter your email',
                    labelStyle: GoogleFonts.poppins(
                      color: Color(0xffC7C9D9),
                      fontSize: 12,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Color(0xffC7C9D9),
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Color(0xffC7C9D9),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Password',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: controller.txtPassword,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black45,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(9),
                    labelText: 'Enter your password',
                    labelStyle: GoogleFonts.poppins(
                      color: Color(0xffC7C9D9),
                      fontSize: 12,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Color(0xffC7C9D9),
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Color(0xffC7C9D9),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have account?',
                    style: GoogleFonts.poppins(
                      color: Color(0xffBDBDBD),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  Map m1 = {
                    'firstName': controller.txtFirstName.text,
                    'email': controller.txtEmail.text,
                    'photoUrl':
                        'https://www.robertlowdon.com/wp-content/uploads/2022/06/toronto-headshot.webp',
                  };

                  controller.signUpMethod(
                      controller.txtEmail.text, controller.txtPassword.text);
                  controller.txtEmail.clear();
                  controller.txtPassword.clear();
                  controller.txtFirstName.clear();

                  Get.to(ContactListScreen());
                },
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff3A6D8C),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
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
}
