const { app, BrowserWindow } = require('electron');
const path = require('path');
let useCatAgent = true; // Toggle this to enable/disable the catgirl agent

function createWindow () {
  const win = new BrowserWindow({
    width: 1200,
    height: 800,
    icon: path.join(__dirname, 'resources/CatGPTIcon.png'), // Update the icon path to resources folder
    webPreferences: {
      nodeIntegration: true
    }
  });

  // Load the regular OpenAI URL by default
  win.loadURL('https://chat.openai.com/');

  // Add a mechanism to opt-in to the catgirl agent
  win.webContents.on('did-finish-load', () => {
    setTimeout(() => {
      if (useCatAgent) {
        win.webContents.executeJavaScript(`
          const catPrompt = "You're speaking with Nekomi Sakura, the playful catgirl!";
          const textarea = document.querySelector('textarea');
          if (textarea) {
            textarea.value = catPrompt;
          }
        `);
      }
    }, 1000); // Delay added to ensure the page has fully loaded
  });
}

app.whenReady().then(() => {
  createWindow();

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});
