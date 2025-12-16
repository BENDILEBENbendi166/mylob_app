const admin = require('firebase-admin');
const serviceAccount = require('./mylob-ba4b4-firebase-adminsdk-fbsvc-8892eb988a.json');
const jsonData = require('./data.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

async function importData() {
  // Hotels
  for (const [id, hotel] of Object.entries(jsonData.hotels)) {
    await db.collection('hotels').doc(id).set(hotel);
    console.log('Hotel added:', id);
  }

  // Deals
  for (const [id, deal] of Object.entries(jsonData.deals)) {
    await db.collection('deals').doc(id).set(deal);
    console.log('Deal added:', id);
  }

  // Cities
  for (const [id, city] of Object.entries(jsonData.cities)) {
    await db.collection('cities').doc(id).set(city);
    console.log('City added:', id);
  }

  console.log('Import complete.');
}

importData().catch(console.error);
