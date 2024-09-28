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

    // Inject JavaScript to check for microphone access once the window has loaded
    win.webContents.on('did-finish-load', () => {
        win.webContents.executeJavaScript(`
            navigator.permissions.query({ name: 'microphone' }).then(function (result) {
                if (result.state === 'granted') {
                    console.log('Microphone access granted');
                } else if (result.state === 'prompt') {
                    console.log('Microphone access requires permission');
                } else {
                    console.log('Microphone access denied');
                }
            }).catch(function (error) {
                console.error('Error querying microphone permissions: ', error);
            });

            // Add the microphone toggle button
            if (!document.getElementById('mic-toggle')) {
                const micButton = document.createElement('div');
                micButton.innerHTML = '<button id="mic-toggle" style="position: absolute; right: 10px; bottom: 10px;">🎤 Toggle Mic</button>';
                document.body.appendChild(micButton);

                document.getElementById('mic-toggle').addEventListener('click', () => {
                    navigator.mediaDevices.getUserMedia({ audio: true })
                    .then(function (stream) {
                        console.log('Microphone enabled');
                    })
                    .catch(function (err) {
                        console.log('Microphone access denied: ', err);
                    });
                });
            }
        `);
    });
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
