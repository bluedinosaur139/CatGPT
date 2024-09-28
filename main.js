const { app, BrowserWindow } = require('electron');
const path = require('path');

// Function to create the browser window
function createWindow() {
    const win = new BrowserWindow({
        width: 1200,
        height: 800,
        icon: path.join(__dirname, 'resources/CatGPTIcon.png'), // Ensure the icon path is correct
        webPreferences: {
            nodeIntegration: true,
            contextIsolation: false, // Required to enable node integration and API access
            enableRemoteModule: true
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
