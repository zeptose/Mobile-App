# Mobile-App

### About BusyBee
BusyBee is a goal-setting social media app that promotes healthy habits for achieving goals through social encouragement. Users are guided through a goal-setting experience and can share their progress by posting photos every time they work towards their goal. Friends and family can also provide support through comments and reactions on the photo feed. BusyBee is an easy and intuitive solution for users to track and stay motivated towards accomplishing their goals.

### Steps to set up
#### Some set up notes for our app...
- To run on your device, git clone this repository and run it on XCode
- This app is intended for iphone users and requires the front and back cameras, so please make sure that the camera is enabled when prompted
- This app is intended for use in light mode only!

### Testing
You can find the unit tests written under the UnitTests folder. The files contain unit tests written to reach above 90% coverage for all models, controllers, and view controllers. Full coverage is reached for all the models and view models, though we ran into issues when trying to reach full coverage for certain controllers, such as the GoalController and CameraController. Some reasons include that we were recieving many errors related to the camera feature when trying to test it, and also when trying to create mock repositories for the GoalController testing. A lot of TAs did not have experience in the features that we were using, and there were very limited sources onine, so for those few files that didn't reach full coverage, we manually tested by putting print statements and checking results, and also by testing our app locally on our phone and trying out all the scenarios that could throw errors (like flipping the camera back and forth). Since there wasn't anything wrong, we felt that our time was better spent working on our main features. Other than those three or so files that didn't reach full coverage, all the other ones were unit tested thoroughly.

### Feature List
*A-Level*
1. Ability to create and edit profile
2. Ability to add, edit, and delete goals
3. Taking pictures to mark progress towards your goal
4. Searching and adding friends
5. Viewing feed of friends’ progress pictures
6. Viewing personal and friends’ goals
7. Viewing current and past goals
   
*B-level*
1. Ability to react and comment on posts
2. Having in-app notifications when other users react, or comment 
3. Having a “goal-wrapped” page that summarizes completed goals
4. Being able to save your “goal-wrapped” image to your camera roll to share with friends
