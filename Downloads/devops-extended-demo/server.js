const express = require('express');
const app = express();
const port = 8080;

app.get('/', (req, res) => {
  res.send('🚀 DevOps Extended Project Deployed Successfully on EC2!');
});

app.listen(port, () => {
  console.log(`App running on port ${port}`);
});
