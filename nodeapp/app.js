const express = require("express");
const app = express();

app.get("/", (req, res) => {
    // HTML content with a beige background
    const htmlContent = `
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Service Status</title>
            <style>
                body {
                    background-color: beige;
                    font-family: Arial, sans-serif;
                    text-align: center;
                    padding: 50px;
                }
                h1 {
                    color: #333;
                }
            </style>
        </head>
        <body>
            <h1>Service is up and running</h1>
        </body>
        </html>
    `;
    res.send(htmlContent);
});

app.listen(8080, () => {
    console.log("Server is up on port 8080");
});
