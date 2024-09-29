const { app, BrowserWindow } = require('electron');
const path = require('path');
const vosk = require('vosk');
const fs = require('fs');
const { exec } = require('child_process'); // For sound execution

// Path to your Vosk model directory
const MODEL_PATH = path.join(__dirname, 'vosk-model-small-en-us-0.15');

vosk.setLogLevel(0);
const model = new vosk.Model(MODEL_PATH);

function createWindow() {
    const win = new BrowserWindow({
        width: 1200,
        height: 800,
        icon: path.join(__dirname, 'resources/CatGPTIcon.png'),
        webPreferences: {
            nodeIntegration: true,
        }
    });

    win.loadURL('https://chat.openai.com/');
}

app.whenReady().then(() => {
    createWindow();

    app.on('activate', () => {
        if (BrowserWindow.getAllWindows().length === 0) createWindow();
    });

    // Example for using Vosk to transcribe audio
    app.on('ready', () => {
        const rec = new vosk.Recognizer({ model: model, sampleRate: 16000 });

        const audioFilePath = path.join(__dirname, 'path/to/your/audio.wav'); // Adjust to the correct path
        const wfStream = fs.createReadStream(audioFilePath, { highWaterMark: 4096 });

        wfStream.on('data', (data) => {
            if (rec.acceptWaveform(data)) {
                console.log(rec.result());
            } else {
                console.log(rec.partialResult());
            }
        });

        wfStream.on('end', () => {
            console.log(rec.finalResult());
            rec.free();
            
            // Play a sound once transcription is done
            exec('aplay /gome/gamer/ding-sound.wav', (error) => {
                if (error) {
                    console.error(`Error playing sound: ${error}`);
                }
            });
        });
    });
});

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') {
        app.quit();
    }
});
