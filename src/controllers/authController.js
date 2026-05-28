const pool = require('../config/db');

// Register
const bcrypt = require('bcrypt');

exports.register = async (req, res) => {
  const {
    name,
    designation,
    lab,
    lab_address,
    mobile,
    official_email,
    personal_email,
    password,
    confirm_password
  } = req.body;

  try {
    // Check password match
    if (password !== confirm_password) {
      return res.send(`
        <script>
          alert("Passwords do not match ❌");
          window.history.back();
        </script>
      `);
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    await pool.query(
      `INSERT INTO users 
      (name, designation, lab, lab_address, mobile, official_email, personal_email, password) 
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8)`,
      [name, designation, lab, lab_address, mobile, official_email, personal_email, hashedPassword]
    );

    res.send(`
      <script>
        localStorage.setItem("registerSuccess", "true");
         window.location.href="/register";
      </script>
    `);

  } catch (err) {
    res.send(`
      <script>
        alert("Error: ${err.message}");
        window.history.back();
      </script>
    `);
  }
};

exports.login = async (req, res) => {
  const { personal_email, password } = req.body;

  try {
    const result = await pool.query(
      'SELECT * FROM users WHERE personal_email = $1',
      [personal_email]
    );

    if (result.rows.length === 0) {
      return res.send(`
        <script>
          alert("User not found ❌");
          window.history.back();
        </script>
      `);
    }

    const user = result.rows[0];

    const match = await bcrypt.compare(password, user.password);

    if (!match) {
      return res.send(`
        <script>
          alert("Invalid password ❌");
          window.history.back();
        </script>
      `);
    }

    req.session.user = {
      email: user.personal_email,
      name: user.name
    };
    
    res.send(`
      <script>
        window.location.href = "/dashboard";
      </script>
    `);

  } catch (err) {
    res.send(`
      <script>
        alert("Error: ${err.message}");
        window.history.back();
      </script>
    `);
  }
};