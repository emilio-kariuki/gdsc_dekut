var admin = require("firebase-admin");

var serviceAccount = require("./server.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

module.exports.notifications = async (event) => {
  var message = "Notification not sent successfully";
  const firestore = admin.firestore();
  const query = await firestore.collection("event").get();
  const data = query.docs.map((doc) => doc.data());

  message = data;

  for (const event of data) {
    await sendNotification(event);
  }

  async function sendNotification(event) {
    const title = event.title;
    const body = event.description;
    const date = new Date(event.date);

    const currentTime = new Date();
    currentTime.setHours(currentTime.getHours() + 3);

    const eventTimeTimestamp = date.getTime();
    const currentTimeTimestamp = currentTime.getTime();

    const difference = eventTimeTimestamp - currentTimeTimestamp;

    const minutes = Math.ceil(difference / (1000 * 60));
    console.log("the event is in " + minutes + " minutes");
    const message = {
      notification: {
        title: "Your Event is about to start in " + ` ${minutes} minutes`,
        body: title,
      },
      android: {
        notification: {
          imageUrl: event.imageUrl,
        },
      },
      topic: "prod",
    };
    if (minutes === 1 || minutes === 60) {
      try {
        const response = await admin.messaging().send(message);
        console.log("Successfully sent message:", response);
      } catch (e) {
        console.log("error", e);
      }
    }
  }

  return {
    statusCode: 200,
    body: JSON.stringify(
      {
        message: message,
      },
      null,
      2
    ),
  };
};
