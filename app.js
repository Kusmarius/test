const express = require('express');
const app = express();

const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send(`Hello from Node.js on branch: ${process.env.BRANCH_NAME || 'unknown'}`);
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});

