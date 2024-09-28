const { app, BrowserWindow, Menu } = require('electron');
const path = require('path');

function createWindow () {
  const win = new BrowserWindow({
    width: 1200,
    height: 800,
    icon: path.join(__dirname, 'resources/CatGPTIcon.png'),
    webPreferences: {
      nodeIntegration: true
    }
  });

  win.loadURL('https://chat.openai.com/');

  // Define a function to handle speech recognition
  const startSpeechRecognition = () => {
    win.webContents.executeJavaScript(`
      if ('webkitSpeechRecognition' in window) {
        const recognition = new webkitSpeechRecognition();
        recognition.continuous = false;
        recognition.interimResults = false;
        recognition.lang = 'en-US';

        recognition.start();

        recognition.onresult = (event) => {
          const queryBox = document.querySelector('textarea');
          if (queryBox) {
            queryBox.value = event.results[0][0].transcript;
          }
        };

        recognition.onerror = (event) => {
          console.error('Speech recognition error:', event.error);
        };
      } else {
        console.log('Speech recognition not supported');
      }
    `);
  };

  // Create the menu template with a microphone option
  const menuTemplate = [
    {
      label: 'Options',
      submenu: [
        {
          label: 'Start Voice Input (🎤)',
          click: () => {
            startSpeechRecognition();
          }
        },
        { role: 'quit' }
      ]
    }
  ];

  // Build and set the menu
  const menu = Menu.buildFromTemplate(menuTemplate);
  Menu.setApplicationMenu(menu);
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
