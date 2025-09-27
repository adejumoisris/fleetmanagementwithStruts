<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Fleet Mgmt - Maintenance Request</title>
  <link rel="stylesheet" href="dashboard.css">
  <style>
    .details-row { display: flex; margin-bottom: 8px; }
    .details-label { flex: 0 0 180px; font-weight: bold; color: #333; }
    .details-value { flex: 1; color: #555; }
    .list-table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    .list-table th, .list-table td { border: 1px solid #ccc; padding: 6px; text-align: left; }
    .list-table th { background: #f4f4f4; }
  </style>
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

<main class="container">
  <div class="breadcrumb">
    LIST OF VEHICLE MAINTENANCE REQUEST > MAINTENANCE REQUEST DETAILS
  </div>

  <section class="main-content">
    <!-- Tabs -->
    <div class="tabs">
      <button class="tab-button active" data-tab="details">DETAILS</button>
      <button class="tab-button" data-tab="files">FILES</button>
      <button class="tab-button" data-tab="past">PAST MAINTENANCE(S)</button>
      <button class="tab-button" data-tab="history">HISTORY</button>
    </div>

    <!-- DETAILS TAB -->
    <div class="tab-content" id="details" style="display:block;">
      <h3>Maintenance Request Details</h3>
      <div class="details-row"><div class="details-label">ID:</div><div class="details-value"><s:property value="record.id"/></div></div>
      <div class="details-row"><div class="details-label">Office:</div><div class="details-value"><s:property value="record.office"/></div></div>
      <div class="details-row"><div class="details-label">Client:</div><div class="details-value"><s:property value="record.client"/></div></div>
      <div class="details-row"><div class="details-label">Vehicle:</div><div class="details-value"><s:property value="record.vehicle"/></div></div>
      <div class="details-row"><div class="details-label">Complaint:</div><div class="details-value"><s:property value="record.complaint"/></div></div>
      <div class="details-row"><div class="details-label">Status:</div><div class="details-value"><s:property value="record.status"/></div></div>
    </div>

    <!-- FILES TAB -->
    <div class="tab-content" id="files" style="display:none;">
      <h3>Attached Files</h3>
      <s:if test="record.files != null && !record.files.isEmpty()">
        <ul>
          <s:iterator value="record.files" var="f">
            <li>
              <a href="downloadFile.action?id=<s:property value='#f.id'/>">
                <s:property value="#f.fileName"/>
              </a>
            </li>
          </s:iterator>
        </ul>
      </s:if>
      <s:else>
        <p style="color:red;">No files attached.</p>
      </s:else>
    </div>

    <!-- PAST MAINTENANCE TAB -->
    <div class="tab-content" id="past" style="display:none;">
      <h3>Past Maintenance Records for Vehicle: <s:property value="record.vehicle"/></h3>
      <s:if test="pastRecords != null && !pastRecords.isEmpty()">
        <table class="list-table">
          <thead>
          <tr>
            <th>Date</th>
            <th>Office</th>
            <th>Complaint</th>
            <th>Status</th>
          </tr>
          </thead>
          <tbody>
          <s:iterator value="pastRecords" var="pr">
            <tr>
              <td><s:property value="#pr.mileageDate"/></td>
              <td><s:property value="#pr.office"/></td>
              <td><s:property value="#pr.complaint"/></td>
              <td><s:property value="#pr.status"/></td>
            </tr>
          </s:iterator>
          </tbody>
        </table>
      </s:if>
      <s:else>
        <p style="color:red;">No past maintenance found for this vehicle.</p>
      </s:else>
    </div>

    <!-- HISTORY TAB -->
    <div class="tab-content" id="history" style="display:none;">
      <h3>Action History</h3>
      <s:if test="historyList != null && !historyList.isEmpty()">
        <table class="list-table">
          <thead>
          <tr>
            <th>User</th>
            <th>Action</th>
            <th>Details</th>
            <th>Timestamp</th>
          </tr>
          </thead>
          <tbody>
          <s:iterator value="historyList" var="h">
            <tr>
              <td><s:property value="#h.username"/></td>
              <td><s:property value="#h.action"/></td>
              <td><s:property value="#h.details"/></td>
              <td><s:property value="#h.timestamp"/></td>
            </tr>
          </s:iterator>
          </tbody>
        </table>
      </s:if>
      <s:else>
        <p style="color:red;">No history available for this request.</p>
      </s:else>
    </div>
  </section>
</main>

<!-- Footer -->
<footer class="footer">
  <p>Copyright ©️ <a href="#">SysServe Solutions</a> All Rights Reserved</p>
  <p class="version">Version 10.0.0</p>
</footer>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const tabButtons = document.querySelectorAll(".tab-button");
    const tabContents = document.querySelectorAll(".tab-content");

    tabButtons.forEach(button => {
      button.addEventListener("click", () => {
        tabButtons.forEach(btn => btn.classList.remove("active"));
        button.classList.add("active");
        tabContents.forEach(tab => tab.style.display = "none");

        const tabName = button.getAttribute("data-tab");
        document.getElementById(tabName).style.display = "block";
      });
    });
  });
</script>
</body>
</html>
