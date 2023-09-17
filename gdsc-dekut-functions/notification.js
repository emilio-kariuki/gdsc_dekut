var admin = require("firebase-admin");

var serviceAccount = require("./server.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
module.exports.pushNotifications = async (event) => {
  const requestBody = JSON.parse(event.body);
  const { title, description, image, topic } = requestBody;

  const message = {
    notification: {
      title: title,
      body: description,
    },
    android: {
      notification: {
        imageUrl: image,
      },
    },
    topic: topic,
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
        message: event,
      },
      null,
      2
    ),
  };
};
