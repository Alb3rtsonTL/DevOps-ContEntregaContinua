// Theme toggle
const toggle = document.querySelector(".theme-toggle");
const root = document.documentElement;

const savedTheme = localStorage.getItem("theme");
if (savedTheme) root.dataset.theme = savedTheme;

toggle.addEventListener("click", () => {
  const next = root.dataset.theme === "dark" ? "light" : "dark";
  root.dataset.theme = next;
  localStorage.setItem("theme", next);
  toggle.textContent = next === "dark" ? "🌙" : "☀️";
});

// Auto year
document.getElementById("year").textContent = new Date().getFullYear();