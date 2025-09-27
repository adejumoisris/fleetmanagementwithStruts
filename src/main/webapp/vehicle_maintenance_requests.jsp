<%--
  Created by IntelliJ IDEA.
  User: deca
  Date: 15/09/2025
  Time: 2:00 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List of Vehicle Maintenance Requests</title>
    <link rel="stylesheet" href="dashboard.css">
<%--    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">--%>
    <style>
        /* --- inline search-panel styles, can also move to CSS file --- */
        .search-panel { background:#f8f9fa; border:1px solid #ddd; padding:15px; margin-bottom:20px; border-radius:5px; }
        .search-panel h3 { margin-top:0; color:#004466; }
        .search-row { display:flex; flex-wrap:wrap; gap:15px 30px; margin-bottom:10px; align-items:center; }
        .search-row label { font-weight:bold; flex-basis:120px; text-align:right; }
        .search-row select, .search-row input[type="text"], .search-row input[type="date"] { flex-grow:1; padding:8px; border:1px solid #ccc; border-radius:4px; font-size:14px; max-width:200px; }
        .search-status-options { display:flex; gap:15px; margin-top:15px; }
        .search-status-options label { font-weight:normal; text-align:left; }
        .search-buttons { margin-top:20px; display:flex; gap:10px; }
        .search-buttons button { padding:8px 15px; border:none; border-radius:4px; cursor:pointer; font-size:14px; }
        .search-buttons .search-btn { background-color:#007bff; color:white; }
        .search-buttons .clear-btn { background-color:#6c757d; color:white; }
        .list-section { background:#fff; border:1px solid #ddd; border-radius:5px; padding:20px; margin-top:20px; }
        .list-header { display:flex; justify-content:space-between; align-items:center; margin-bottom:15px; font-size:14px; color:#555; }
        .list-table { width:100%; border-collapse:collapse; font-size:13px; }
        .list-table th, .list-table td { border:1px solid #e9ecef; padding:8px 12px; text-align:left; }
        .list-table th { background:#f0f2f5; font-weight:bold; color:#333; }
        .list-table tr:nth-child(even) { background:#fcfcfc; }
        .list-table a { color:#007bff; text-decoration:none; }
        .list-table a:hover { text-decoration:underline; }
        .status-approved { color:green; font-weight:bold; }
        .status-complete { color:#28a745; font-weight:bold; }
        .status-started { color:orange; font-weight:bold; }
    </style>
</head>
<body>
<nav class="navbar">
    <ul>
        <li><a href="<s:url value='/dashboard.jsp'/>">DASHBOARD</a></li>
        <li><a href="#">JOURNEY MGMT</a></li>

        <li class="dropdown" id="fleet-mgmt-dropdown">
            <a href="#" class="dropdown-toggle" id="fleet-mgmt-toggle">FLEET MGMT ▾</a>
            <ul class="dropdown-menu">
                <li><a href="<s:url value='/vehicle_maintenance_requests.jsp'/>">List Of Vehicles</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle">Maintenance ▸</a>
                    <ul class="dropdown-submenu">
                        <li><a href="<s:url value='/dashboard.jsp'/>">New Request</a></li>
                    </ul>
                </li>
            </ul>
        </li>

        <li><a href="#">ASSET/INVENTORY MGMT</a></li>
        <li><a href="#">PROCUREMENT MGMT</a></li>
        <li><a href="#">LEASES</a></li>
        <li><a href="#">REFERENCES</a></li>
        <li><a href="#">USER ADMIN</a></li>
        <li><a href="#">REPORTS</a></li>
        <li><a href="#">HELP</a></li>
        <li class="user-info">User: <c:out value="${sessionScope.username}" default="SysServe Solutions"/>
            <a href="<s:url value='/logout'/>">Logout</a>
        </li>
        <li class="home-icon"><a href="<c:url value='/home.jsp'/>">Home</a></li>
    </ul>
</nav>

<main class="container">
    <div class="breadcrumb">
        LIST OF VEHICLE MAINTENANCE REQUESTS
    </div>

    <!-- Search Panel -->
    <section class="search-panel">
        <h3>DETAILS SEARCH</h3>
        <form method="get" action="<c:url value='/searchRequests'/>">
            <div class="search-row">
                <label for="request-no">Request No.</label>
                <input type="text" id="request-no" name="requestNo">

                <label for="office-search">Office</label>
                <select id="office-search" name="officeId">
                    <option value="">--Select Office--</option>
                    <c:forEach var="office" items="${offices}">
                        <option value="${office.id}">${office.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="search-row">
                <label for="client-search">Client</label>
                <select id="client-search" name="clientId">
                    <option value="">--Select Client--</option>
                    <c:forEach var="client" items="${clients}">
                        <option value="${client.id}">${client.name}</option>
                    </c:forEach>
                </select>

                <label for="vehicle-search">Vehicle</label>
                <select id="vehicle-search" name="vehicleId">
                    <option value="">--Select--</option>
                    <c:forEach var="vehicle" items="${vehicles}">
                        <option value="${vehicle.id}">${vehicle.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="search-row">
                <label for="submitted-date">Submitted Date</label>
                <input type="date" id="submitted-date" name="submittedDate">

                <label for="reported-by">Reported By</label>
                <select id="reported-by" name="reportedBy">
                    <option value="">--Select--</option>
                    <c:forEach var="reporter" items="${reporters}">
                        <option value="${reporter.id}">${reporter.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="search-row">
                <label for="workshop-search">Workshop</label>
                <select id="workshop-search" name="workshopId">
                    <option value="">--Select--</option>
                    <c:forEach var="workshop" items="${workshops}">
                        <option value="${workshop.id}">${workshop.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="search-row search-status-options">
                <label>Status</label>
                <c:forEach var="status" items="${statuses}">
                    <input type="checkbox" name="status" value="${status}" id="status-${status}">
                    <label for="status-${status}">${status}</label>
                </c:forEach>
            </div>

            <div class="search-buttons">
                <button type="submit" class="search-btn">Search</button>
                <button type="reset" class="clear-btn">Clear</button>
            </div>
        </form>
    </section>

    <!-- List Section -->
    <section class="list-section">
        <div class="list-header">
<%--            <div>${fn:length(requests)} Records Found</div>--%>
            <div>No of R...</div>
        </div>
        <table class="list-table">
            <thead>
            <tr>
                <th>#</th>
                <th>Date</th>
                <th>Life Time</th>
                <th>Vehicle/Mileage</th>
                <th>Workshop</th>
                <th>Office/Client</th>
                <th>Complaint</th>
                <th>Mainl. No</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>

            <tbody>
            <s:iterator value="requests" var="req" status="loop">
                <tr>
                    <td><s:property value="#loop.index + 1"/></td>
                    <td><s:property value="#req.mileageDate"/></td>
                    <td><s:property value="#req.mileageTime"/></td>
                    <td><s:property value="#req.vehicle"/> / <s:property value="#req.mileageDate"/></td>
                    <td><s:property value="#req.location"/></td>
                    <td><s:property value="#req.office"/> / <s:property value="#req.client"/></td>
                    <td><s:property value="#req.complaint"/></td>
                    <td><s:property value="#req.id"/></td>
                    <td>
                <span class="<s:property value="#req.status"/>">
                    <s:property value="#req.status"/>
                </span>
                    </td>
<%--                    Edit and delete table --%>
<%--                    update --%>
                    <td>
                        <s:url var="editUrl" action="editRequest">
                            <s:param name="id" value="%{#req.id}"/>
                        </s:url>
                        <a href="<s:property value='%{editUrl}'/>">Edit</a>
<%--                        Details  --%>

                        <s:url var="detailsUrl" action="viewRequest">
                            <s:param name="id" value="%{#req.id}"/>
                        </s:url>
                        <a href="<s:property value='%{detailsUrl}'/>">Details</a>

                    </td>
                </tr>
            </s:iterator>
            </tbody>
        </table>
        <a href="generateMaintenanceReport.action" target="_blank">Download PDF Report</a>

    </section>
</main>

<footer class="footer">
    <p>Copyright ©️ <a href="#">SysServe Solutions</a> All Rights Reserved</p>
    <p class="version">Version 10.0.0</p>
</footer>
</body>
</html>