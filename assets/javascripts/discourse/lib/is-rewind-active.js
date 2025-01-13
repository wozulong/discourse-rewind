export default function isRewindActive() {
  const currentDate = new Date();
  const currentMonth = currentDate.getMonth();
  return currentMonth === 0 || currentMonth === 11;
}
