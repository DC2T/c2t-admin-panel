import 'package:admin/constants.dart';
import 'package:admin/models/Movies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/controllers/ScreenController.dart';

class ActionButtons extends StatelessWidget {
  final Movie mov;
  final Function reload;
  final int pageRecent;
  const ActionButtons({Key key, this.mov, this.reload, this.pageRecent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.all(defaultPadding / 2),
              decoration: BoxDecoration(
                color: Color.fromARGB(20, 0, 255, 0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  print('edit');
                  context
                      .read<ScreenController>()
                      .controlScreen(screenName: 'Modifier');
                },
              )),
          Container(
              margin: EdgeInsets.all(defaultPadding / 2),
              decoration: BoxDecoration(
                color: Color.fromARGB(20, 255, 0, 0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => CupertinoAlertDialog(
                            title: Text('Delete this movie?'),
                            content: Text('Do you accept?'),
                            actions: [
                              CupertinoDialogAction(
                                child: Text('Yes'),
                                onPressed: () {
                                  print('delete movie with id' + mov.id);
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      builder: (_) => CupertinoAlertDialog(
                                            title: Text('Delete Success'),
                                            actions: [
                                              CupertinoDialogAction(
                                                child: Text('OK'),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                              )
                                            ],
                                          ));
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text('No'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ));
                },
              )),
        ],
      ),
    );
  }
}

class EditModal extends StatelessWidget {
  const EditModal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.red,
          )),
    );
  }
}
