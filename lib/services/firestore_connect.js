import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";
import { getDatabase } from "firebase/database";
import { getAnalytics } from "firebase/analytics";

const firebaseConfig = { /* ... */ };

const app = initializeApp(firebaseConfig);

const db = getFirestore(app);
const rtdb = getDatabase(app);
const analytics = getAnalytics(app);

export { db, rtdb, analytics };