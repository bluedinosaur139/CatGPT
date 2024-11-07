Brought to you by Zombie Fart Studios

![zombiefartstudiosyoutubelogo](https://github.com/user-attachments/assets/00153e03-abdb-4499-ac51-fc8788aa9a6e)



![Screenshot_20240927_182936](https://github.com/user-attachments/assets/ee94a7f1-b0f2-4563-a3d9-619787aa4c68)

This is a custom-built application developed using Electron, providing full JavaScript capabilities for seamless integration with ChatGPT and KDE Plasma 6. 
Now includes both x64 and ARM by default ! The output tells you where it is stored. Personally, I Tested on a pi 5 and still has full functionality. Search for CatGPT and pin it to taskbar or desktop!


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


![catgptlogo](https://github.com/user-attachments/assets/4244f634-501f-4fee-844b-97eae884006f)


Dependencies

Git, Electron

Git install for Arch:
```
sudo pacman -S git
```

Git install for Debian:
```
sudo apt install git
```
Git install for Fedora:
```
sudo dnf install git
```

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

My own personal take: no onther version of ChatGPT on linux runs this well, brave constantly has errors forcing you to refresh as the server load increases due to dropped packets, this app runs much better than any other browser based version try it and see! This repository will eventually be just one of the neat apps I make for my operating system based on Fedora server and KDE 6, featuring an anime catgirl theme that changes pictures every 5 minutes and constantly has new images, or a large selection of mp4 with anime theme so you can video wallpapers if you wish, with everything preconfigured for an out-of-the-box experience. See my Pounce repo for current status and what to expect of the setup and configs tailored by an experienced gamer. I am also making a game in unity for all platforms including linux, but that needs a lot of time to bake.

Pounce is on the way soon after my other apps are done:

![Screenshot_20241106_130908](https://github.com/user-attachments/assets/c54953f2-0bfa-44ee-8ea0-6f196a7cbdc6)
![Screenshot_20241106_125837](https://github.com/user-attachments/assets/1124de67-66a8-44fa-91c1-66ca17f9ff43)



This entire process—starting from scratch, developing, packaging, and releasing—is something achievable by anyone with a passion for development and the willingness to learn. It's more accessible than ever, and you're not alone in the journey.
