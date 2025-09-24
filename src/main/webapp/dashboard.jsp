<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fleet Mgmt Menu</title>
    <link rel="stylesheet" href="dashboard.css">


</head>
<body>
<nav class="navbar">
    <ul>
        <li><a href="dashboard.jsp">DASHBOARD</a></li>
        <li><a href="journeyMgmt.jsp">JOURNEY MGMT</a></li>

        <li class="dropdown" id="fleet-mgmt-dropdown">
            <a href="#" class="dropdown-toggle" id="fleet-mgmt-toggle">FLEET MGMT ▾</a>
            <ul class="dropdown-menu">
                <li><a href="<s:url action='listMaintenance'/>">List Of Maintenance Requests</a></li>

            <%--                <li><a href="vehicle_maintenance_requests.jsp">List Of Maintenance Requests </a></li>--%>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle">Maintenance ▸</a>
                    <ul class="dropdown-submenu">
                        <li><a href="index.jsp">New Request</a></li>
                    </ul>
                </li>
            </ul>
        </li>

        <li><a href="assetInventory.jsp">ASSET/INVENTORY MGMT</a></li>
        <li><a href="procurementMgmt.jsp">PROCUREMENT MGMT</a></li>
        <li><a href="leases.jsp">LEASES</a></li>
        <li><a href="references.jsp">REFERENCES</a></li>
        <li><a href="userAdmin.jsp">USER ADMIN</a></li>
        <li><a href="reports.jsp">REPORTS</a></li>
        <li><a href="help.jsp">HELP</a></li>
        <li class="user-info">User: <%= "SysServe Solutions" %> <a href="logout.jsp">Logout</a></li>
        <li class="home-icon"><a href="home.jsp">Home</a></li>
    </ul>
</nav>

