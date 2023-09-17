var admin = require("firebase-admin");

var serviceAccount = require("./server.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

module.exports.completeEvent = async (event) => {
  const firestore = admin.firestore();
  const query = await firestore.collection("event").get();
  const data = query.docs.map((doc) => doc.data());

  message = data;

  for (const event of data) {
    await completeAnEvent(event);
  }

  async function completeAnEvent(event) {
    const isCompleted = event.isCompleted;
    const date = new Date(event.date);

    const currentTime = new Date();
    currentTime.setHours(currentTime.getHours() + 3);

    const eventTimeTimestamp = date.getTime();
    const currentTimeTimestamp = currentTime.getTime();

    const difference = eventTimeTimestamp - currentTimeTimestamp;

    const minutes = Math.ceil(difference / (1000 * 60));
    if (minutes === -119 && !isCompleted) {
      try {
        await firestore
          .collection("event")
          .doc(event.id)
          .update({ isCompleted: true });

        console.log("Event completed successfully");
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
