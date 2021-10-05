7th September 2021
1. Added a validation for TextFormFields in LoginScreen/CreateAccount.
2. Added a Show/Hide checkbox for Password in both LoginScreen and CreateAccount

11th September 2021
1. Added an email verification feature, this means whoever is using this app will have to login with their real email
2. Added password reset feature
3. Updated AboutPage
4. A working AccountType logic but not satisfied with how it looks though on the backend side. Will be improving it before the next Push.

13th September 2021
1. Cleaned all the dead codes for the AccountType Logic and also some of the pages.
2. Removed the CircularProgressIndicator at some part of the pages for now. Will add it back when its time to decorate the app properly.
3. Improved the Profile Page UI, and some of the pages such as Login Screen/Create Account that has text fields accordingly to Hafizzan's tastes.
4. In profile page, only the UI is finished however, the profile picture part is not yet finished as still searching on how to store that data into firebase.
5. In the Homepage/DoctorHomepage now, we can see the username of the current user being displayed along with its accountType.
6. Now, we planned to also display the user's details in the Profile page along with the Profile Picture just like the Homepage where the username is displayed.
7. Adding on to that, still searching on how to do the feature where the user can discard/update the changes made in the Profile Page.

22nd September 2021
1. User now can pick their own images to be their profile picture by clicking on the profile picture/image in the Profile page itself.
2. The user's data are now displayed in the Profile Page.
3. Implemented the feature where user is able to save or discard changes in the profile page.
4. Planned to add a button for going to solely going to the Homepage Screen.
5. Next, our task would be the fixing of the Chat Feature as currently it is not working as intended and also the Manage Notes function.

26th September 2021
1. Somehow managed to fix the Chat Feature. Not much of a changes I think, the changes are mostly in the ChatRoom page and HomeScreen page.
2. Also added a feature where user are able to pick a counsellor's gender and showing only the counsellor who fits the criteria in the HomeScreen page.
3. Found out ways to display Images in the Circle Avatar, the example are in the ChatRoom page under the CircleAvatar widget.
4. Next plan is to focus on the Manage Notes function while trying out the Call and Video Call feature for the Counselling Function.

5th October 2021
1. Implemented real time communication with Video Call and Call.
2. The steps for using the Video Call at the moment is that, first the user need to open their camera and mic using the specific button in Video Call page.
   Then, the other user also need to open their media devices. After that, one user need to click the button to create a room and wait for the roomId to appear
   at the bottom TextField.
   Next, use that roomId and input it on the other user TextField and then click Join Room to start communicating.
   To stop communicating, just click the button Hang Up.
3.