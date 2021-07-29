import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget default_button (
{

  double width = double.infinity ,
  double hight = 40 ,
  Color background = Colors.blue,
  @required Function function,
  @required String text ,
}
    )=>Container(
  width: width,
  height: hight,
  color: background,
  child: MaterialButton(
    onPressed: function,
    child: Text(text.toUpperCase() , style: TextStyle(color: Colors.white),),
  ),
) ;

Widget default_Edit_text (
{
  bool is_clickable = true,
  String hint ,
  IconData suffix ,
  IconData prefix ,
  Function onsubmit ,
  Function ontab ,
  Function onchanged ,
  bool obsecure = false  ,
  @required Function Validate,
  @required TextEditingController controller,
  @required TextInputType type ,
  Function suffixpress ,
}
)=>TextFormField(
  enabled: is_clickable,
  onTap: ontab,
  obscureText: obsecure,
  controller: controller,
  keyboardType:  type,
  onFieldSubmitted: onsubmit,
  onChanged: onchanged,
    validator: Validate ,
  decoration: InputDecoration(
      labelText: hint ,
      border: OutlineInputBorder(),
      prefixIcon: IconButton(icon:Icon(prefix) ,
      onPressed: suffixpress,) ,
     suffixIcon: Icon(suffix) ,
  ),
);

void Navigateto(context , widget){
  Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>widget,),);
  }
void Navigatetoandremove(context , widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget,),
        (Route<dynamic> route) => false,
  );
}



