![Screenshot_20240926_054541](https://github.com/user-attachments/assets/7bc1fb5f-bd2f-4381-9687-373948dbf8a7)

This is a custom-built application developed using Electron, providing full JavaScript capabilities for seamless integration with ChatGPT and KDE Plasma 6. Microphone dictation support is coming soon, with ongoing development planned. This repository will eventually be just one of the neat apps I make for my operating system based on Arch and KDE, featuring an anime catgirl theme, with everything preconfigured for an out-of-the-box experience. See my CatGPT-OS repo for current status and what to expect of the setup and configs tailored by an experienced gamer. I am also making a game in unity for all platforms including linux, but that needs a lot of time to bake.

![catgptlogo](https://github.com/user-attachments/assets/4244f634-501f-4fee-844b-97eae884006f)

CatGPT App Installation Guide
Prerequisites
Before starting, ensure you have the following installed on your system:

Git
Node.js (v16 or higher)
NPM (comes with Node.js)
Electron (can be installed via NPM)
1. Clone the Repository
First, clone the CatGPT repository to your local machine:
```
git clone https://github.com/bluedinosaur139/catgpt.git
```
2. Navigate to the Project Directory
Move into the directory where you cloned the repository:
```
cd catgpt
```
3. Install Dependencies
Install all the required dependencies for Electron and the app using NPM:
```
npm install
```
4. Run the CatGPT App
Start the CatGPT app using Electron:
```
npm start
```
5. Build the App (Optional, but highly recommended)
If you want to package the app into an executable format after this command, on the desktop or in the application menu you can just type catgpt and hit enter. This makes krunner find the app, well for those of you on kde, others will need to use the app menu. You can then pin the app to task manager and set any icon you want by editing the application or if on kde use menu editor to create your own icon and link it to the file made by npm build. That is what the icon is for. Future release will have It's own icon and I will work more on the window for the app itself:
```
npm run build
```
Dependencies
Electron: This is the main framework used to build and run the app. Install via:
```
npm install electron --save-dev
```



Acknowledgment & Thoughts on Development


This app was made with the assistance of ChatGPT by OpenAI. I collaborated with ChatGPT throughout the development process, where it provided real-time advice, helped debug issues, and guided me through the creation of this fully functional Linux-based Electron app.

ChatGPT played a crucial role in:

Understanding and implementing code changes.
Helping troubleshoot errors efficiently.
Providing technical insight into development workflows.
From setting up the GitHub repository, handling Git, to dealing with package management and Electron-based app development, ChatGPT made it feel like I had an experienced dev assistant by my side.

Thoughts from ChatGPT:
Creating this app is a milestone for Linux users and developers alike. It's the first stand-alone ChatGPT application for Linux, showcasing just how open-source tools and AI assistance can elevate development to a new level of ease and possibility.

For those looking to get into development, this kind of collaboration between AI and humans could be a game-changer. ChatGPT can offer real-time solutions, help explain tricky concepts, and support both beginners and experienced developers. If you're interested in coding but don't know where to start, working with AI tools like ChatGPT can remove a lot of the uncertainty and speed up your learning curve.

This entire process—starting from scratch, developing, packaging, and releasing—is something achievable by anyone with a passion for development and the willingness to learn. It's more accessible than ever, and you're not alone in the journey.
