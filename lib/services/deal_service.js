import { db } from "./firestore_connect";
import { collection, getDocs, query, where, orderBy } from "firebase/firestore";

export async function fetchDealsByHotel(hotelId) {
  try {
    const q = query(
      collection(db, "deals"),
      where("hotelId", "==", hotelId),
      orderBy("date")
    );
    const snapshot = await getDocs(q);
    return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
  } catch (e) {
    console.error("Error fetching deals:", e);
    return [];
  }
}
