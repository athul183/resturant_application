import 'package:flutter/material.dart';
import 'package:resturant_application/screens/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Future<void> _login(BuildContext context) async {
    String email = _emailController.text.trim();
    if (email.isNotEmpty) {
      // Store the email using SharedPreferences
      await storeEmail(email);
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Email Stored'),
          content: Text('The email $email has been stored.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Show error message if email is empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter a valid email.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  final TextEditingController _emailController = TextEditingController();
  bool passwordobsure = true;
  bool ischecked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        
        children: [

          const SizedBox(height: 40,),

          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
            
              height: 300,
              width: double.infinity,
              child: Image.asset("assets/images/newimg.png",)
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(right: 200,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Log In",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Text("your account",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
              ],
            ),
          ),
          SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 
            40.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'User Name',
                  hintStyle: TextStyle(fontWeight: FontWeight.w400)
                ),),
              ),
            ),
          ),
          const SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 
            40.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextField(
                  obscureText: passwordobsure,
                  decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Password',
                  hintStyle: const TextStyle(fontWeight: FontWeight.w400),
                  
                  suffixIcon: IconButton(onPressed: (){

                    setState(() {
                      passwordobsure = !passwordobsure;
                    });

                  }, icon: Icon(
                    passwordobsure ?
                    Icons.visibility_off : Icons.visibility))
                ),),
              ),
            ),
          ),

          const SizedBox(height: 5,),

          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(value: ischecked, 
                onChanged: (bool? newvalue){
                  setState(() {
                    ischecked = newvalue!;
                  });
                }),
                
                Padding(
                  padding: const EdgeInsets.only(top: 13),
                  child: Text("Remember Me"),
                ),

                SizedBox(width: 70,),

                TextButton(onPressed: (){}, child: Text("Forgot Password?",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.indigo),),)
              ],
            ),
          ),
          SizedBox(height: 50,),

          Padding(
            padding: const EdgeInsets.only(left: 60,right: 60),
            child: ElevatedButton(
              onPressed: (){
                _login(context);
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
              },
              style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(),
                elevation: 10,
                backgroundColor: Colors.orange,
                minimumSize: Size.fromHeight(40)
              ), 
              child: const Text("LOGIN",style: TextStyle(color: Colors.white),)),
          )
          
        ],
      ),
    );
  }
Future<void> storeEmail(String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', email);
}
}