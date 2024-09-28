const { app, BrowserWindow, Menu } = require('electron');
const path = require('path');
let useCatAgent = false; // Default is off

function createWindow() {
  const win = new BrowserWindow({
    width: 1200,
    height: 800,
    icon: path.join(__dirname, 'resources/CatGPTIcon.png'),
    webPreferences: {
      nodeIntegration: true
    }
  });

  // Load the default ChatGPT page
  win.loadURL('https://chat.openai.com/');

  // After the page loads, modify interaction if Nekomi Sakura is active
  win.webContents.on('did-finish-load', () => {
    if (useCatAgent) {
      // Inject playful catgirl prompt
      win.webContents.executeJavaScript(`
        const catPrompt = "Nekomi Sakura: Nyaa~! How can this playful catgirl help you today? 🐾";
        const inputBox = document.querySelector('textarea');
        inputBox.value = catPrompt;
        inputBox.dispatchEvent(new Event('input', { bubbles: true }));
      `);
    }
  });
}

// Function to toggle the catgirl agent
function toggleCatAgent() {
  useCatAgent = !useCatAgent;
  console.log(`Nekomi Sakura Agent is now ${useCatAgent ? 'enabled' : 'disabled'}`);
}

// Create the menu with an option to toggle the agent
function createMenu() {
  const menu = Menu.buildFromTemplate([
    {
      label: 'Agent',
      submenu: [
        {
          label: 'Toggle Nekomi Sakura',
          click: () => toggleCatAgent(),
        }
      ]
    }
  ]);
  Menu.setApplicationMenu(menu);
}

app.whenReady().then(() => {
  createWindow();
  createMenu();

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});
