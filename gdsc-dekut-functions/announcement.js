var admin = require("firebase-admin");

var serviceAccount = require("./server.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

module.exports.notifications = async (event) => {
  const { title } = event;

  const message = {
    notification: {
      title: "New announcement!🤩🥳",
      body: title,
    },
    topic: "dev",
  };

  try {
    const response = await admin.messaging().send(message);
    console.log("Successfully sent message:", response);
  } catch (e) {
    console.log("error", e);
  }

  return {
    statusCode: 200,
    body: JSON.stringify(
      {
        message: "message sent successfully",
      },
      null,
      2
    ),
  };
};
