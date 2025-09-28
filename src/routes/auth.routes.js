import { signup } from '#controllers/auth.controller.js';
import express from 'express';

const router = express.Router();

router.post('/sign-up', signup);

router.post('/sing-in', (req, res) => {
  res.send('POST /api/auth/sign-in response');
});

router.post('/sing-out', (req, res) => {
  res.send('POST /api/auth/sign-out response');
});

export default router;
