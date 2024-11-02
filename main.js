const { app, BrowserWindow } = require('electron');
const path = require('path');

function createWindow() {
  const win = new BrowserWindow({
    width: 1200,
    height: 800,
    icon: path.join(__dirname, 'resources/CatGPTIcon.png'), // Update the icon path to resources folder
    transparent: true, // Enable window transparency
    frame: false, // Remove window frame for a seamless look
    webPreferences: {
      nodeIntegration: true,
    },
  });

  win.loadURL('https://chat.openai.com/');
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
