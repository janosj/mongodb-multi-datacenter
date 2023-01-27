const { MongoClient } = require("mongodb");

// Pick up the MongoDB URI as an environment variable.
uri = process.env.URI;
console.log("Connecting to MongoDB at " + uri);

const client = new MongoClient(uri);

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

async function queryData() {

  try {

    const database = client.db("MULTIDC");
    const appDB = database.collection("app1data");

    while (true) {

     start = new Date().getTime();

      // an empty filter
      const query = { }

      const options = {
        // sort matched documents in descending order by count
        sort: { "timestamp": -1 },
      };

      const result = await appDB.findOne(query, options);
      console.log(result);
      console.log("... latency(ms): ", ((new Date().getTime())-start));
      await sleep(1000);

    }

  } finally {
    await client.close();
  }

}

queryData();