<!-- Main Container -->
<main class="container">
    <div class="breadcrumb">
        LIST OF VEHICLE MAINTENANCE REQUEST > NEW VEHICLE MAINTENANCE REQUEST
    </div>

    <section class="main-content">
        <!-- Tabs -->
        <div class="tabs">
            <button class="tab-button active" data-tab="details">DETAILS</button>
            <button class="tab-button" data-tab="files">FILES</button>
            <button class="tab-button" data-tab="past">PAST MAINTENANCE(S)</button>
            <button class="tab-button" data-tab="history">HISTORY</button>
        </div>

        <!-- Tab content areas -->
        <div class="tab-content" id="details">
            <!-- details content -->
        </div>

        <!-- FILES TAB -->
        <div class="tab-content" id="filesTab" style="display:none; border:1px solid #ccc; padding:10px;">
            <form id="filesForm" enctype="multipart/form-data">
                <label for="fileUpload">
                    Attach File
                    <img src="paperclip_icon.png" alt="Attach" style="width:16px; vertical-align:middle;" />
                </label>
                <br/>
                <input type="file" id="fileUpload" name="fileUpload" multiple />

                <div id="fileMessage" style="margin-top:10px; color:red; font-size:14px;">
                    No file found
                </div>

                <!-- Success/Error -->
                <div id="filesFeedback" style="margin-top:10px; font-size:14px;"></div>

                <div style="margin-top:15px;">
                    <button type="submit">Submit</button>
                    <button type="button" style="background-color:green; color:white; margin-left:10px;">
                        Create Maintenance
                    </button>
                    <span style="color:red; margin-left:10px;">* Compulsory fields</span>
                </div>
            </form>
        </div>

        <!-- PAST MAINTENANCE(S) -->
        <div class="tab-content" id="past" style="display:none; border:1px solid #ccc; padding:10px;">
            <form id="pastForm">
                <div style="margin-bottom:10px;">
                    <label for="date">Date</label>
                    <input type="date" id="date" name="date" />

                    <label for="operator" style="margin-left:15px;">Operator</label>
                    <select id="operator" name="operator">
                        <option value="">--Select Operator--</option>
                        <option>Operator 1</option>
                        <option>Operator 2</option>
                    </select>

                    <label for="itemType" style="margin-left:15px;">Item Type</label>
                    <select id="itemType" name="itemType">
                        <option value="">--Select Type--</option>
                        <option>Type 1</option>
                        <option>Type 2</option>
                    </select>

                    <button type="button" id="filterBtn" style="margin-left:10px;">Filter</button>
                    <button type="button" id="clearBtn" style="margin-left:5px;">Clear</button>
                    <button type="button" id="refreshBtn" style="margin-left:5px;">Refresh</button>
                </div>

                <!-- Results table -->
                <div id="resultsBox" style="border:1px solid #ccc; padding:10px; min-height:100px;">
                    <strong>Vehicle -</strong>
                    <p style="color:red; text-align:center; margin-top:20px;">No result to display</p>
                </div>

                <!-- Success/Error -->
                <div id="pastFeedback" style="margin-top:10px; font-size:14px;"></div>

                <div style="margin-top:15px;">
                    <button type="submit">Submit</button>
                    <button type="button" style="background-color:green; color:white; margin-left:10px;">
                        Create Maintenance
                    </button>
                    <span style="color:red; margin-left:10px;">* Compulsory fields</span>
                </div>
            </form>
        </div>

        <div class="tab-content" id="history" style="display:none;">
            <!-- history content -->
        </div>
    </section>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const tabButtons = document.querySelectorAll(".tab-button");
            const tabContents = document.querySelectorAll(".tab-content");

            // Tab switching
            tabButtons.forEach(button => {
                button.addEventListener("click", () => {
                    tabButtons.forEach(btn => btn.classList.remove("active"));
                    button.classList.add("active");

                    tabContents.forEach(tab => tab.style.display = "none");

                    const tabName = button.getAttribute("data-tab");
                    if (tabName === "files") {
                        document.getElementById("filesTab").style.display = "block";
                    } else {
                        document.getElementById(tabName).style.display = "block";
                    }
                });
            });

            // FILES FORM
            const fileInput = document.getElementById("fileUpload");
            const fileMessage = document.getElementById("fileMessage");
            const filesForm = document.getElementById("filesForm");
            const filesFeedback = document.getElementById("filesFeedback");

            fileInput.addEventListener("change", function () {
                if (fileInput.files.length > 0) {
                    fileMessage.style.color = "green";
                    let fileList = "Files selected:<br>";
                    for (let i = 0; i < fileInput.files.length; i++) {
                        fileList += "- " + fileInput.files[i].name + "<br>";
                    }
                    fileMessage.innerHTML = fileList;
                } else {
                    fileMessage.style.color = "red";
                    fileMessage.textContent = "No file found";
                }
            });

            filesForm.addEventListener("submit", function (e) {
                e.preventDefault(); // stop real submit
                if (fileInput.files.length === 0) {
                    filesFeedback.style.color = "red";
                    filesFeedback.textContent = "❌ Please attach at least one file before submitting.";
                } else {
                    filesFeedback.style.color = "green";
                    filesFeedback.textContent = "✅ File(s) submitted successfully!";
                }
            });

            // PAST MAINTENANCE(S)
            const filterBtn = document.getElementById("filterBtn");
            const clearBtn = document.getElementById("clearBtn");
            const refreshBtn = document.getElementById("refreshBtn");
            const resultsBox = document.getElementById("resultsBox");
            const pastForm = document.getElementById("pastForm");
            const pastFeedback = document.getElementById("pastFeedback");

            filterBtn.addEventListener("click", () => {
                resultsBox.innerHTML = `
            <strong>Vehicle -</strong>
            <p style="color:green; text-align:center; margin-top:20px;">Filtered results (demo)</p>
        `;
            });

            clearBtn.addEventListener("click", () => {
                pastForm.reset();
                resultsBox.innerHTML = `
            <strong>Vehicle -</strong>
            <p style="color:red; text-align:center; margin-top:20px;">No result to display</p>
        `;
            });

            refreshBtn.addEventListener("click", () => {
                resultsBox.innerHTML = `
            <strong>Vehicle -</strong>
            <p style="color:red; text-align:center; margin-top:20px;">No result to display (refreshed)</p>
        `;
            });

            pastForm.addEventListener("submit", function (e) {
                e.preventDefault(); // stop real submit
                const date = document.getElementById("date").value;
                const operator = document.getElementById("operator").value;
                const itemType = document.getElementById("itemType").value;

                if (!date || !operator || !itemType) {
                    pastFeedback.style.color = "red";
                    pastFeedback.textContent = "❌ Please fill in all compulsory fields before submitting.";
                } else {
                    pastFeedback.style.color = "green";
                    pastFeedback.textContent = "✅ Maintenance form submitted successfully!";
                }
            });
        });
    </script>


        <!-- Tab Content -->
    <div class="tab-content">

        <s:form action="saveMaintenance" method="post" theme="simple">

        <!-- DETAILS -->
        <div class="tab-pane active" id="details">
            <div class="form-section">

                <div class="form-row">
                    <label for="office">Office*</label>
                    <s:select name="office" list="offices" headerKey="" headerValue="--Select--" />

                    <label for="client">Client</label>
                    <s:select name="client" list="clients" headerKey="" headerValue="--Select--" />
                </div>

                <div class="form-row">
                    <label for="vehicle">Vehicle*</label>
                    <s:select name="vehicle" list="vehicles" headerKey="" headerValue="--Select--" />

                    <label for="mileage-date">Mileage/Date</label>
                    <input type="text" id="mileage-date" name="mileageDate"
                           value="<%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date()) %>">
                    <input type="time" id="mileage-time" name="mileageTime"
                           value="<%= new java.text.SimpleDateFormat("HH:mm").format(new java.util.Date()) %>">
                </div>

                <div class="form-row">
                    <label for="driver">Driver</label>
                    <s:select name="driver" list="drivers" headerKey="" headerValue="--Select--" />

                    <label for="location">Location</label>
                    <input type="text" name="location" id="location" value="Workshop">
                </div>

                <div class="form-row">
                    <label for="faultType">Fault Type</label>
                    <s:select name="faultType" list="faultTypes" headerKey="" headerValue="--Select--" />
                </div>

                <div class="form-row full-width">
                    <label for="complaint">Complaint*</label>
                    <textarea id="complaint" name="complaint" rows="3"></textarea>
                </div>

                <!-- Status Section -->
                <div class="form-section">
                    <div class="form-row">
                        <label for="status">Status</label>
                        <s:select name="status" list="statuses" headerKey="" headerValue="--Select--" />
                    </div>
                </div>

                <div class="form-actions">
                    <s:submit cssClass="submit-button" value="Submit"/>
                    <a href="createMaintenance.jsp" class="action-link">Create Maintenance</a>
                    <span class="compulsory-fields">* Compulsory fields</span>
                </div>
            </div>
        </div>

        </s:form>



                <!-- FILES -->


                    <div class="tab-pane" id="files">
                        <h3>Upload & Manage Files</h3>
                        <input type="file" multiple>
                    </div>


                <!-- PAST MAINTENANCE -->
                <div class="tab-pane" id="past">
                    <h3>Past Maintenance Records</h3>
                    <div class="filter-section">
                        <label for="operator">Date</label>
                        <select id="operator">
                            <option value="">--Select Operator--</option>
                            <option value="=">Equal</option>
                            <option value=">">Before</option>
                            <option value="<">After</option>
                            <option value="between">Between</option>
                        </select>
                        <input type="date" id="date">

                        <label for="item-type">Item Type</label>
                        <select id="item-type">
                            <option value="">--Select Type--</option>
                            <option value="engine">Engine</option>
                            <option value="brakes">Brakes</option>
                            <option value="electrical">Electrical</option>
                        </select>

                        <button class="filter-btn">Filter</button>
                        <button class="clear-btn">Clear</button>
                        <button class="refresh-btn">Refresh</button>
                    </div>

                    <div class="results-box">
                        <p><strong>Vehicle - </strong> <span class="no-result">No result to display</span></p>
                    </div>
                </div>

                <!-- HISTORY -->
                <div class="tab-pane" id="history">
                    <h3>History</h3>
                    <p>Action logs will appear here.</p>
                </div>
                    <div>
            </div>

                </section>




</main>

<!-- Footer -->
<footer class="footer">
    <p>Copyright ©️ <a href="#">SysServe Solutions</a> All Rights Reserved</p>
    <p class="version">Version 10.0.0</p>
</footer>

<script src="script.js"></script>
</body>
</html>