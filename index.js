const express = require('express');
const mysql = require('mysql2');
const app = express();

app.use(express.json());

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root', 
    password: '123456', 
    database: 'studentlist'
});

db.connect((err) => {
    if (err) throw err;
    console.log('Veritabanına bağlanıldı');
});


app.post('/student', (req, res) => {
    const { name, surname, departmentID } = req.body;
    const query = 'INSERT INTO student (name, surname, departmentID) VALUES (?, ?, ?)';
    db.query(query, [name, surname, departmentID], (err, result) => {
        if (err) throw err;
        res.send('Öğrenci başarıyla eklendi');
    });
});


app.get('/student', (req, res) => {
    const query = 'SELECT * FROM student';
    db.query(query, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});


app.get('/student/:id', (req, res) => {
    const { id } = req.params;
    const query = 'SELECT * FROM student WHERE studentID = ?';
    db.query(query, [id], (err, result) => {
        if (err) throw err;
        res.json(result);
    });
});


app.put('/student/:id', (req, res) => {
    const { id } = req.params;
    const { name, surname, departmentID } = req.body;
    const query = 'UPDATE student SET name = ?, surname = ?, departmentID = ? WHERE studentID = ?';
    db.query(query, [name, surname, departmentID, id], (err, result) => {
        if (err) throw err;
        res.send('Öğrenci başarıyla güncellendi');
    });
});


app.delete('/student/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM student WHERE studentID = ?';
    db.query(query, [id], (err, result) => {
        if (err) throw err;
        res.send('Öğrenci başarıyla silindi');
    });
});

app.listen(3000, '::', () => {
    console.log('Sunucu 3000 portunda çalışıyor');
});
