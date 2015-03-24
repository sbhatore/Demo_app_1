# Demo_app_1
**Developer : Siddharth Bhatore **

###Description
Application demonstrating the problem in the Rails cookie system and the need for purpose parameter and signed expiry and purpose to resolve it.

Rails : **4.2.0** Ruby: **2.1.2**
###What application does
The actions for appending in controller "add_append" appends all the input numbers that client has given till now in "append" page, and stores the result in the form of a cookie named "appended". This appended cookie is **signed** using cookies.signed method.

Similarly, actions for adding in controller "add_append" adds all the input numbers that client has given till now in "add" page, and stores the final result in the form of a cookie named "added". This added cookie is also **signed** using cookies.signed method.
###How can the User of this application misuse cookies

Now, there are plugins available for browser which can change the cookie value of any particular cookie available for the page. For Mozilla Firefox, there is a plugin called Cookie Manager+. You can also do all sorts of things with this plugin such as change the name of cookie, change expiry of cookie, etc. 

What a User can do is, for this application, is he can use the value of the "appended cookie" (cookies[:appended]) in place for "added cookie" (cookies[:added]) and vice-versa. So, the cookie which was meant for storing appended values is misused for manipulating the server by sending that value in place for "added cookie" or vice-versa. 

Also, User of this application can control the expiry of any cookie using browser plugins, which the Developer/server may not want. We may want to enforce the expiry of cookie on server-side to some extent.

###Potential solutions
This is a potential threat for any company using a similar kind of application. Signing in value inside  the cookie is not enough. We need to sign expiry and purpose with that of value inside the cookie. This way expiry can be checked everytime cookie is sent to server and also purpose of the cookie will be verified. So for this application, we can assign purposes "Add" and "Append" for the two pages add and append respectively. Sigining that value inside the respective cookies and checking everytime the cookie is sent to server will prevent the misuse of one cookie for another.
* **
Please give any suggestion/feedback in the comments section :) .
