const admin = require("firebase-admin");
const { v1: uuidv1 } = require("uuid");

const serviceAccount = require("./server.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

module.exports.createResource = async (event) => {
    const requestBody = JSON.parse(event.body);
  const { title, description, link, imageUrl, category,userId } = requestBody;
  const firestore =  admin.firestore();

  const v1options = {
    node: [0x01, 0x23, 0x45, 0x67, 0x89, 0xab],
    clockseq: 0x1234,
    msecs: new Date().getTime(),
    nsecs: 5678,
  };
  const id = uuidv1(v1options);

  const resourceRef = await firestore.collection("resource_test").doc(id);

  const newResource = {
    id: id,
    title,
    description,
    link,
    imageUrl,
    category,
    userId,
    isApproved: true,
  };

  console.log(newResource);

  try {
    await resourceRef.set(newResource);
    console.log("created resource");
  } catch (e) {
    console.log(e);
  }

  return {
    statusCode: 200,
    body: JSON.stringify({
      message: "Resource created successfully",
    }),
  };
}
