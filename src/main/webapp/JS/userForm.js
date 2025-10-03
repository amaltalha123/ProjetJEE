const roleSelect = document.getElementById("roleSelect");
const telephoneField = document.getElementById("telephoneField");
const abonnementField = document.getElementById("abonnementField");

roleSelect.addEventListener("change", () => {
    if (roleSelect.value === "MANAGER") {
        telephoneField.style.display = "block";
        abonnementField.style.display = "block";
    } else {
        telephoneField.style.display = "none";
        abonnementField.style.display = "none";
    }
});
