import { db } from "./firestore_connect";
import { collection, getDocs } from "firebase/firestore";
import { getDatabase, ref, get } from "firebase/database";

// Firestore
export async function fetchCitiesFirestore() {
  try {
    const snapshot = await getDocs(collection(db, "cities"));
    return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
  } catch (e) {
    console.error("Error fetching cities from Firestore:", e);
    return [];
  }
}

// Realtime Database
// export async function fetchCitiesRTDB() {
//   try {
//     const rtdb = getDatabase();
//     const snapshot = await get(ref(rtdb, "cities"));
//     if (snapshot.exists()) {
//       const data = snapshot.val();
//       return Object.entries(data).map(([id, value]) => ({ id, ...value }));
//     }
//     return [];
//   } catch (e) {
//     console.error("Error fetching cities from RTDB:", e);
//     return [];
//   }
// }