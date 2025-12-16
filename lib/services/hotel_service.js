// services/hotel_service.js
import { db } from "./firestore_connect";
import { collection, getDocs, query, where, orderBy } from "firebase/firestore";

export async function fetchHotels() {
  const snapshot = await getDocs(collection(db, "hotels"));
  return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
}

export async function fetchHotelsByCity(cityName) {
  const q = query(
    collection(db, "hotels"),
    where("city", "==", cityName),
    orderBy("basePrice")
  );
  const snapshot = await getDocs(q);
  return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
}
