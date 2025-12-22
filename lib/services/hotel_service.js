import { db } from "./firestore_connect";
import { collection, getDocs, query, where, orderBy } from "firebase/firestore";

export async function fetchHotels() {
  try {
    const snapshot = await getDocs(collection(db, "hotels"));
    return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
  } catch (e) {
    console.error("Error fetching hotels:", e);
    return [];
  }
}

export async function fetchHotelsByCity(cityName) {
  try {
    const q = query(
      collection(db, "hotels"),
      where("city", "==", cityName),
      orderBy("basePrice")
    );
    const snapshot = await getDocs(q);
    return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
  } catch (e) {
    console.error("Error fetching hotels by city:", e);
    return [];
  }
}