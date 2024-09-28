
![Screenshot_20240927_182936](https://github.com/user-attachments/assets/ee94a7f1-b0f2-4563-a3d9-619787aa4c68)

CatGPT is almost too purrfect for everyone... almost. 😉 A one-click installer might be closer than you think, but for now, follow the guide to unlock the magic. The cats demand a little curiosity before revealing all their secrets! 🐾

Now includes both x64 and ARM by default simply use which ever version you have after the npm run build command!! The output tells you where it is stored. Personally, I Tested on a pi 5 and still has full functionality.

This is a custom-built application developed using Electron, providing full JavaScript capabilities for seamless integration with ChatGPT and KDE Plasma 6. Microphone dictation support is coming soon, with ongoing development planned. This repository will eventually be just one of the neat apps I make for my operating system based on Arch and KDE, featuring an anime catgirl theme, with everything preconfigured for an out-of-the-box experience. See my CatGPT-OS repo for current status and what to expect of the setup and configs tailored by an experienced gamer. I am also making a game in unity for all platforms including linux, but that needs a lot of time to bake.

My own personal take: no onther version of ChatGPT on linux runs this well, brave constantly has errors forcing you to refresh as the server load increases due to dropped packets, this app runs much better than any other browser based version try it and see!

![catgptlogo](https://github.com/user-attachments/assets/4244f634-501f-4fee-844b-97eae884006f)

CatGPT App Installation Guide
Prerequisites
Before starting, ensure you have the following installed on your system:

debian only:
```
sudo apt update
sudo apt install npm nodejs
npm install electron

```

If you use Arch BTW:
```
sudo pacman -S nodejs npm
```

```
npm install electron --save-dev
npm install electron-packager --save-dev
```

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
4. Run the CatGPT App, or skip this step if you just want an app and go to step 5
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
Electron: This is the main framework used to build and run the app. You should not need this step if you followed the guide, this is here for informational purposes. Install via:
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
