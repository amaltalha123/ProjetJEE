
document.addEventListener("DOMContentLoaded", function() {
    const roleSelect = document.getElementById("roleSelect");
    const telephoneField = document.getElementById("telephoneField");
    const abonnementField = document.getElementById("abonnementField");

    roleSelect.addEventListener("change", function() {
        if (this.value === "MANAGER") {
            telephoneField.style.display = "inline-block";
            abonnementField.style.display = "inline-block";
        } else {
            telephoneField.style.display = "none";
            abonnementField.style.display = "none";
        }
    });
});
