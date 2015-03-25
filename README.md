# Demo_app_1
**Developer : Siddharth Bhatore **

###Description
Application demonstrating the current problems in Rails Cookie Implementation, its workaround in the current implementation and what Rails can change to do better in this area.

Rails : **4.2.0** Ruby: **2.1.2**
###What application does
The actions for appending in controller "add_append" appends all the input numbers that client has given till now in "append" page, and stores the result in the form of a cookie named "appended". This appended cookie is **signed** using cookies.signed method.

Similarly, actions for adding in controller "add_append" adds all the input numbers that client has given till now in "add" page, and stores the final result in the form of a cookie named "added". This added cookie is also **signed** using cookies.signed method.

The actions for appending in controller "add_append_secure" appends all the input numbers that client has given till now in "Append Secure" page, and stores the result in the form of a cookie named "appended_secure". This appended_secure cookie is signed using cookies.signed method but with a little modification. Now the purpose of this page "Append" is also signed along with the final result. So, appended result "1234" will be stored as "1234.Append" in the cookie

Similarly, actions for adding in controller "add_append_secure" adds all the input numbers that client has given till now in "Add Secure" page, and stores the final result in the form of a cookie named "added_secure". This added_secue cookie is also signed using cookies.signed method but with a little modification. Now, the purpose of this page "Add" is also signed along with the final result. So, "1234" will be stored in cookie as "1234.Add". 
###How can the User of this application misuse cookies

Now, there are plugins available for browser which can change the cookie value of any particular cookie available for the page. For Mozilla Firefox, there is a plugin called Cookie Manager+. It looks something like this [Cookie Manager+](https://drive.google.com/file/d/0B0i0qtkbVE34MGx2TmphcTJ5WUk/view?usp=sharing) You can also do all sorts of things with this plugin such as change the name of cookie, change expiry of cookie, etc. 

What a User can do is, for this application, is he can use the value of the "appended cookie" (cookies[:appended]) in place for "added cookie" (cookies[:added]) and vice-versa. So, the cookie which was meant for storing appended values is misused for manipulating the server by sending that value in place for "added cookie" or vice-versa. 

Also, User of this application can control the expiry of any cookie using browser plugins, which the Developer/server may not want. We may want to enforce the expiry of cookie on server-side to some extent.

###Work Arounds
I've implemented workarounds in Add Secure and Append Secure pages. The function of these pages is the same, i.e., add and append all the previous input numbers on their pages respectively. But now, you can't use cookie value of Add Secure page(cookie[:added\_secure]) in place for Append Secure Page(cookies[:appended_secure]) or vice-versa. This is because I send the purpose concatencated with the results of the two pages. So, appended result "1234" is sent as "1234.Append" to sign this value in the cookie. Similarly, added result "1234" is sent as "1234.Add" to sign this value in the cookie. Now, everytime server accesses a cookie, I check if the purpose of the cookie matches with that of the page. If not, an error is raised. This would mean that someone has  tried to misuse the cookie [error](https://drive.google.com/file/d/0B0i0qtkbVE34Z2xnVkRtRnhwbU0/view?usp=sharing)

Similar implementation can be done to enforce expiry as well. i.e. You sign expiry inside the cookie and check if the cookie is expired or not everytime server accesses the cookie. Discard the cookie if it is expired. This way plugins like cookie manager+ will be of no use, since you are enforcing expiration on server-side.

###Potential solutions
This is a potential threat for any company using a similar kind of application. Signing in value inside  the cookie is not enough. We need to sign expiry and purpose with that of value inside the cookie. But implementing this can be really tedious for the Developer. It would be much better if Rails has an inbuilt mechanism to sign expiry and give option to assign a purpose and sign that too along with the value of the cookie. This way expiry can be checked everytime cookie is sent to server and also purpose of the cookie will be verified. We can send an encoded hash containing (value, expiry, purpose). The third one "purpose" is sent by user along with the options. e.g.

  cookies.signed[:add] = {:value => "12345", :expiry => "1.day.from_now" :for => "Add"}
  
We can build an inbuilt mechanism to store much secure cookies very easily if we do this.
* **
Please give any suggestion/feedback in the comments section :) .
