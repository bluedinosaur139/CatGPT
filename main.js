const { app, BrowserWindow, ipcMain } = require('electron');
const path = require('path');
let useCatAgent = false; // Toggle variable

function createWindow () {
  const win = new BrowserWindow({
    width: 1200,
    height: 800,
    icon: path.join(__dirname, 'resources/CatGPTIcon.png'), 
    webPreferences: {
      nodeIntegration: true
    }
  })

  win.loadURL('https://chat.openai.com/');

  // Add toggle for cat persona
  ipcMain.on('toggle-cat-agent', () => {
    useCatAgent = !useCatAgent; // Toggle catgirl mode
  });

  win.webContents.on('did-finish-load', () => {
    if (useCatAgent) {
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
