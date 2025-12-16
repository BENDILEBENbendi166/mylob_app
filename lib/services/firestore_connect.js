// services/firestore_connect.js
import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";
import { getAnalytics } from "firebase/analytics";

const firebaseConfig = {
  apiKey: "AIzaSyAY3gwbiFp6BSdGYtmHyhiE2jpwRErTcko",
  authDomain: "mylob-ba4b4.firebaseapp.com",
  databaseURL: "https://mylob-ba4b4-default-rtdb.europe-west1.firebasedatabase.app",
  projectId: "mylob-ba4b4",
  storageBucket: "mylob-ba4b4.firebasestorage.app",
  messagingSenderId: "879373771868",
  appId: "1:879373771868:web:fc31d3f6a898562bb97299",
  measurementId: "G-NPD7QSYGGB"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

// Initialize Firestore
const db = getFirestore(app);

// Initialize Analytics (optional)
const analytics = getAnalytics(app);

export { db, analytics };
