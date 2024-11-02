const { app, BrowserWindow } = require('electron');
const path = require('path');

function createWindow() {
  // Create the browser window with specified width, height, transparency, and icon
  const win = new BrowserWindow({
    width: 1200,
    height: 800,
    icon: path.join(__dirname, 'resources/CatGPTIcon.png'), // Path to the app icon
    transparent: true,         // Enables window transparency
    frame: false,               // Optional: Removes window frame for a seamless look
    backgroundColor: '#00000000', // Sets background to fully transparent
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false    // Ensures compatibility with transparency settings
    }
  });

  // Load the specified URL (in this case, the CatGPT web app)
  win.loadURL('https://chat.openai.com/');
}

// Event triggered when Electron app is ready to create the window
app.whenReady().then(() => {
  createWindow();

  // On macOS, recreate a window when the dock icon is clicked and there are no other open windows
  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});

// Close the app when all windows are closed, except on macOS where apps stay active
app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});
