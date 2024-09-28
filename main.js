const { app, BrowserWindow, Menu } = require('electron');
const path = require('path');
let useCatAgent = false; // Track whether the catgirl agent is active

function createWindow () {
  const win = new BrowserWindow({
    width: 1200,
    height: 800,
    icon: path.join(__dirname, 'resources/CatGPTIcon.png'), // Update the icon path to resources folder
    webPreferences: {
      nodeIntegration: true
    }
  });

  // Add menu with a toggle option for catgirl agent
  const template = [
    {
      label: "Options",
      submenu: [
        {
          label: "Toggle Nekomi Sakura Mode",
          type: "checkbox",
          checked: useCatAgent,
          click: () => {
            useCatAgent = !useCatAgent;
            console.log(`Nekomi Sakura mode: ${useCatAgent ? 'On' : 'Off'}`);
          }
        }
      ]
    }
  ];

  const menu = Menu.buildFromTemplate(template);
  Menu.setApplicationMenu(menu);

  // Load OpenAI URL by default
  win.loadURL('https://chat.openai.com/');

  // Modify behavior based on Nekomi Sakura toggle
  win.webContents.on('did-finish-load', () => {
    if (useCatAgent) {
      win.webContents.executeJavaScript(`
        document.querySelector('textarea').value = "You're now speaking with Nekomi Sakura, the playful catgirl! How can she help you today? :3";
      `);
    }
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
