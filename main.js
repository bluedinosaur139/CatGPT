const { app, BrowserWindow } = require('electron');
const path = require('path');
const { ipcMain } = require('electron'); // Import ipcMain to handle microphone toggle requests

// Function to create the browser window
function createWindow() {
    const win = new BrowserWindow({
        width: 1200,
        height: 800,
        icon: path.join(__dirname, 'resources/CatGPTIcon.png'),
        webPreferences: {
            nodeIntegration: true,
            contextIsolation: false,
            enableRemoteModule: true,
            preload: path.join(__dirname, 'preload.js') // Load the preload script
        }
    });

    // Load the ChatGPT URL
    win.loadURL('https://chat.openai.com/');
}

// Create the window when the app is ready
app.whenReady().then(() => {
    createWindow();

    app.on('activate', () => {
        if (BrowserWindow.getAllWindows().length === 0) createWindow();
    });
});

// Quit the app when all windows are closed
app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') {
        app.quit();
    }
});
