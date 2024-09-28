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
            enableRemoteModule: true,
            media: { audio: true }, // Allow microphone access
            preload: path.join(__dirname, 'preload.js') // Ensure preload is correctly linked
        }
    });

    // Open DevTools for debugging
    win.webContents.openDevTools();

    // Load the ChatGPT URL
    win.loadURL('https://chat.openai.com/');

    // Ensure the URL is loaded properly
    win.webContents.on('did-fail-load', (event, errorCode, errorDescription) => {
        console.error(`Failed to load URL: ${errorDescription}`);
    });

    // Check for microphone access once the window has loaded
    win.webContents.on('did-finish-load', () => {
        navigator.permissions.query({ name: 'microphone' }).then((result) => {
            if (result.state === 'granted') {
                console.log('Microphone access granted.');
            } else {
                console.log('Microphone access denied.');
            }
        }).catch((err) => {
            console.error('Error checking microphone permissions: ', err);
        });
    });

    // Toggle microphone button functionality
    let micEnabled = false;
    win.webContents.on('did-finish-load', () => {
        const micButtonHTML = `
            <button id="mic-toggle" style="position: absolute; right: 10px; bottom: 10px;">
                🎤 Toggle Mic
            </button>`;
        win.webContents.executeJavaScript(`
            if (!document.getElementById('mic-toggle')) {
                const micButton = document.createElement('div');
                micButton.innerHTML = \`${micButtonHTML}\`;
                document.body.appendChild(micButton);

                document.getElementById('mic-toggle').addEventListener('click', () => {
                    if (${micEnabled}) {
                        navigator.mediaDevices.getUserMedia({ audio: true })
                        .then(function (stream) {
                            console.log('Microphone enabled');
                            ${micEnabled} = true;
                        })
                        .catch(function (err) {
                            console.log('Microphone access denied: ', err);
                        });
                    } else {
                        console.log('Microphone disabled');
                        ${micEnabled} = false;
                    }
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
