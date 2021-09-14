import 'package:admin/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';

Widget buttonDefault(
    {Widget leading,
    Widget trailing,
    String label,
    double width,
    double height,
    Function onTap}) {
  return GestureDetector(
    onTap: onTap ?? null,
    child: Container(
      width: width ?? 50,
      height: height ?? 50,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          color: secondaryColor),
      child: ((leading != null || trailing != null) && label != null)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leading ?? Container(child: null),
                Text(label),
                trailing ?? Container(child: null),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leading != null || trailing != null)
                  trailing ?? leading
                else if (label != null)
                  Text(label)
              ],
            ),
    ),
  );
}

Widget textEditFormFill(
  BuildContext context, {
  TextEditingController controller,
  String initValue,
  double height,
  double width,
  String hintText,
  String labelText,
  String helperText,
  bool obscureText = true,
  Widget suffixIcon,
  Color color,
  Color backgroundColor,
  Function onTap,
  int maxLine = 100,
  bool readOnly = false,
}) {
  return Container(
    child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            labelText ?? '',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        Container(
          height: height ?? 48,
          width: width ?? MediaQuery.of(context).size.width,
          // width: width ?? MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              color: backgroundColor ?? secondaryColor,
              borderRadius: BorderRadius.circular(defaultBorderRadius)),
          child: TextFormField(
            initialValue: initValue,
            readOnly: readOnly,
            onTap: onTap,
            controller: controller,
            cursorColor: Colors.white,
            obscureText: !obscureText,
            style: TextStyle(fontSize: 14.0),
            minLines: 1,
            maxLines: maxLine,
            decoration: InputDecoration(
                hintText: hintText ?? '',
                helperText: helperText,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                suffixIcon: suffixIcon),
          ),
        ),
      ],
    ),
  );
}

Widget netWorkProgressiveImage(BuildContext context, String source){
  return ProgressiveImage(
    placeholder:
    AssetImage('assets/images/placeholder.jpg'),
    // size: 1.87KB
    thumbnail: source.toString() != null
        ? NetworkImage(source.toString(), scale: 0.3)
        : Image.asset('assets/images/no_image.png'),
    // size: 1.29MB
    image: source.toString() != null
        ? NetworkImage(source.toString())
        : Image.asset('assets/images/no_image.png'),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    fadeDuration: const Duration(milliseconds: 500),
    fit: BoxFit.cover,
  );
}

class MultiSelectInput extends StatefulWidget {
  final String typeInput;
  final List<String> items;
  final Function setSelected;

  const MultiSelectInput(
      {Key key, this.typeInput, this.items, this.setSelected})
      : super(key: key);

  @override
  _MultiSelectInputState createState() => _MultiSelectInputState();
}

class _MultiSelectInputState extends State<MultiSelectInput> {
  List<String> selectedItem = [];
  List<String> searchItem = [];
  List<Widget> selected = [];
  String inputSearchItem = '';
  bool showItem = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
          child: ListTile(
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: selected ?? Container(),
              ),
            ),
            trailing: showItem ? Icon(Icons.arrow_drop_up) : Icon(Icons.arrow_drop_down),
            onTap: () {
              setState(() {
                showItem = !showItem;
              });
            },
          ),
        ),
        showItem
            ? Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 48),
                color: Colors.red,
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                            left: defaultPadding, top: defaultPadding / 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration.collapsed(
                                    hintText: 'Search'),
                                onChanged: (val) {
                                  searchItem.clear();
                                  for (var item in widget.items) {
                                    if (item == val) {
                                      searchItem.add(item);
                                      setState(() {});
                                    }
                                  }
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  if (inputSearchItem != '')
                                    showDialog(
                                        context: context,
                                        builder: (_) => CupertinoAlertDialog(
                                              title: Text(
                                                  'Sure you want add $inputSearchItem'),
                                              actions: [
                                                CupertinoDialogAction(
                                                    child: Text('YES'),
                                                    onPressed: () {
                                                      print('added an item');
                                                      Navigator.pop(context);
                                                    }),
                                                CupertinoDialogAction(
                                                    child: Text('NO'),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    })
                                              ],
                                            ));
                                }),
                          ],
                        )),
                    Divider(),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: searchItem.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(searchItem[index]),
                            onTap: () {
                              selectedItem.add(searchItem[index]);
                              selected.add(Container(
                                  color: Colors.green,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: defaultPadding / 2,
                                      vertical: defaultPadding / 3),
                                  margin: EdgeInsets.only(
                                      right: defaultPadding / 3),
                                  child: Text(searchItem[index])));
                              setState(() {});
                            },
                          );
                        }),
                  ],
                ))
            : SizedBox.shrink(),
      ],
    ));
  }
}
