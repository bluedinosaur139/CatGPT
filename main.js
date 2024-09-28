const { app, BrowserWindow } = require('electron');
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

  win.webContents.on('did-finish-load', () => {
    // Inject microphone button and speech recognition logic into the ChatGPT page
    win.webContents.executeJavaScript(`
      // Find the text input area (replace with the actual query box selector)
      const queryBox = document.querySelector('textarea');

      if (queryBox) {
        // Create the microphone button
        const micButton = document.createElement('button');
        micButton.textContent = '🎤';
        micButton.style.marginLeft = '10px'; // Add space between query box and mic button
        micButton.style.cursor = 'pointer';

        // Insert the microphone button after the query box
        queryBox.parentNode.insertBefore(micButton, queryBox.nextSibling);

        if ('webkitSpeechRecognition' in window) {
          const recognition = new webkitSpeechRecognition();
          recognition.continuous = false;
          recognition.interimResults = false;
          recognition.lang = 'en-US';

          micButton.onclick = () => {
              recognition.start();
          };

          recognition.onresult = (event) => {
              queryBox.value = event.results[0][0].transcript; // Inject the speech into the query box
          };

          recognition.onerror = (event) => {
              console.error('Speech recognition error:', event.error);
          };
        } else {
          micButton.disabled = true; // Disable the button if speech recognition is not supported
          micButton.textContent = '🎤 (Not Supported)';
        }
      }
    `);
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
