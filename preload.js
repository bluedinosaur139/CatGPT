const { ipcRenderer } = require('electron');

// Expose `navigator.mediaDevices.getUserMedia` to the renderer process
window.addEventListener('DOMContentLoaded', () => {
    const micButtonHTML = `
        <button id="mic-toggle" style="position: absolute; right: 10px; bottom: 10px;">
            🎤 Toggle Mic
        </button>`;
    
    document.body.insertAdjacentHTML('beforeend', micButtonHTML);

    const micButton = document.getElementById('mic-toggle');
    let micEnabled = false;

    micButton.addEventListener('click', () => {
        if (!micEnabled) {
            navigator.mediaDevices.getUserMedia({ audio: true })
            .then(function (stream) {
                console.log('Microphone enabled');
                micEnabled = true;
            })
            .catch(function (err) {
                console.error('Microphone access denied: ', err);
            });
        } else {
            console.log('Microphone disabled');
            micEnabled = false;
        }
    });
});
