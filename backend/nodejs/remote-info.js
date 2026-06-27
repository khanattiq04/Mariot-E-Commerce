const { Client } = require('ssh2');

const conn = new Client();
conn.on('ready', () => {
  console.log('Client :: ready');
  conn.exec('find domains -name ".env" 2>/dev/null | xargs cat', (err, stream) => {
    if (err) throw err;
    stream.on('close', (code, signal) => {
      console.log('Stream :: close :: code: ' + code + ', signal: ' + signal);
      conn.end();
    }).on('data', (data) => {
      console.log('STDOUT: ' + data);
    }).stderr.on('data', (data) => {
      console.log('STDERR: ' + data);
    });
  });
}).on('error', (err) => {
  console.error('Connection error:', err);
}).connect({
  host: '72.62.77.9',
  port: 65002,
  username: 'u650716787',
  password: 'Mariot2026@Strong'
});
