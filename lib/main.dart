import 'package:flutter/material.dart';

class Person {
  String name;
  String email;
  String contact;
  String password;

  Person({
    required this.name,
    required this.email,
    required this.contact,
    required this.password,
  });
}

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  List<Person> records = [];

  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Global key for the form
  final _formKey = GlobalKey<FormState>();

  void deleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Delete",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Are you sure you want to delete this record?",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  records.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  void editDialog(int index) {
    final person = records[index];
    nameController.text = person.name;
    emailController.text = person.email;
    contactController.text = person.contact;
    passwordController.text = person.password;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Edit Personal Information",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "Enter Your Name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    controller: nameController,
                    maxLength: 32,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      if (RegExp(r'\d').hasMatch(value)) {
                        return "Name should not contain numbers";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: "Enter Your Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: contactController,
                    maxLength: 11,
                    decoration: InputDecoration(
                      labelText: 'Contact No',
                      hintText: "Enter Your Contact No",
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your contact no";
                      } else if (value.length != 11) {
                        return "Contact number must be 11 digits";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    obscuringCharacter: '*',
                    maxLength: 15,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    records[index] = Person(
                      name: nameController.text,
                      email: emailController.text,
                      contact: contactController.text,
                      password: passwordController.text,
                    );
                  });
                  nameController.clear();
                  emailController.clear();
                  contactController.clear();
                  passwordController.clear();

                  Navigator.pop(context);
                }
              },
              child: Text(
                "Save",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Records",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.grey,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Add Personal Information",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Name",
                                        hintText: "Enter Your Name",
                                        prefixIcon: Icon(Icons.person),
                                        border: OutlineInputBorder(),
                                      ),
                                      controller: nameController,
                                      maxLength: 32,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your name";
                                        }
                                        if (RegExp(r'\d').hasMatch(value)) {
                                          return "Name should not contain numbers";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.text,
                                    ),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        hintText: "Enter Your Email",
                                        prefixIcon: Icon(Icons.email),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your email";
                                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                          return "Please enter a valid email";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      controller: contactController,
                                      maxLength: 11,
                                      decoration: InputDecoration(
                                        labelText: 'Contact No',
                                        hintText: "Enter Your Contact No",
                                        prefixIcon: Icon(Icons.phone),
                                        border: OutlineInputBorder(),
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your contact no";
                                        } else if (value.length != 11) {
                                          return "Contact number must be 11 digits";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      controller: passwordController,
                                      obscureText: true,
                                      obscuringCharacter: '*',
                                      maxLength: 15,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        prefixIcon: Icon(Icons.lock),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your password";
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      records.add(Person(
                                        name: nameController.text,
                                        email: emailController.text,
                                        contact: contactController.text,
                                        password: passwordController.text,
                                      ));
                                    });
                                    nameController.clear();
                                    emailController.clear();
                                    contactController.clear();
                                    passwordController.clear();

                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  "OK",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "Add a Record",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final person = records[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                "Record Details:",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Name: ${person.name}", style: TextStyle(fontSize: 16)),
                                    SizedBox(height: 10),
                                    Text("Email: ${person.email}", style: TextStyle(fontSize: 16)),
                                    SizedBox(height: 10),
                                    Text("Contact: ${person.contact}", style: TextStyle(fontSize: 16)),
                                    SizedBox(height: 10),
                                    Text("Password: ${person.password}", style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Close",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    editDialog(index);
                                  },
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text("Person: ${person.name}", style: TextStyle(fontWeight: FontWeight.bold)),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteDialog(index),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RecordScreen(),
  ));
}
