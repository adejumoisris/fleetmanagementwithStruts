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
<%--            <a href="files.jsp">--%>
            <button class="tab-button" data-tab="files">FILES</button>
<%--                </a>--%>
            <button class="tab-button" data-tab="past">PAST MAINTENANCE(S)</button>
            <button class="tab-button" data-tab="history">HISTORY</button>
        </div>
    </section>

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