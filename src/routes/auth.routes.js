import express from 'express';

const router = express.Router();

router.post('/sing-up', (req, res) => {
  res.send('POST /api/auth/sign-up response');
});

router.post('/sing-in', (req, res) => {
  res.send('POST /api/auth/sign-in response');
});

router.post('/sing-out', (req, res) => {
  res.send('POST /api/auth/sign-out response');
});

export default router;
