const express = require('express');
const router = express.Router();

const multer = require('multer');

const formsController =
    require('../controllers/formsController');


// STORAGE
const storage = multer.diskStorage({

    destination: function(req, file, cb) {

        cb(null, 'public/uploads');
    },

    filename: function(req, file, cb) {

        cb(
            null,
            Date.now() + '-' + file.originalname
        );
    }
});

const upload = multer({ storage });


// FORM BUILDER PAGE
router.get('/form-builder', (req, res) => {
    res.render('forms/form-builder');
});

router.get(
    '/forms',
    formsController.getForms
);

router.get(
    '/delete-form/:id',
    formsController.deleteForm
);

router.get(
    '/form/:id',
    formsController.previewForm
);

router.post(
    '/submit-form/:id',
    formsController.submitForm
);

router.get(
    '/responses/:formId',
    formsController.getResponses
);

router.get(
    '/response/:responseId',
    formsController.viewResponse
);


// SAVE FORM
router.post(
    '/save-form',

    upload.fields([
        { name: 'question_image_0' },
        { name: 'question_image_1' },
        { name: 'question_image_2' },
        { name: 'question_image_3' },
        { name: 'question_image_4' },
        { name: 'question_image_5' },
        { name: 'question_image_6' },
        { name: 'question_image_7' },
        { name: 'question_image_8' },
        { name: 'question_image_9' }
    ]),

    formsController.saveForm
);

module.exports = router;