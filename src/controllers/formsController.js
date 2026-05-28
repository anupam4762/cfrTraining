const pool = require('../config/db');

exports.saveForm = async (req, res) => {

    try {

        const {
            form_title,
            form_description,
            questions
        } = req.body;

        // 1. Save Form
        const formResult = await pool.query(
            `
            INSERT INTO forms
            (title, description)

            VALUES ($1, $2)

            RETURNING id
            `,
            [form_title, form_description]
        );

        const formId = formResult.rows[0].id;

        // 2. Save Questions
        for (let i = 0; i < questions.length; i++) {

            const q = questions[i];

            let imageUrl = null;

            // Optional image
            const imageFile =
                req.files[`question_image_${i}`];

            if (imageFile) {

                imageUrl =
                    '/uploads/' + imageFile[0].filename;
            }

            // Save question
            const questionResult = await pool.query(
                `
                INSERT INTO form_questions
                (
                    form_id,
                    question,
                    question_type,
                    image_url,
                    question_order
                )

                VALUES ($1,$2,$3,$4,$5)

                RETURNING id
                `,
                [
                    formId,
                    q.question,
                    q.type,
                    imageUrl,
                    i + 1
                ]
            );

            const questionId =
                questionResult.rows[0].id;

            // Skip options for text/paragraph
            if (
                q.type === 'text' ||
                q.type === 'paragraph'
            ) {
                continue;
            }

            // Save options
            for (let j = 0; j < q.options.length; j++) {

                const optionText =
                    q.options[j];

                if (!optionText) continue;

                let isCorrect = false;

                if (q.correct) {

                    if (Array.isArray(q.correct)) {

                        isCorrect =
                            q.correct.includes(j.toString());

                    } else {

                        isCorrect =
                            q.correct === j.toString();
                    }
                }

                await pool.query(
                    `
                    INSERT INTO form_options
                    (
                        question_id,
                        option_text,
                        is_correct
                    )

                    VALUES ($1,$2,$3)
                    `,
                    [
                        questionId,
                        optionText,
                        isCorrect
                    ]
                );
            }
        }

        res.send(`
            <script>
                alert("Form Saved Successfully!");
                window.location.href="/form-builder";
            </script>
        `);

    } catch (err) {

        console.log(err);

        res.send("Error saving form");
    }
};

exports.getForms = async (req, res) => {

    try {

        const result = await pool.query(
            `
            SELECT *
            FROM forms

            ORDER BY created_at DESC
            `
        );

        res.render('forms/forms-list', {
            forms: result.rows
        });

    } catch (err) {

        console.log(err);

        res.send("Error loading forms");
    }
};

exports.deleteForm = async (req, res) => {

    try {

        await pool.query(
            `
            DELETE FROM forms
            WHERE id = $1
            `,
            [req.params.id]
        );

        res.redirect('/forms');

    } catch (err) {

        console.log(err);

        res.send("Delete failed");
    }
};

exports.previewForm = async (req, res) => {

    try {

        const formId = req.params.id;

        // Form details
        const formResult = await pool.query(
            `
            SELECT *
            FROM forms
            WHERE id = $1
            `,
            [formId]
        );

        const form = formResult.rows[0];

        // Questions
        const questionsResult = await pool.query(
            `
            SELECT *
            FROM form_questions
            WHERE form_id = $1
            ORDER BY question_order
            `,
            [formId]
        );

        const questions = questionsResult.rows;

        // Options
        for (let q of questions) {

            const optionsResult = await pool.query(
                `
                SELECT *
                FROM form_options
                WHERE question_id = $1
                `,
                [q.id]
            );

            q.options = optionsResult.rows;
        }

        res.render('forms/form-preview', {
            form,
            questions
        });

    } catch (err) {

        console.log(err);

        res.send("Error loading form");
    }
};

exports.submitForm = async (req, res) => {

    try {

        const formId = req.params.id;

        // Optional user
        let userEmail = null;

        if (req.session.user) {
            userEmail = req.session.user.personal_email;
        }

        // 1. Create response entry
        const responseResult = await pool.query(
            `
            INSERT INTO form_responses
            (
                form_id,
                user_email
            )

            VALUES ($1,$2)

            RETURNING id
            `,
            [
                formId,
                userEmail
            ]
        );

        const responseId =
            responseResult.rows[0].id;

        // 2. Save answers
        for (const key in req.body) {

            // Skip unrelated fields
            if (!key.startsWith("q_")) continue;

            const questionId =
                key.replace("q_", "");

            let answer =
                req.body[key];

            // Checkbox answers
            if (Array.isArray(answer)) {

                answer = answer.join(", ");
            }

            await pool.query(
                `
                INSERT INTO form_answers
                (
                    response_id,
                    question_id,
                    answer_text
                )

                VALUES ($1,$2,$3)
                `,
                [
                    responseId,
                    questionId,
                    answer
                ]
            );
        }

        // Success
        res.send(`
            <script>

                alert("Form submitted successfully!");

                window.location.href="/forms";

            </script>
        `);

    } catch (err) {

        console.log(err);

        res.send("Error submitting form");
    }
};

exports.getResponses = async (req, res) => {

    try {

        const formId = req.params.formId;

        // Form
        const formResult = await pool.query(
            `
            SELECT *
            FROM forms
            WHERE id = $1
            `,
            [formId]
        );

        const form = formResult.rows[0];

        // Responses
        const responsesResult = await pool.query(
            `
            SELECT *
            FROM form_responses

            WHERE form_id = $1

            ORDER BY submitted_at DESC
            `,
            [formId]
        );

        res.render(
            'forms/responses-list',
            {
                form,
                responses: responsesResult.rows
            }
        );

    } catch (err) {

        console.log(err);

        res.send("Error loading responses");
    }
};

exports.viewResponse = async (req, res) => {

    try {

        const responseId = req.params.responseId;

        // Response
        const responseResult = await pool.query(
            `
            SELECT *
            FROM form_responses
            WHERE id = $1
            `,
            [responseId]
        );

        const response =
            responseResult.rows[0];

        // Answers
        const answersResult = await pool.query(
            `
            SELECT
                fa.*,
                fq.question

            FROM form_answers fa

            JOIN form_questions fq
            ON fq.id = fa.question_id

            WHERE fa.response_id = $1

            ORDER BY fq.question_order
            `,
            [responseId]
        );

        res.render(
            'forms/view-response',
            {
                response,
                answers: answersResult.rows
            }
        );

    } catch (err) {

        console.log(err);

        res.send("Error loading response");
    }
};