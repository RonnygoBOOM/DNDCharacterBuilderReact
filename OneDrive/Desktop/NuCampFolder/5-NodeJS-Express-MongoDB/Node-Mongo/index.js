const MongoClient = require('mongodb').MongoClient;
const assert = require('assert').strict;

const url = 'mongodb://localhost:27017/';
const dbname = 'nucampsite';
const dboper = require('./operations');


//connect method allows us to connect to the MongoDB server.
MongoClient.connect(url, { useUnifiedTopology: true }, (err, client) => {
//if err is === null, continue, otherwise, if err === anything else, quit. assert also console logs the error
    assert.strictEqual(err, null);

    console.log('Connected correctly to server');

    const db = client.db(dbname);
//drop means DELETE. Don't drop anything by mistake. It can be hard to get back
db.dropCollection('campsites', (err, result) => {
    assert.strictEqual(err, null);
    console.log('Dropped Collection:', result);

    dboper.insertDocument(db, { name: "Breadcrumb Trail Campground", description: "Test"},
        'campsites', result => {
        console.log('Insert Document:', result.ops);

        dboper.findDocuments(db, 'campsites', docs => {
            console.log('Found Documents:', docs);

            dboper.updateDocument(db, { name: "Breadcrumb Trail Campground" },
                { description: "Updated Test Description" }, 'campsites',
                result => {
                    console.log('Updated Document Count:', result.result.nModified);

                    dboper.findDocuments(db, 'campsites', docs => {
                        console.log('Found Documents:', docs);
                        
                        dboper.removeDocument(db, { name: "Breadcrumb Trail Campground" },
                            'campsites', result => {
                                console.log('Deleted Document Count:', result.deletedCount);

                                client.close();
                            }
                        );
                    });
                }
            );
        });
    });
});
});