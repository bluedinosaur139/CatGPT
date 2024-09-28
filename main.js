const { app, BrowserWindow } = require('electron');
const path = require('path');
let useCatAgent = false; // Add a variable to track whether the catgirl agent is active

function createWindow () {
  const win = new BrowserWindow({
    width: 1200,
    height: 800,
    icon: path.join(__dirname, 'resources/CatGPTIcon.png'), // Update the icon path to resources folder
    webPreferences: {
      nodeIntegration: true
    }
  })

  // Load the regular OpenAI URL by default
  win.loadURL('https://chat.openai.com/');

  // Add a mechanism to opt-in to the catgirl agent (you can trigger this via UI later)
  win.webContents.on('did-finish-load', () => {
    if (useCatAgent) {
      // If Nekomi Sakura is selected, modify the prompts or API interaction here
      win.webContents.executeJavaScript(`
        const catPrompt = "You're speaking with Nekomi Sakura, a playful catgirl who loves to help out with a cheerful tone!";
        document.querySelector('textarea').value = catPrompt;
      `);
    }
  });
}

app.whenReady().then(() => {
  createWindow();

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
})

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});
