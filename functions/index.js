const functions = require('firebase-functions');
const axios = require('axios');
const cors = require('cors')({ origin: true });

// 🔥 Your OpenAI Secret Key here (keep private)
const OPENAI_API_KEY = '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';

exports.parseTask = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    try {
      const { userInput } = req.body; // 👈 Get task input like "buy milk tomorrow"
      
      const response = await axios.post('https://api.openai.com/v1/chat/completions', {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "You are a helpful assistant that organizes tasks." },
          { role: "user", content: `Turn this into a structured task: ${userInput}` }
        ],
        temperature: 0.5
      }, {
        headers: {
          'Authorization': `Bearer ${OPENAI_API_KEY}`,
          'Content-Type': 'application/json'
        }
      });

      const structuredTask = response.data.choices[0].message.content.trim();
      console.log('Structured Task:', structuredTask); // Log the structured task
      res.status(200).send({ structuredTask });
      
    } catch (error) {
      console.error(error.response?.data || error.message);
      res.status(500).send('Something went wrong.');
    }
  });
});
