// services/city_service.js
import { db } from "./firestore_connect";
import { collection, getDocs } from "firebase/firestore";

export async function fetchCities() {
  const snapshot = await getDocs(collection(db, "cities"));
  return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
}
