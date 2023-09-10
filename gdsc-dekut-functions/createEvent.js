const admin = require("firebase-admin");
const { v1: uuidv1 } = require("uuid");

const serviceAccount = require("./server.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

module.exports.createEvent = async (event) => {
  const { title, description, venue, organizers, link, imageUrl, date } = event;
  const firestore =  admin.firestore();

  const v1options = {
    node: [0x01, 0x23, 0x45, 0x67, 0x89, 0xab],
    clockseq: 0x1234,
    msecs: new Date().getTime(),
    nsecs: 5678,
  };
  const id = uuidv1(v1options);

  const eventRef = await firestore.collection("event_test").doc(id);

  const newEvent = {
    id: id,
    title,
    description,
    venue,
    organizers,
    link,
    imageUrl,
    date,
    isCompleted: false,
    duration: 120,
  };

  console.log(newEvent);

  try {
    await eventRef.set(newEvent);
  } catch (e) {
    console.log(e);
  }

  return {
    statusCode: 200,
    body: JSON.stringify({
      message: "Event created successfully",
    }),
  };
}
