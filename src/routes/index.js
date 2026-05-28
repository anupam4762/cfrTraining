const express = require('express');
const router = express.Router();
const pool = require('../config/db');

const authController = require('../controllers/authController');

router.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW()');
    res.render('index', { time: result.rows[0].now });
  } catch (err) {
    res.send('DB Error');
  }
});

router.get('/dret', (req, res) => {
  res.render('dret');
});

router.get('/register', (req, res) => {
  res.render('register');
});

router.get('/login', (req, res) => {
  res.render('login');
});

router.get('/dashboard', checkAuth, (req, res) => {
  res.render('dashboard', {
    user: req.session.user
  });
});

router.get('/test', checkAuth, async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM questions');

    res.render('test', {
      questions: result.rows,
      user: req.session.user
    });

  } catch (err) {
    console.log(err);
    res.send('Error loading test');
  }
});

router.post('/submit-test', async (req, res) => {
    if (!req.session.user) {
    return res.redirect('/login');
  }
  const userAnswers = req.body;

  const result = await pool.query('SELECT * FROM questions');
  const questions = result.rows;

  let score = 0;
  let detailedResults = [];

  questions.forEach(q => {
    const userAnswer = userAnswers[`q_${q.id}`];

    const isCorrect = userAnswer === q.correct_option;

    if (isCorrect) score++;

    detailedResults.push({
      question: q.question,
      correct: q.correct_option,
      selected: userAnswer || "Not Answered",
      isCorrect
    });
  });

  const total = questions.length;

  // 🔥 TEMP USER (replace later with session)
  const userEmail = req.session.user?.email || "guest";

  // ✅ STORE RESULT IN DB
  try {
    await pool.query(
      'INSERT INTO test_results (user_email, score, total) VALUES ($1, $2, $3)',
      [userEmail, score, total]
    );
  } catch (err) {
    console.log("DB Insert Error:", err);
  }

  // ✅ RENDER RESULT PAGE (same as before)
  res.render('result', {
    score,
    total,
    results: detailedResults
  });
});

router.post('/login', authController.login);

router.post('/register', authController.register);

router.get('/logout', (req, res) => {
  req.session.destroy(err => {
    if (err) {
      console.log("Logout Error:", err);
      return res.send("Error logging out");
    }

    res.clearCookie('connect.sid'); // optional but recommended

    res.redirect('/');
  });
});

router.get('/feedback', (req, res) => {

  if (!req.session.user) {
    return res.redirect('/login');
  }

  res.render('feedback', {
    user: req.session.user
  });
});

function checkAuth(req, res, next) {
  if (!req.session.user) {
    return res.redirect('/login');
  }
  next();
}

router.post('/submit-feedback', async (req, res) => {
    const { course, rating, feedback, suggestions } = req.body;

    const userEmail = req.session.user?.email;

    await pool.query(
        'INSERT INTO feedback (user_email, course, rating, feedback, suggestions) VALUES ($1,$2,$3,$4,$5)',
        [userEmail, course, rating, feedback, suggestions]
    );

    res.send(`
        <script>
            window.location.href="/dashboard";
        </script>
    `);
});

module.exports = router;