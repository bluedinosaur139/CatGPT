![Screenshot_20240926_054541](https://github.com/user-attachments/assets/7bc1fb5f-bd2f-4381-9687-373948dbf8a7)

This is a custom-built application developed using Electron, providing full JavaScript capabilities for seamless integration with ChatGPT. Microphone dictation support is coming soon, with ongoing development planned. This repository will eventually evolve into a full-fledged operating system based on Arch and KDE, featuring an anime catgirl theme, with everything preconfigured for an out-of-the-box experience.

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

git clone https://github.com/bluedinosaur139/catgpt.git

2. Navigate to the Project Directory
Move into the directory where you cloned the repository:

cd catgpt

3. Install Dependencies
Install all the required dependencies for Electron and the app using NPM:

npm install
4. Run the CatGPT App
Start the CatGPT app using Electron:

npm start
5. Build the App (Optional)
If you want to package the app into an executable format:

npm run build
Dependencies
Electron: This is the main framework used to build and run the app. Install via:

npm install electron --save-dev
PyQt5 (for future versions, if needed): If you're using Python for certain parts of the app, install with:

sudo pacman -S python-pyqt5
