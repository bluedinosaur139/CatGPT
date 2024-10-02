Brought to you by Zombie Fart Studios

![zombiefartstudiosyoutubelogo](https://github.com/user-attachments/assets/00153e03-abdb-4499-ac51-fc8788aa9a6e)



![Screenshot_20240927_182936](https://github.com/user-attachments/assets/ee94a7f1-b0f2-4563-a3d9-619787aa4c68)

Use this one command block to automate install:

```
git clone https://github.com/bluedinosaur139/catgpt.git
cd catgpt
sudo chmod +x install.sh
sudo ./install.sh
```

It will also be included in the releases section. For ease of use. Choose latest release, extract and run the installer with this command.

```
if [ -f catgpt-*.zip ]; then unzip -o catgpt-*; else tar -xzf catgpt-*.tar.gz; fi
sudo chmod +x install.sh
sudo ./install.sh
```

Now includes both x64 and ARM by default ! The output tells you where it is stored. Personally, I Tested on a pi 5 and still has full functionality. Search for CatGPT and pin it to taskbar or desktop!

This is a custom-built application developed using Electron, providing full JavaScript capabilities for seamless integration with ChatGPT and KDE Plasma 6. Microphone dictation support is coming soon, with ongoing development planned. This repository will eventually be just one of the neat apps I make for my operating system based on Arch and KDE, featuring an anime catgirl theme, with everything preconfigured for an out-of-the-box experience. See my CatGPT-OS repo for current status and what to expect of the setup and configs tailored by an experienced gamer. I am also making a game in unity for all platforms including linux, but that needs a lot of time to bake.

My own personal take: no onther version of ChatGPT on linux runs this well, brave constantly has errors forcing you to refresh as the server load increases due to dropped packets, this app runs much better than any other browser based version try it and see!

![catgptlogo](https://github.com/user-attachments/assets/4244f634-501f-4fee-844b-97eae884006f)


Dependencies
Electron: This is the main framework used to build and run the app. You should not need this step if you followed the guide, this is here for informational purposes. Install via:

```
npm install electron --save-dev
```

Having Trouble? Try This First:

If you encounter any issues while running the CatGPT app, it might be due to an outdated Electron version or permissions problem. Before diving deeper into troubleshooting, try updating Electron using the following commands:

```
npm update electron
```

Afterward, you can attempt running or building the app again. This simple update can resolve many compatibility issues, ensuring you’re using the latest Electron release.



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

CatGPT-OS is on the way soon after my other apps are done:
![Screenshot_20241002_161750](https://github.com/user-attachments/assets/72a2bb1a-9ad8-4d65-bf59-c7c09885a80b)
![Screenshot_20241002_163052](https://github.com/user-attachments/assets/a56a8498-f833-4485-a961-16bece2ca6a9)



This entire process—starting from scratch, developing, packaging, and releasing—is something achievable by anyone with a passion for development and the willingness to learn. It's more accessible than ever, and you're not alone in the journey.
