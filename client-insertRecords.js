const randomWords = require('random-words');

const { MongoClient } = require("mongodb");

// Pick up the MongoDB URI as an environment variable.
uri = process.env.URI;
console.log("Connecting to MongoDB at " + uri);

const client = new MongoClient(uri);

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

async function doInserts() {

  try {

    const database = client.db("MULTIDC");
    const appDB = database.collection("app1data");

    i=0;
    while (true) {

     start = new Date().getTime();
      // create a document to insert
      const doc = {
        'counter': i,
        content: randomWords(),
        timestamp: new Date()
      }
      const result = await appDB.insertOne(doc);
      console.log("Inserted record", i, "... latency(ms): ", ((new Date().getTime())-start));
      await sleep(1000);
      i++;

    }

  } finally {
    await client.close();
  }

}

doInserts();

