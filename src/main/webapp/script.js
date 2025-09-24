document.addEventListener("DOMContentLoaded", function () {
    const fleetMgmtToggle = document.getElementById("fleet-mgmt-toggle");
    const fleetMgmtDropdown = document.getElementById("fleet-mgmt-dropdown");

    if (fleetMgmtToggle && fleetMgmtDropdown) {
        fleetMgmtToggle.addEventListener("click", function (e) {
            e.preventDefault();
            fleetMgmtDropdown.classList.toggle("active");

            document.querySelectorAll(".dropdown").forEach((li) => {
                if (li !== fleetMgmtDropdown && li.classList.contains("active")) {
                    li.classList.remove("active");
                }
            });
        });
    }

    const otherDropdownToggles = document.querySelectorAll(
        ".dropdown-toggle:not(#fleet-mgmt-toggle)"
    );

    otherDropdownToggles.forEach((toggle) => {
        toggle.addEventListener("click", function (e) {
            e.preventDefault();
            const parentLi = this.parentElement;

            let currentDropdown = parentLi;
            while (currentDropdown && currentDropdown.classList.contains("dropdown")) {
                if (currentDropdown !== fleetMgmtDropdown) {
                    currentDropdown.classList.toggle("active");
                }
                currentDropdown = currentDropdown.parentElement.closest(".dropdown");
            }

            document.querySelectorAll(".dropdown").forEach((li) => {
                if (li !== parentLi && li.classList.contains("active")) {
                    li.classList.remove("active");
                }
            });

            parentLi.classList.toggle("active");
        });
    });

    document.addEventListener("click", function (e) {
        if (!e.target.closest(".dropdown")) {
            document.querySelectorAll(".dropdown").forEach((li) => {
                li.classList.remove("active");
            });
        }
    });

    const tabButtons = document.querySelectorAll(".tab-button");
    const tabPanes = document.querySelectorAll(".tab-pane");

    tabButtons.forEach((button) => {
        button.addEventListener("click", function () {
            tabButtons.forEach((btn) => btn.classList.remove("active"));
            tabPanes.forEach((pane) => pane.classList.remove("active"));

            this.classList.add("active");
            const targetTab = this.dataset.tab;
            document.getElementById(targetTab).classList.add("active");
        });
    });
});

function toggleComments() {
    const body = document.getElementById("commentsBody");
    const icon = document.getElementById("expandIcon");

    if (body.style.display === "block") {
        body.style.display = "none";
        icon.classList.remove("open");
    } else {
        body.style.display = "block";
        icon.classList.add("open");
    }
}

function showSelected() {
    const select = document.getElementById("assign");
    const display = document.getElementById("displayArea");
    let names = [];
    for (let option of select.selectedOptions) {
        names.push(option.text);
    }
    display.innerText = names.join(", ");
}

function showSelected1() {
    const select = document.getElementById("notify");
    const display = document.getElementById("selectedNamesInput");

    let names = [];
    for (let option of select.selectedOptions) {
        names.push(option.text); // get visible label from dropdown
    }

    // Show names beside input
    display.value = names.join(", ");
}
    document.addEventListener("DOMContentLoaded", function () {
    const tabButtons = document.querySelectorAll(".tab-button");
    const tabContents = document.querySelectorAll(".tab-content");

    // Handle tab switching
    tabButtons.forEach(button => {
    button.addEventListener("click", () => {
    // Remove active class from all buttons
    tabButtons.forEach(btn => btn.classList.remove("active"));

    // Add active class to clicked button
    button.classList.add("active");

    // Hide all tab contents
    tabContents.forEach(tab => tab.style.display = "none");

    // Get which tab was clicked
    const tabName = button.getAttribute("data-tab");

    // Show the right tab
    if (tabName === "files") {
    document.getElementById("filesTab").style.display = "block";
} else {
    document.getElementById(tabName).style.display = "block";
}
});
});

    // Handle file upload message
    const fileInput = document.getElementById("fileUpload");
    const messageDiv = fileInput.nextElementSibling; // The "No file found" div

    fileInput.addEventListener("change", function () {
    if (fileInput.files.length > 0) {
    messageDiv.style.color = "green";
    messageDiv.textContent = "File selected: " + fileInput.files[0].name;
} else {
    messageDiv.style.color = "red";
    messageDiv.textContent = "No file found";
}
});
});
