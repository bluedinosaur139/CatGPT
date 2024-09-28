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
    // Inject speech recognition UI and logic into the web page
    win.webContents.executeJavaScript(`
      const startRecordBtn = document.createElement('button');
      startRecordBtn.textContent = '🎤 Start Dictation';
      document.body.appendChild(startRecordBtn);

      const resultText = document.createElement('textarea');
      resultText.rows = 5;
      resultText.cols = 30;
      document.body.appendChild(resultText);

      if ('webkitSpeechRecognition' in window) {
          const recognition = new webkitSpeechRecognition();
          recognition.continuous = false;
          recognition.interimResults = false;
          recognition.lang = 'en-US';

          startRecordBtn.onclick = () => {
              recognition.start();
          };

          recognition.onresult = (event) => {
              resultText.value = event.results[0][0].transcript;
              document.querySelector('textarea').value = resultText.value; // Simulate typing into ChatGPT
          };

          recognition.onerror = (event) => {
              console.error('Speech recognition error:', event.error);
          };
      } else {
          console.log('Speech Recognition not supported on this browser.');
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
